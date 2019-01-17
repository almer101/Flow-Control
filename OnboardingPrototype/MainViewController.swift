import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var repeatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .appBackgroundColor
        
        titleLabel.textColor = .shadedWhiteColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        titleLabel.numberOfLines = 0
        
        let attributedTitle = NSAttributedString(string: "Repeat the process", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange])
        repeatButton.setAttributedTitle(attributedTitle, for: .normal)
    }

    @IBAction func repeatButtonTapped(_ sender: UIButton) {
//        FlowCoordinator.shared.showOnboarding()
        let onboarding = OnboardingViewController()
        present(onboarding, animated: true, completion: nil)
    }
}
