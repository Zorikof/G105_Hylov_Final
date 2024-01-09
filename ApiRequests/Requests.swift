import Foundation
import Alamofire
import RealmSwift

class Requests {
    static let shared = Requests()
    private init() {}
    
    func fetchAndSaveTopMovies(completion: @escaping () -> ()) {
        let urlMovies = "https://api.themoviedb.org/3/trending/movie/week?api_key=9076a2b9d078becde040b79f8e48a512"
        
        AF.request(urlMovies).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let topMoviesData = try decoder.decode(MovieStruct.self, from: data)
                    self.saveTopMoviesToRealm(topMoviesData.results)
                    completion()
                } catch {
                    print("Error decoding MoviesData: \(error)")
                }
            case .failure(let error):
                print("Error fetching MoviesData: \(error)")
            }
        }
    }
    
    func fetchAndSaveTopTvShows(completion: @escaping () -> ()) {
        let urlTvShows = "https://api.themoviedb.org/3/trending/tv/week?api_key=9076a2b9d078becde040b79f8e48a512"
        
        AF.request(urlTvShows).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let topTvShowsData = try decoder.decode(TvShowStruct.self, from: data)
                    self.saveTopTvShowsToRealm(topTvShowsData.results)
                    completion()
                } catch {
                    print("Error decoding TvShowsData: \(error)")
                }
            case .failure(let error):
                print("Error fetching TvShowsData: \(error)")
            }
        }
    }
    
    func fetchAndSaveSearchedMovies(request: String) {
        let requestString = replaceSpacesWithPlus(request: request)
        let requestUrl = "https://api.themoviedb.org/3/search/movie?query=\(requestString)&api_key=9076a2b9d078becde040b79f8e48a512"
        
        AF.request(requestUrl).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let searchedMovies = try decoder.decode(MovieStruct.self, from: data)
                    self.saveSearchedMovies(searchedMovies.results)
                } catch {
                    print("Error decoding SearchedMoviesData: \(error)")
                }
            case .failure(let error):
                print("Error fetching SearchedMoviesData: \(error)")
            }
        }
    }
    
    func fetchAndSaveSearchedTvShows(request: String) {
        let requestString = replaceSpacesWithPlus(request: request)
        let requestUrl = "https://api.themoviedb.org/3/search/tv?query=\(requestString)&api_key=9076a2b9d078becde040b79f8e48a512"
        
        AF.request(requestUrl).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let searchTvShows = try decoder.decode(TvShowStruct.self, from: data)
                    self.saveSearchedTvShows(searchTvShows.results)
                } catch {
                    print("Error decoding SearchedMoviesData: \(error)")
                }
            case .failure(let error):
                print("Error fetching SearchedMoviesData: \(error)")
            }
        }
    }
    
    private func saveSearchedTvShows(_ searchedTvShows: [TvShowResults]?) {
        guard let tvShows = searchedTvShows else { return }
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(tvShows.map { $0.toRealmSearchedTvShow() }, update: .modified)
            }
        } catch {
            print("Error saving searched TvShows to Realm: \(error)")
        }
    }
    
    private func saveSearchedMovies(_ searchedMovies: [MoviesResults]?) {
        guard let movies = searchedMovies else { return }
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(movies.map { $0.toRealmSearchedMovie() }, update: .modified)
            }
        } catch {
            print("Error saving searched Movies to Realm: \(error)")
        }
    }
    
    private func saveTopMoviesToRealm(_ topMovies: [MoviesResults]?) {
        guard let movies = topMovies else { return }
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(movies.map { $0.toRealmTopMovie() }, update: .modified)
            }
        } catch {
            print("Error saving Top Movies to Realm: \(error)")
        }
    }
    
    private func saveTopTvShowsToRealm(_ topTvShows: [TvShowResults]?) {
        guard let tvShows = topTvShows else { return }
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(tvShows.map { $0.toRealmTopTvShow() }, update: .modified)
            }
        } catch {
            print("Error saving TvShows to Realm: \(error)")
        }
    }
    
    private func replaceSpacesWithPlus(request: String) -> String {
        let regex = try! NSRegularExpression(pattern: "\\s+", options: .caseInsensitive)
        let range = NSMakeRange(0, request.count)
        let modifiedString = regex.stringByReplacingMatches(in: request, options: [], range: range, withTemplate: "+")
        return modifiedString
    }
}
