import Foundation

enum FlowItemType {
 
    // user profile
    case firstName(String)
    case lastName(String)
    case company(String)
    case mood(String)
    case hasBeacon(Bool)
    
}

extension FlowItemType: Equatable {
    
    static func ==(lhs: FlowItemType, rhs: FlowItemType) -> Bool {
        switch (lhs, rhs) {
        case (.firstName, .firstName), (.lastName, .lastName), (.company, .company), (.mood, .mood), (.hasBeacon, .hasBeacon) :
            return true
        default:
            return false
        }
    }
}
