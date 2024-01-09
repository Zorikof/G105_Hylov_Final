import Foundation
import Alamofire
import RealmSwift

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    //MARK: - TopMovies
    
    func getTopMovies() -> [RealmTopMovie] {
        do {
            let realm = try Realm()
            return Array(realm.objects(RealmTopMovie.self))
        } catch {
            print("Error fetching Top Movies from Realm: \(error)")
            return []
        }
    }
    
    func getTopTvShows() -> [RealmTopTvShow] {
        do {
            let realm = try Realm()
            return Array(realm.objects(RealmTopTvShow.self))
        } catch {
            print("Error fetching Top TvShows from Realm: \(error)")
            return []
        }
    }
    
    func clearTopItemsInRealm() {
        do {
            let realm = try Realm()
            try realm.write {
                let tvShows = realm.objects(RealmTopTvShow.self)
                let movies = realm.objects(RealmTopMovie.self)
                realm.delete(tvShows)
                realm.delete(movies)
            }
        } catch {
            print("Error clearing TopRealm: \(error.localizedDescription)")
        }
    }
    
    //MARK: - SearchedMovies
    
    func getSearchedMovies() -> [RealmSearchedMovie] {
        do {
            let realm = try Realm()
            return Array(realm.objects(RealmSearchedMovie.self))
        } catch {
            print("Error fetching Searched Movies from Realm: \(error)")
            return []
        }
    }
    
    func getSearchedTvShows() -> [RealmSearchedTvShow] {
        do {
            let realm = try Realm()
            return Array(realm.objects(RealmSearchedTvShow.self))
        } catch {
            print("Error fetching Searched TvShows from Realm: \(error)")
            return []
        }
    }
    
    func clearSearchedItemsInRealm() {
        do {
            let realm = try Realm()
            try realm.write {
                let tvShows = realm.objects(RealmTopTvShow.self)
                let movies = realm.objects(RealmSearchedMovie.self)
                realm.delete(tvShows)
                realm.delete(movies)
            }
        } catch {
            print("Error clearing SearchedRealm: \(error.localizedDescription)")
        }
    }
    
    //MARK: - FavoritMovies
    
    func copyToFavoriteMovie(from source: RealmTopMovie) -> RealmFavoritMovie? {
        let destination = RealmFavoritMovie()
        destination.adult = source.adult
        destination.backdrop_path = source.backdrop_path
        destination.id = source.id
        destination.title = source.title
        destination.original_language = source.original_language
        destination.original_title = source.original_title
        destination.overview = source.overview
        destination.poster_path = source.poster_path
        destination.media_type = source.media_type
        destination.genre_ids.removeAll()
        destination.genre_ids.append(objectsIn: source.genre_ids)
        destination.popularity = source.popularity
        destination.release_date = source.release_date
        destination.video = source.video
        destination.vote_average = source.vote_average
        destination.vote_count = source.vote_count
        return destination
    }
    
    func copyToFavoriteMovie(from source: RealmSearchedMovie) -> RealmFavoritMovie? {
        let destination = RealmFavoritMovie()
        destination.adult = source.adult
        destination.backdrop_path = source.backdrop_path
        destination.id = source.id
        destination.title = source.title
        destination.original_language = source.original_language
        destination.original_title = source.original_title
        destination.overview = source.overview
        destination.poster_path = source.poster_path
        destination.media_type = source.media_type
        destination.genre_ids.removeAll()
        destination.genre_ids.append(objectsIn: source.genre_ids)
        destination.popularity = source.popularity
        destination.release_date = source.release_date
        destination.video = source.video
        destination.vote_average = source.vote_average
        destination.vote_count = source.vote_count
        return destination
    }
    
    func copyToFavoriteTvShow(from source: RealmTopTvShow) -> RealmFavoritTvShow? {
        let destination = RealmFavoritTvShow()
        destination.adult = source.adult
        destination.backdrop_path = source.backdrop_path
        destination.id = source.id
        destination.name = source.name
        destination.original_language = source.original_language
        destination.original_name  = source.original_name
        destination.overview = source.overview
        destination.poster_path = source.poster_path
        destination.media_type = source.media_type
        destination.genre_ids.removeAll()
        destination.genre_ids.append(objectsIn: source.genre_ids)
        destination.popularity = source.popularity
        destination.first_air_date = source.first_air_date
        destination.vote_average = source.vote_average
        destination.vote_count = source.vote_count
        return destination
    }
    
    func copyToFavoriteTvShow(from source: RealmSearchedTvShow) -> RealmFavoritTvShow? {
        let destination = RealmFavoritTvShow()
        destination.adult = source.adult
        destination.backdrop_path = source.backdrop_path
        destination.id = source.id
        destination.name = source.name
        destination.original_language = source.original_language
        destination.original_name  = source.original_name
        destination.overview = source.overview
        destination.poster_path = source.poster_path
        destination.media_type = source.media_type
        destination.genre_ids.removeAll()
        destination.genre_ids.append(objectsIn: source.genre_ids)
        destination.popularity = source.popularity
        destination.first_air_date = source.first_air_date
        destination.vote_average = source.vote_average
        destination.vote_count = source.vote_count
        return destination
    }
        
    func getFavoriteMovies() -> [RealmFavoritMovie] {
        do {
            let realm = try Realm()
            return Array(realm.objects(RealmFavoritMovie.self))
        } catch {
            print("Error fetching Favorit Movies from Realm: \(error)")
            return []
        }
    }
    
    func getFavoriteTvShows() -> [RealmFavoritTvShow] {
        do {
            let realm = try Realm()
            return Array(realm.objects(RealmFavoritTvShow.self))
        } catch {
            print("Error fetching Favorit TvShows from Realm: \(error)")
            return []
        }
    }
}
