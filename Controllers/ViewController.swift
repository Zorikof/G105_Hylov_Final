import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var centralTableView: UITableView!
    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.shared.clearTopItemsInRealm()
        Requests.shared.fetchAndSaveTopMovies(completion: updateUI)
        Requests.shared.fetchAndSaveTopTvShows(completion: updateUI)
        setTabBarIcons()
        
        topSegmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        centralTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        updateUI()
    }
}

//MARK: - TableView Cell

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch topSegmentedControl.selectedSegmentIndex {
        case 0:
            if isSearching {
                return DataManager.shared.getSearchedMovies().count
            } else {
                return DataManager.shared.getTopMovies().count
            }
        case 1:
            if isSearching {
                return DataManager.shared.getSearchedTvShows().count
            } else {
                return DataManager.shared.getTopTvShows().count
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        if isSearching {
            switch topSegmentedControl.selectedSegmentIndex {
            case 0:
                let movie = DataManager.shared.getSearchedMovies()[indexPath.row]
                cell.textLabel?.text = movie.title
                return cell
            case 1:
                let tvShow = DataManager.shared.getSearchedTvShows()[indexPath.row]
                cell.textLabel?.text = tvShow.name
                return cell
            default:
                return cell
            }
        } else {
            switch topSegmentedControl.selectedSegmentIndex {
            case 0:
                let movie = DataManager.shared.getTopMovies()[indexPath.row]
                cell.textLabel?.text = movie.title
                return cell
            case 1:
                let tvShow = DataManager.shared.getTopTvShows()[indexPath.row]
                cell.textLabel?.text = tvShow.name
                return cell
            default:
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            navigationController?.pushViewController(detailViewController, animated: true)
            print("Selected index: \(indexPath.row)")
            
            if isSearching {
                switch topSegmentedControl.selectedSegmentIndex {
                case 0:
                    let selectedMovie = DataManager.shared.getSearchedMovies()[indexPath.row]
                    detailViewController.selectedSearchedMovie = selectedMovie
                    detailViewController.dataTypeIndex = 1
                case 1:
                    let selectedTvShow = DataManager.shared.getSearchedTvShows()[indexPath.row]
                    detailViewController.selectedSearchedTvShow = selectedTvShow
                    detailViewController.dataTypeIndex = 2
                default:
                    break
                }
            } else {
                switch topSegmentedControl.selectedSegmentIndex {
                case 0:
                    let movieToView = DataManager.shared.getTopMovies()[indexPath.row]
                    detailViewController.selectedTopMovie = movieToView
                    detailViewController.dataTypeIndex = 3
                case 1:
                    let tvShowToVIew = DataManager.shared.getTopTvShows()[indexPath.row]
                    detailViewController.selectedTopTvShow = tvShowToVIew
                    detailViewController.dataTypeIndex = 4
                default:
                    print("Error transfering data to DetailVC")
                }
            }
        }
    }
}

//MARK: - SegmentedControl And TabBar

extension ViewController {
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch topSegmentedControl.selectedSegmentIndex {
        case 0:
            updateUI()
        case 1:
            updateUI()
        default:
            break
        }
    }
    
    func updateUI() {
        centralTableView.reloadData()
    }
    
    func setTabBarIcons() {
        if let firstTabBarItem = self.tabBarController?.tabBar.items?[0] {
            firstTabBarItem.image = UIImage(systemName: "film.fill")
        }
        if let secondTabBarItem = self.tabBarController?.tabBar.items?[1] {
            secondTabBarItem.image = UIImage(systemName: "star.fill")
        }
    }
}

//MARK: - Search Bar

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DataManager.shared.clearSearchedItemsInRealm()
        isSearching = true
        let currentSearchText = searchText
        delayForRequest {
            if self.topSegmentedControl.selectedSegmentIndex == 0 {
                Requests.shared.fetchAndSaveSearchedMovies(request: currentSearchText)
                print("searching: \(currentSearchText)")
                self.updateUI()
            } else {
                Requests.shared.fetchAndSaveSearchedTvShows(request: currentSearchText)
                print("searching: \(currentSearchText)")
                self.updateUI()
            }
        
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        Requests.shared.fetchAndSaveTopMovies(completion: updateUI)
        Requests.shared.fetchAndSaveTopTvShows(completion: updateUI)
    }
    
    func delayForRequest(completion: @escaping () -> Void) {
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}

