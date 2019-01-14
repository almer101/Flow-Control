import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .appBackgroundColor
        
        activityIndicatorView.color = .shadedWhiteColor
        activityIndicatorView.startAnimating()
    }
}
