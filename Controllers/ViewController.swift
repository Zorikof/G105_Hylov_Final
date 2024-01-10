import UIKit
import RealmSwift
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var centralTableView: UITableView!
    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    
    var isSearching = false
    let baseURL = "https://image.tmdb.org/t/p/original"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Commit on GH Test
        DataManager.shared.clearTopItemsInRealm()
        Requests.shared.fetchAndSaveTopMovies(completion: updateUI)
        Requests.shared.fetchAndSaveTopTvShows(completion: updateUI)
        setTabBarSrttings()
        self.topSegmentedControl.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)
        
        topSegmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        centralTableView.register(UINib(nibName: "ItemCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCellTableViewCell")
        updateUI()
    }
}

//MARK: - TableView Cell

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let moviesCount: Int
        let tvShowsCount: Int

        if isSearching {
            moviesCount = DataManager.shared.getSearchedMovies().count
            tvShowsCount = DataManager.shared.getSearchedTvShows().count
        } else {
            moviesCount = DataManager.shared.getTopMovies().count
            tvShowsCount = DataManager.shared.getTopTvShows().count
        }

        switch topSegmentedControl.selectedSegmentIndex {
        case 0:
            return moviesCount
        case 1:
            return tvShowsCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCellTableViewCell", for: indexPath) as? ItemCellTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let imageURLString: String
        let title: String
        if isSearching {
            switch topSegmentedControl.selectedSegmentIndex {
            case 0:
                let movie = DataManager.shared.getSearchedMovies()[indexPath.row]
                title = movie.title
                imageURLString = baseURL + (movie.backdrop_path ?? "")
                cell.cellNameLabel.text = title
                let imageURL = URL(string: imageURLString)
                cell.cellImageVIew.sd_setImage(with: imageURL)
            case 1:
                let tvShow = DataManager.shared.getSearchedTvShows()[indexPath.row]
                title = tvShow.name
                imageURLString = baseURL + (tvShow.backdrop_path ?? "")
                cell.cellNameLabel.text = title
                let imageURL = URL(string: imageURLString)
                cell.cellImageVIew.sd_setImage(with: imageURL)
            default:
                return cell
            }
        } else {
            switch topSegmentedControl.selectedSegmentIndex {
            case 0:
                let movie = DataManager.shared.getTopMovies()[indexPath.row]
                title = movie.title
                imageURLString = baseURL + (movie.backdrop_path ?? "")
                cell.cellNameLabel.text = title
                let imageURL = URL(string: imageURLString)
                cell.cellImageVIew.sd_setImage(with: imageURL)
            case 1:
                let tvShow = DataManager.shared.getTopTvShows()[indexPath.row]
                title = tvShow.name
                imageURLString = baseURL + (tvShow.backdrop_path ?? "")
                cell.cellNameLabel.text = title
                let imageURL = URL(string: imageURLString)
                cell.cellImageVIew.sd_setImage(with: imageURL)
            default:
                return cell
            }
        }
        return cell
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
    
    func setTabBarSrttings() {
        self.tabBarController?.tabBar.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)
        
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

