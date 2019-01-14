import UIKit

class FlowViewController: UIViewController, FlowControllable {
    
    var type: FlowControllerType
    var profile: UserProfile?
    var delegate: FlowControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        type = .none
        profile = nil
        delegate = nil
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
