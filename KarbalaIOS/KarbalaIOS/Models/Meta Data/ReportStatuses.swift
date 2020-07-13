

import Foundation
struct ReportStatuses : Codable {
	let id : Int?
	let name : String?
	let nameAR : String?
	let color : String?

	enum CodingKeys: String, CodingKey {

		case id = "Id"
		case name = "Name"
		case nameAR = "NameAR"
		case color = "Color"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		nameAR = try values.decodeIfPresent(String.self, forKey: .nameAR)
		color = try values.decodeIfPresent(String.self, forKey: .color)
	}

}
