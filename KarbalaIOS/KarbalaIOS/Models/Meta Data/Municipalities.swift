

import Foundation
struct Municipalities : Codable {
	let id : Int?
	let name : String?
	let nameAR : String?
	let townships : [SubDistrictModel]?

	enum CodingKeys: String, CodingKey {

		case id = "Id"
		case name = "Name"
		case nameAR = "NameAR"
		case townships = "Townships"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		nameAR = try values.decodeIfPresent(String.self, forKey: .nameAR)
		townships = try values.decodeIfPresent([SubDistrictModel].self, forKey: .townships)
	}

}
