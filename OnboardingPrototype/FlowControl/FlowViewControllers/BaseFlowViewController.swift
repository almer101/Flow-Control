import UIKit

class BaseFlowViewController: UIViewController, FlowControllable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    
    var type: FlowControllerType = .none
    var profile: UserProfile?
    var delegate: FlowControllableDelegate?
    private var labelText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        view.backgroundColor = UIColor.appBackgroundColor
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = UIColor.shadedWhiteColor
        titleLabel.text = labelText
        
        let title = NSAttributedString(string: "Next", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.shadedWhiteColor])
        mainButton.setAttributedTitle(title, for: .normal)
        mainButton.backgroundColor = UIColor.orange.withAlphaComponent(0.65)
        mainButton.layer.cornerRadius = mainButton.frame.size.height / 2
        mainButton.layer.masksToBounds = true
        
        secondaryButton.setTitleColor(.shadedWhiteColor, for: .normal)
        if(type == .finish) { secondaryButton.isHidden = true }
    }
    
    @IBAction func mainButtonTapped(_ sender: UIButton) {
        var items: [FlowItem] = []
        switch type {
        case .firstNameAndLastName:
            items.append(FlowItem(type: .firstName("John")))
            items.append(FlowItem(type: .lastName("Doe")))
        case .mood:
            items.append(FlowItem(type: .mood("Good mood")))
        case .company:
            items.append(FlowItem(type: .company("Google")))
        case .beaconSuccess:
            items.append(FlowItem(type: .hasBeacon(true)))
        case .beaconFailed:
            items.append(FlowItem(type: .hasBeacon(false)))
        default:
            break
        }
        delegate?.flowControllableShouldFinishShowing(self, with: items)
    }
    
    
    @IBAction func secondaryButtonTapped(_ sender: UIButton) {
        delegate?.flowControllableShouldSkip(self)
    }
}

extension BaseFlowViewController {
    
    func setup(with title: String) {
        self.labelText = title
    }
    
}
