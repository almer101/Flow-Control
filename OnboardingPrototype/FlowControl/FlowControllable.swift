import Foundation

protocol FlowControllable: class {
    
    var type: FlowControllerType { get set }
    var profile: UserProfile? { get set }
    var delegate: FlowControllableDelegate? { get set }
    
    func setup(with profile: UserProfile?, type: FlowControllerType, delegate: FlowControllableDelegate?)
}

extension FlowControllable {
    
    func setup(with profile: UserProfile?, type: FlowControllerType, delegate: FlowControllableDelegate?) {
        self.profile = profile
        self.type = type
        self.delegate = delegate
    }
}
