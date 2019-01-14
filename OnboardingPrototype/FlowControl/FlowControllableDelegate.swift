import Foundation
import UIKit

protocol FlowControllableDelegate: class {
    
    func flowControllableShouldFinishShowing(_ flowControllable: FlowControllable, with items: [FlowItem])
    func flowControllableShouldSkip(_ flowControllable: FlowControllable)
}
