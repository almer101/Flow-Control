import Foundation

enum FlowControllerType {
    
    case none
    
    // beacon related view controllers
    case beaconInfo
    case beaconSearch
    case beaconFailed
    case beaconSuccess
    
    // user info
    case firstNameAndLastName
    case company
    case mood
    
    // finishing view controller
    case finish
}
