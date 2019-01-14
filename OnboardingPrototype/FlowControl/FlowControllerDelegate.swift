import Foundation
import UIKit

protocol FlowControllerDelegate: class {
    
    func flowControllerShouldFinishShowing(_ viewController: UIViewController, with items: [FlowItem])
    func flowControllerShouldSkip(_ viewController: UIViewController)
}
