import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var updateClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
        self.segmentedControl.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)

    }
}

//MARK: - TableView Cell
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0: return DataManager.shared.getFavoriteMovies().count
        case 1: return DataManager.shared.getFavoriteTvShows().count
        default:
            print("Error getting numberOfRowsInSection in FavoriteVC")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        cell.selectionStyle = .none
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = DataManager.shared.getFavoriteMovies()[indexPath.row].title
        } else {
            cell.textLabel?.text = DataManager.shared.getFavoriteTvShows()[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let realm = try! Realm()
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                let movieToDelete = DataManager.shared.getFavoriteMovies()[indexPath.row]
                try! realm.write {
                    realm.delete(movieToDelete)
                }
            case 1:
                let tvShowToDelete = DataManager.shared.getFavoriteTvShows()[indexPath.row]
                try! realm.write {
                    realm.delete(tvShowToDelete)
                }
            default:
                print("Error while try to delete in FavoritesVC")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            navigationController?.pushViewController(detailViewController, animated: true)
            print("Selected index: \(indexPath.row)")
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                let selectedMovie = DataManager.shared.getFavoriteMovies()[indexPath.row]
                detailViewController.selectedFavoriteMovie = selectedMovie
                detailViewController.dataTypeIndex = 5
            case 1:
                let tvShowToVIew = DataManager.shared.getFavoriteTvShows()[indexPath.row]
                detailViewController.selectedFavoriteTvshow = tvShowToVIew
                detailViewController.dataTypeIndex = 6
            default:
                print("Error transfering data to DetailVC")
            }
        }
    }
}

//MARK: - Segmented Control

extension FavoritesViewController {
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        updateUI()
    }
    
    func updateUI() {
        self.tableView.reloadData()
    }
}



