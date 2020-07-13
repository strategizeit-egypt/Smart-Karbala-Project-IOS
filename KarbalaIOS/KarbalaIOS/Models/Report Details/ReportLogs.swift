

import Foundation
struct ReportLogs : Codable {
	let id : Int?
	let reportId : Int?
	let name : String?
	let email : String?
	let commentForUser : String?
	let commentForManager : String?
	let description : String?
	let reportStatusId : Int?
	let creationDate : String?

	enum CodingKeys: String, CodingKey {

		case id = "Id"
		case reportId = "ReportId"
		case name = "Name"
		case email = "Email"
		case commentForUser = "CommentForUser"
		case commentForManager = "CommentForManager"
		case description = "Description"
		case reportStatusId = "ReportStatusId"
		case creationDate = "CreationDate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		reportId = try values.decodeIfPresent(Int.self, forKey: .reportId)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		commentForUser = try values.decodeIfPresent(String.self, forKey: .commentForUser)
		commentForManager = try values.decodeIfPresent(String.self, forKey: .commentForManager)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		reportStatusId = try values.decodeIfPresent(Int.self, forKey: .reportStatusId)
		creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
	}

}
