//
//  Flowable.swift
//  OnboardingPrototype
//
//  Created by Ivan Almer on 11/01/2019.
//  Copyright © 2019 AG04. All rights reserved.
//

import Foundation
import UIKit

protocol FlowControllerDelegate: class {
    
    func flowControllerShouldFinishShowing(_ viewController: UIViewController, with items: [FlowItem])
    func flowControllerShouldSkip(_ viewController: UIViewController)
}
