import Foundation

struct UserProfile: Codable {
    
    let userId: Int
    let username: String
    let firstName: String
    let lastName: String
    let company: String?
    let mood: String?
    var hasBeacon: Bool
}
