import UIKit

class RootViewController: UINavigationController {

    private var types: [FlowControllerType] = []
    private var flowItems: [FlowItem] = []
    private var completion: ([FlowItem]) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "Flow Control"
        navigationController?.view.backgroundColor = .white
        
        showNextViewController()
    }
    
    private func showNextViewController() {
        guard let next = nextIndex() else {
            // the end is reached so the completion block will be executed.
            completion(flowItems)
            return
        }
        
        let type = types[next]
        guard let viewController: BaseFlowViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseFlowViewController") as? BaseFlowViewController else { return }
        
        switch type {
        case .firstNameAndLastName:
            viewController.setup(with: "First and last name")
            viewController.setup(with: nil, type: .firstNameAndLastName, delegate: self)
        case .mood:
            viewController.setup(with: "Mood")
            viewController.setup(with: nil, type: .mood, delegate: self)
        case .company:
            viewController.setup(with: "Company")
            viewController.setup(with: nil, type: .company, delegate: self)
        case .finish:
            viewController.setup(with: "Finish")
            viewController.setup(with: nil, type: .finish, delegate: self)
        case .beaconInfo:
            viewController.setup(with: "Beacon info")
            viewController.setup(with: nil, type: .beaconInfo, delegate: self)
        case .beaconSearch:
            viewController.setup(with: "Beacon search")
            viewController.setup(with: nil, type: .beaconSearch, delegate: self)
        case .beaconSuccess:
            viewController.setup(with: "Beacon success")
            viewController.setup(with: nil, type: .beaconSuccess, delegate: self)
        case .beaconFailed:
            viewController.setup(with: "Beacon failed")
            viewController.setup(with: nil, type: .beaconFailed, delegate: self)
        default:
            print("Default case of switch statement - type \(type)")
        }
        
        pushViewController(viewController, animated: true)
    }
    
    // when nil is returned it means the end is reached.
    private func nextIndex() -> Int? {
        guard let visibleViewController = visibleViewController as? FlowControllable else { return 0 }
        let type = visibleViewController.type
        
        if let index = types.firstIndex(of: type) {
            return (index + 1) < types.endIndex ? index + 1 : nil
        }
        return nil
    }
    
}

extension RootViewController {
    
    func setup(with types: [FlowControllerType], completion: @escaping ([FlowItem]) -> Void) {
        self.types = types
        self.completion = completion
    }
}

extension RootViewController: FlowControllerDelegate {
    
    func flowControllerShouldFinishShowing(_ flowControllable: FlowControllable, with items: [FlowItem]) {
        let types = items.map { $0.type }
        
        flowItems.removeAll { item in types.contains { $0 == item.type } }
        flowItems.append(contentsOf: items)
        
        showNextViewController()
    }
    
    func flowControllerShouldSkip(_ flowControllable: FlowControllable) {
        showNextViewController()
    }
    
}

