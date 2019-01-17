//
//  OnboardingViewController.swift
//  OnboardingPrototype
//
//  Created by Ivan Almer on 17/01/2019.
//  Copyright © 2019 AG04. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    private var mainFlowViewController = MainFlowViewController()
    private var loadingViewController: LoadingViewController?
    private var report = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOnboardingEditProfile()
        addChildController(mainFlowViewController)
        mainFlowViewController.startFlow()
    }
    
    private func addChildController(_ vc: UIViewController) {
        addChild(vc)
        view.addSubview(vc.view)
        
        let constraints = [
            vc.view.topAnchor.constraint(equalTo: view.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vc.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            vc.view.leftAnchor.constraint(equalTo: view.leftAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        vc.didMove(toParent: self)
    }
    
    private func removeChildController(_ vc: UIViewController) {
        vc.willMove(toParent: nil)
        vc.removeFromParent()
        vc.view.removeFromSuperview()
    }
    
    private func setupOnboardingEditProfile() {
        mainFlowViewController.setup(with: [.firstNameAndLastName, .mood, .company]) { [weak self] items in
            guard let self = self else { return }
            
            items.forEach { self.report.append("\($0.type)\n") }
            
            self.showLoadingViewController()
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                if let loading = self?.loadingViewController {
                    self?.removeChildController(loading)
                }
                self?.showBeaconFlow()
            }
        }
    }
    
    private func showBeaconFlow() {
        mainFlowViewController.invalidate()
        
        mainFlowViewController.setup(with: [.beaconInfo, .beaconSearch, .beaconFailed, .finish]) { [weak self] items in
            guard let self = self else { return }
            
            items.forEach { self.report.append("\($0.type)\n") }
            print(self.report)
            
            ApplicationWindow.main?.showMainScreen()
        }
        mainFlowViewController.startFlow()
    }
    
    private func showLoadingViewController() {
        guard let loading = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController else { return }
        
        loadingViewController = loading
        addChildController(loading)
    }

}
