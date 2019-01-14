import UIKit

class FlowCoordinator {
    
    public static let shared = FlowCoordinator()
    
    private var report: String = ""
    
    func showOnboarding() {
        ApplicationWindow.main?.showControllerFlow(with: [.firstNameAndLastName, .mood, .company]) { [weak self] items in
            guard let self = self else { return }
            
            items.forEach { self.report.append("\($0.type)\n") }
            
            // just until the beacon flow is shown - simulates api call delay
            ApplicationWindow.main?.showLoadingScreen()
            
            // show beacon flow after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.showBeaconFlow()
            }
        }
    }
    
    private func showBeaconFlow() {
        ApplicationWindow.main?.showControllerFlow(with: [.beaconInfo, .beaconSearch, .beaconFailed, .finish]) { [weak self] items in
            guard let self = self else { return }
            
            items.forEach { self.report.append("\($0.type)\n") }
            
            ApplicationWindow.main?.showMainScreen()
            
            let alert = UIAlertController(title: "Report", message: self.report, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(dismiss)
            
            // reset the report
            self.report = ""
            
            ApplicationWindow.main?.presentedViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
