import UIKit

class MainFlowViewController: UIViewController {

    private var types: [FlowControllerType] = []
    private var flowItems: [FlowItem] = []
    private var completion: ([FlowItem]) -> Void = { _ in }
    private let navController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupNavigationController()
//        showNextViewController()
    }
    
    private func setupNavigationController() {
        navController.navigationBar.topItem?.title = "Flow Control"
        
        addChild(navController)
        view.addSubview(navController.view)
        
        let constraints = [
            navController.view.topAnchor.constraint(equalTo: view.topAnchor),
            navController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            navController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            navController.view.leftAnchor.constraint(equalTo: view.leftAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        navController.didMove(toParent: self)
    }
    
    public func startFlow() {
        showNextViewController()
    }
    
    public func invalidate() {
        types.removeAll()
        flowItems.removeAll()
        completion = { _ in }
        navController.viewControllers.removeAll()
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
        
        navController.pushViewController(viewController, animated: true)
    }
    
    // when nil is returned it means the end is reached.
    private func nextIndex() -> Int? {
        guard let visibleViewController = navController.visibleViewController as? FlowControllable else { return 0 }
        let type = visibleViewController.type
        
        if let index = types.firstIndex(of: type) {
            return (index + 1) < types.endIndex ? index + 1 : nil
        }
        return nil
    }
    
}

extension MainFlowViewController {
    
    func setup(with types: [FlowControllerType], completion: @escaping ([FlowItem]) -> Void) {
        self.types = types
        self.completion = completion
    }
}

extension MainFlowViewController: FlowControllableDelegate {
    
    func flowControllableShouldFinishShowing(_ flowControllable: FlowControllable, with items: [FlowItem]) {
        let types = items.map { $0.type }
        
        flowItems.removeAll { item in types.contains { $0 == item.type } }
        flowItems.append(contentsOf: items)
        
        showNextViewController()
    }
    
    func flowControllableShouldSkip(_ flowControllable: FlowControllable) {
        showNextViewController()
    }
    
}

