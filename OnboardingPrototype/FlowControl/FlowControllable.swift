import Foundation

protocol FlowControllable: class {
    
    var type: FlowControllerType { get set }
    var profile: UserProfile? { get set }
    var delegate: FlowControllerDelegate? { get set }
    
    func setup(with profile: UserProfile?, type: FlowControllerType, delegate: FlowControllerDelegate?)
}

extension FlowControllable {
    
    func setup(with profile: UserProfile?, type: FlowControllerType, delegate: FlowControllerDelegate?) {
        self.profile = profile
        self.type = type
        self.delegate = delegate
    }
}
