//
//  RootViewController.swift
//  OnboardingPrototype
//
//  Created by Ivan Almer on 11/01/2019.
//  Copyright © 2019 AG04. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

    private var types: [FlowControllerType] = []
    private var flowItems: [FlowItem] = []
    private var completion: ([FlowItem]) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "Flow Control"
        navigationController?.view.backgroundColor = .white
        
        showNextViewController()
    }
    
    private func showNextViewController() {
        guard let next = nextIndex() else {
            // the end is reached so the completion block will be executed.
            completion(flowItems)
            return
        }
        
        let type = types[next]
        let viewController: UIViewController & FlowControllable
        
        switch type {
        case .firstNameAndLastName:
        case .mood:
        case .company:
        default:
            print("Type \(type)")
        }
    }
    
    // when nil is returned it means the end is reached.
    private func nextIndex() -> Int? {
        guard let visibleViewController = visibleViewController as? FlowControllable else { return 0 }
        let type = visibleViewController.type
        
        if let index = types.firstIndex(of: type) {
            return (index + 1) <= types.endIndex ? index + 1 : nil
        }
        return nil
    }
    
}

extension RootViewController {
    
    func setup(with types: [FlowControllerType], completion: @escaping ([FlowItem]) -> Void) {
        self.types = types
        self.completion = completion
    }
}

extension RootViewController: FlowControllerDelegate {
    
    func flowControllerShouldFinishShowing(_ viewController: UIViewController, with items: [FlowItem]) {
        let types = items.map { $0.type }
        
        flowItems.removeAll { item in types.contains(where: {item.type}) }
        items.forEach { item in
        
        }
    }
    
    func flowControllerShouldSkip(_ viewController: UIViewController) {
        // impl
    }
    
}

