import Foundation
import UIKit

protocol FlowControllerDelegate: class {
    
    func flowControllerShouldFinishShowing(_ flowControllable: FlowControllable, with items: [FlowItem])
    func flowControllerShouldSkip(_ flowControllable: FlowControllable)
}
