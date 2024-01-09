import UIKit
import Alamofire
import RealmSwift
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var averageVoteLabel: UILabel!
    @IBOutlet weak var mediaTypeLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func addToFavoritesButtonPressed(_ sender: Any) {
        saveButtonPressed()
    }
    
    let baseURL = "https://image.tmdb.org/t/p/original"
    var dataTypeIndex = 0
    var selectedTopMovie: RealmTopMovie?
    var selectedTopTvShow: RealmTopTvShow?
    var selectedSearchedMovie: RealmSearchedMovie?
    var selectedSearchedTvShow: RealmSearchedTvShow?
    var selectedFavoriteMovie: RealmFavoritMovie?
    var selectedFavoriteTvshow: RealmFavoritTvShow?
    var imageString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheMovie()
        let imageURLString = URL(string: (baseURL + imageString))
        imageView.sd_setImage(with: imageURLString)
        setupColorsAndNames()
    }
}

extension DetailViewController {

    func setTheMovie() {
        switch dataTypeIndex {
        case 1:
            nameLabel.text = selectedSearchedMovie?.title
            overviewLabel.text = selectedSearchedMovie?.overview
            releaseDateLabel.text = "Release: " + (selectedSearchedMovie?.release_date ?? "")
            originalLanguageLabel.text = "Original language: " + (selectedSearchedMovie?.original_language ?? "")
            idLabel.text = "ID: " + String(selectedSearchedMovie?.id ?? 0)
            averageVoteLabel.text = "Average rating: \(String(selectedSearchedMovie?.vote_average ?? 0))"
            mediaTypeLabel.text = "Media type: \(selectedSearchedMovie?.media_type ?? "")"
            if selectedSearchedMovie?.adult == true {
                adultLabel.text = "18+"
            } else {
                adultLabel.text = "No age restrictions"
            }
            imageString = selectedSearchedMovie?.backdrop_path ?? ""
        case 2:
            nameLabel.text = selectedSearchedTvShow?.name
            overviewLabel.text = selectedSearchedTvShow?.overview
            releaseDateLabel.text = "Release: " + (selectedSearchedTvShow?.first_air_date ?? "")
            originalLanguageLabel.text = "Original language: " + (selectedSearchedTvShow?.original_language ?? "")
            idLabel.text = "ID: " + String(selectedSearchedTvShow?.id ?? 0)
            averageVoteLabel.text = "Average rating: \(String(selectedSearchedTvShow?.vote_average ?? 0))"
            mediaTypeLabel.text = "Media type: \(selectedSearchedTvShow?.media_type ?? "")"
            if selectedSearchedTvShow?.adult == true {
                adultLabel.text = "18+"
            } else {
                adultLabel.text = "No age restrictions"
            }
            imageString = selectedSearchedTvShow?.backdrop_path ?? ""
        case 3:
            nameLabel.text = selectedTopMovie?.title
            overviewLabel.text = selectedTopMovie?.overview
            releaseDateLabel.text = "Release: " + (selectedTopMovie?.release_date ?? "")
            originalLanguageLabel.text = "Original language: " + (selectedTopMovie?.original_language ?? "")
            idLabel.text = "ID: " + String(selectedTopMovie?.id ?? 0)
            averageVoteLabel.text = "Average rating: \(String(selectedTopMovie?.vote_average ?? 0))"
            mediaTypeLabel.text = "Media type: \(selectedTopMovie?.media_type ?? "")"
            if selectedTopMovie?.adult == true {
                adultLabel.text = "18+"
            } else {
                adultLabel.text = "No age restrictions"
            }
            imageString = selectedTopMovie?.backdrop_path ?? ""
        case 4:
            nameLabel.text = selectedTopTvShow?.name
            overviewLabel.text = selectedTopTvShow?.overview
            releaseDateLabel.text = "Release: " + (selectedTopTvShow?.first_air_date ?? "")
            originalLanguageLabel.text = "Original language: " + (selectedTopTvShow?.original_language ?? "")
            idLabel.text = "ID: " + String(selectedTopTvShow?.id ?? 0)
            averageVoteLabel.text = "Average rating: \(String(selectedTopTvShow?.vote_average ?? 0))"
            mediaTypeLabel.text = "Media type: \(selectedTopTvShow?.media_type ?? "")"
            if selectedTopTvShow?.adult == true {
                adultLabel.text = "18+"
            } else {
                adultLabel.text = "No age restrictions"
            }
            imageString = selectedTopTvShow?.backdrop_path ?? ""
        case 5:
            nameLabel.text = selectedFavoriteMovie?.title
            overviewLabel.text = selectedFavoriteMovie?.overview
            releaseDateLabel.text = "Release: " + (selectedFavoriteMovie?.release_date ?? "")
            originalLanguageLabel.text = "Original language: " + (selectedFavoriteMovie?.original_language ?? "")
            idLabel.text = "ID: " + String(selectedFavoriteMovie?.id ?? 0)
            averageVoteLabel.text = "Average rating: \(String(selectedFavoriteMovie?.vote_average ?? 0))"
            mediaTypeLabel.text = "Media type: \(selectedFavoriteMovie?.media_type ?? "")"
            if selectedFavoriteMovie?.adult == true {
                adultLabel.text = "18+"
            } else {
                adultLabel.text = "No age restrictions"
            }
            imageString = selectedFavoriteMovie?.backdrop_path ?? ""
        case 6:
            nameLabel.text = selectedFavoriteTvshow?.name
            overviewLabel.text = selectedFavoriteTvshow?.overview
            releaseDateLabel.text = "Release: " + (selectedFavoriteTvshow?.first_air_date ?? "")
            originalLanguageLabel.text = "Original language: " + (selectedFavoriteTvshow?.original_language ?? "")
            idLabel.text = "ID: " + String(selectedFavoriteTvshow?.id ?? 0)
            averageVoteLabel.text = "Average rating: \(String(selectedFavoriteTvshow?.vote_average ?? 0))"
            mediaTypeLabel.text = "Media type: \(selectedFavoriteTvshow?.media_type ?? "")"
            if selectedFavoriteTvshow?.adult == true {
                adultLabel.text = "18+"
            } else {
                adultLabel.text = "No age restrictions"
            }
            imageString = selectedFavoriteTvshow?.backdrop_path ?? ""
        default:
            print("Error with getting data")
        }
    }
    
    func setupColorsAndNames() {
        overviewLabel.layer.cornerRadius = 45
        overviewLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 30
        nameLabel.layer.masksToBounds = true
        releaseDateLabel.layer.cornerRadius = 10
        releaseDateLabel.layer.masksToBounds = true
        originalLanguageLabel.layer.cornerRadius = 10
        originalLanguageLabel.layer.masksToBounds = true
        idLabel.layer.cornerRadius = 10
        idLabel.layer.masksToBounds = true
        mediaTypeLabel.layer.cornerRadius = 10
        mediaTypeLabel.layer.masksToBounds = true
        averageVoteLabel.layer.cornerRadius = 10
        averageVoteLabel.layer.masksToBounds = true
        adultLabel.layer.cornerRadius = 10
        adultLabel.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        nameLabel.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 1)
        overviewLabel.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 1)
        idLabel.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)
        originalLanguageLabel.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)
        adultLabel.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)
        releaseDateLabel.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)
        mediaTypeLabel.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)
        averageVoteLabel.backgroundColor = UIColor(red: 222/255, green: 197/255, blue: 141/255, alpha: 0.5)
    }
    
    func saveButtonPressed() {
        switch dataTypeIndex {
        case 1:
            guard let selectedSearchedMovie = selectedSearchedMovie else {
                print("Selected Searched movie is nil")
                return
            }
            do {
                let realm = try Realm()
                if realm.object(ofType: RealmFavoritMovie.self, forPrimaryKey: selectedSearchedMovie.id) != nil {
                    print("Movie is already in favorites")
                    return
                }
                guard let searchedMovie = DataManager.shared.copyToFavoriteMovie(from: selectedSearchedMovie) else {
                    print("Failed to copy movie to favorite")
                    return
                }
                try realm.write {
                    realm.add(searchedMovie)
                    print("Movie saved successfully")
                }
            } catch {
                print("Error saving movie to Realm: \(error)")
            }
        case 2:
            guard let selectedSearchedTvShow = selectedSearchedTvShow else {
                print("Selected Searched Tv Show is nil")
                return
            }
            do {
                let realm = try Realm()
                if realm.object(ofType: RealmFavoritTvShow.self, forPrimaryKey: selectedSearchedTvShow.id) != nil {
                    print("Tv Show is already in favorites")
                    return
                }
                guard let searchedTvShow = DataManager.shared.copyToFavoriteTvShow(from: selectedSearchedTvShow) else {
                    print("Failed to copy Tv Show to favorite")
                    return
                }
                try realm.write {
                    realm.add(searchedTvShow)
                    print("Tv Show saved successfully")
                }
            } catch {
                print("Error saving Tv Show to Realm: \(error)")
            }
        case 3:
            guard let selectedTopMovie = selectedTopMovie else {
                print("Selected movie is nil")
                return
            }
            do {
                let realm = try Realm()
                if realm.object(ofType: RealmFavoritMovie.self, forPrimaryKey: selectedTopMovie.id) != nil {
                    print("Movie is already in favorites")
                    return
                }
                guard let favoritMovieObject = DataManager.shared.copyToFavoriteMovie(from: selectedTopMovie) else {
                    print("Failed to copy movie to favorite")
                    return
                }
                try realm.write {
                    realm.add(favoritMovieObject)
                    print("Movie saved successfully")
                }
            } catch {
                print("Error saving movie to Realm: \(error)")
            }
        case 4:
            guard let selectedTopTvShow = selectedTopTvShow else {
                print("Selected TV show is nil")
                return
            }
            do {
                let realm = try Realm()
                if realm.object(ofType: RealmFavoritTvShow.self, forPrimaryKey: selectedTopTvShow.id) != nil {
                    print("TV show is already in favorites")
                    return
                }
                guard let favoritTvShowObject = DataManager.shared.copyToFavoriteTvShow(from: selectedTopTvShow) else {
                    print("Failed to copy TV show to favorite")
                    return
                }
                try realm.write {
                    realm.add(favoritTvShowObject)
                    print("TV show saved successfully")
                }
            } catch {
                print("Error saving TV show to Realm: \(error)")
            }
        default:
            print("Invalid dataTypeIndex")
        }
    }
}



