import Foundation

// MARK: - Movies Struct

struct MovieStruct : Codable {
    let page : Int?
    let results : [MoviesResults]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([MoviesResults].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }
}

struct MoviesResults : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let id : Int?
    let title : String?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let poster_path : String?
    let media_type : String?
    let genre_ids : [Int]?
    let popularity : Double?
    let release_date : String?
    let video : Bool?
    let vote_average : Double?
    let vote_count : Int?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case id = "id"
        case title = "title"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case poster_path = "poster_path"
        case media_type = "media_type"
        case genre_ids = "genre_ids"
        case popularity = "popularity"
        case release_date = "release_date"
        case video = "video"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
        genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
    }
}

// MARK: - TvShows Struct

struct TvShowStruct : Codable {
    let page : Int?
    let results : [TvShowResults]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([TvShowResults].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }

}

struct TvShowResults : Codable {
    let adult : Bool?
    let backdrop_path : String?
    let id : Int?
    let name : String?
    let original_language : String?
    let original_name : String?
    let overview : String?
    let poster_path : String?
    let media_type : String?
    let genre_ids : [Int]?
    let popularity : Double?
    let first_air_date : String?
    let vote_average : Double?
    let vote_count : Int?
    let origin_country : [String]?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case id = "id"
        case name = "name"
        case original_language = "original_language"
        case original_name = "original_name"
        case overview = "overview"
        case poster_path = "poster_path"
        case media_type = "media_type"
        case genre_ids = "genre_ids"
        case popularity = "popularity"
        case first_air_date = "first_air_date"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
        case origin_country = "origin_country"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
        genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
        origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
    }
}

extension MoviesResults {
    
    func toRealmSearchedMovie() -> RealmSearchedMovie {
        let realmMovie = RealmSearchedMovie()
        realmMovie.adult = adult ?? false
        realmMovie.backdrop_path = backdrop_path
        realmMovie.id = id ?? 0
        realmMovie.title = title ?? ""
        realmMovie.original_language = original_language ?? ""
        realmMovie.original_title = original_title ?? ""
        realmMovie.overview = overview ?? ""
        realmMovie.poster_path = poster_path
        realmMovie.media_type = media_type ?? ""
        realmMovie.genre_ids.append(objectsIn: genre_ids ?? [])
        realmMovie.popularity = popularity ?? 0.0
        realmMovie.release_date = release_date
        realmMovie.video = video ?? false
        realmMovie.vote_average = vote_average ?? 0.0
        realmMovie.vote_count = vote_count ?? 0
        return realmMovie
    }
    
    func toRealmTopMovie() -> RealmTopMovie {
        let realmMovie = RealmTopMovie()
        realmMovie.adult = adult ?? false
        realmMovie.backdrop_path = backdrop_path
        realmMovie.id = id ?? 0
        realmMovie.title = title ?? ""
        realmMovie.original_language = original_language ?? ""
        realmMovie.original_title = original_title ?? ""
        realmMovie.overview = overview ?? ""
        realmMovie.poster_path = poster_path
        realmMovie.media_type = media_type ?? ""
        realmMovie.genre_ids.append(objectsIn: genre_ids ?? [])
        realmMovie.popularity = popularity ?? 0.0
        realmMovie.release_date = release_date
        realmMovie.video = video ?? false
        realmMovie.vote_average = vote_average ?? 0.0
        realmMovie.vote_count = vote_count ?? 0
        return realmMovie
    }
    
    func toRealmFavoritMovies() -> RealmFavoritMovie {
        let realmMovie = RealmFavoritMovie()
        realmMovie.adult = adult ?? false
        realmMovie.backdrop_path = backdrop_path
        realmMovie.id = id ?? 0
        realmMovie.title = title ?? ""
        realmMovie.original_language = original_language ?? ""
        realmMovie.original_title = original_title ?? ""
        realmMovie.overview = overview ?? ""
        realmMovie.poster_path = poster_path
        realmMovie.media_type = media_type ?? ""
        realmMovie.genre_ids.append(objectsIn: genre_ids ?? [])
        realmMovie.popularity = popularity ?? 0.0
        realmMovie.release_date = release_date
        realmMovie.video = video ?? false
        realmMovie.vote_average = vote_average ?? 0.0
        realmMovie.vote_count = vote_count ?? 0
        return realmMovie
    }
}

extension TvShowResults {
    
    func toRealmSearchedTvShow() -> RealmSearchedTvShow {
        let realmTvShow = RealmSearchedTvShow()
        realmTvShow.adult = adult ?? false
        realmTvShow.backdrop_path = backdrop_path
        realmTvShow.id = id ?? 0
        realmTvShow.name = name ?? ""
        realmTvShow.original_language = original_language ?? ""
        realmTvShow.original_name = original_name ?? ""
        realmTvShow.overview = overview ?? ""
        realmTvShow.poster_path = poster_path
        realmTvShow.media_type = media_type ?? ""
        realmTvShow.genre_ids.append(objectsIn: genre_ids ?? [])
        realmTvShow.popularity = popularity ?? 0.0
        realmTvShow.first_air_date = first_air_date
        realmTvShow.vote_average = vote_average ?? 0.0
        realmTvShow.vote_count = vote_count ?? 0
        realmTvShow.origin_country.append(objectsIn: origin_country ?? [])
        return realmTvShow
    }
    
    func toRealmTopTvShow() -> RealmTopTvShow {
        let realmTvShow = RealmTopTvShow()
        realmTvShow.adult = adult ?? false
        realmTvShow.backdrop_path = backdrop_path
        realmTvShow.id = id ?? 0
        realmTvShow.name = name ?? ""
        realmTvShow.original_language = original_language ?? ""
        realmTvShow.original_name = original_name ?? ""
        realmTvShow.overview = overview ?? ""
        realmTvShow.poster_path = poster_path
        realmTvShow.media_type = media_type ?? ""
        realmTvShow.genre_ids.append(objectsIn: genre_ids ?? [])
        realmTvShow.popularity = popularity ?? 0.0
        realmTvShow.first_air_date = first_air_date
        realmTvShow.vote_average = vote_average ?? 0.0
        realmTvShow.vote_count = vote_count ?? 0
        realmTvShow.origin_country.append(objectsIn: origin_country ?? [])
        return realmTvShow
    }
    
    func toRealmFavoritTvShows() -> RealmFavoritTvShow {
        let realmTvShow = RealmFavoritTvShow()
        realmTvShow.adult = adult ?? false
        realmTvShow.backdrop_path = backdrop_path
        realmTvShow.id = id ?? 0
        realmTvShow.name = name ?? ""
        realmTvShow.original_language = original_language ?? ""
        realmTvShow.original_name = original_name ?? ""
        realmTvShow.overview = overview ?? ""
        realmTvShow.poster_path = poster_path
        realmTvShow.media_type = media_type ?? ""
        realmTvShow.genre_ids.append(objectsIn: genre_ids ?? [])
        realmTvShow.popularity = popularity ?? 0.0
        realmTvShow.first_air_date = first_air_date
        realmTvShow.vote_average = vote_average ?? 0.0
        realmTvShow.vote_count = vote_count ?? 0
        realmTvShow.origin_country.append(objectsIn: origin_country ?? [])
        return realmTvShow
    }
}

