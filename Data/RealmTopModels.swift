import Foundation
import RealmSwift

// MARK: - RealmMovie

class RealmTopMovie: Object {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdrop_path: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var original_language: String = ""
    @objc dynamic var original_title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var poster_path: String?
    @objc dynamic var media_type: String = ""
    let genre_ids = List<Int>()
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var release_date: String?
    @objc dynamic var video: Bool = false
    @objc dynamic var vote_average: Double = 0.0
    @objc dynamic var vote_count: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - RealmTvShow

class RealmTopTvShow: Object {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdrop_path: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var original_language: String = ""
    @objc dynamic var original_name: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var poster_path: String?
    @objc dynamic var media_type: String = ""
    let genre_ids = List<Int>()
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var first_air_date: String?
    @objc dynamic var vote_average: Double = 0.0
    @objc dynamic var vote_count: Int = 0
    let origin_country = List<String>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

