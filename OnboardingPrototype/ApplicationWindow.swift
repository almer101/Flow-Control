//
//  ApplicationWindow.swift
//  OnboardingPrototype
//
//  Created by Ivan Almer on 11/01/2019.
//  Copyright © 2019 AG04. All rights reserved.
//

import UIKit

class ApplicationContainerViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var child: UIViewController? = nil {
        didSet {
            if let oldVC = oldValue {
                oldVC.dismiss(animated: true, completion: nil)
                
                oldVC.willMove(toParent: nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParent()
            }
            
            if let newVC = child {
                addChild(newVC)
                view.addSubview(newVC.view)
                newVC.view.frame = view.bounds
                newVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                newVC.didMove(toParent: self)
            }
        }
    }
    
}

class ApplicationWindow: UIWindow {
    
    public static var main: ApplicationWindow?
    
    private var container: ApplicationContainerViewController
    
    public var presentedViewController: UIViewController? {
        return container.child
    }
    
    init() {
        container = ApplicationContainerViewController()
        super.init(frame: UIScreen.main.bounds)
        rootViewController = container
        
        setupAppearance()
        
        showMainScreen()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeKeyAndVisible() {
        super.makeKeyAndVisible()
        
        ApplicationWindow.main = self
    }
    
    func showControllerFlow(with types: [FlowControllerType], completion: @escaping ([FlowItem]) -> Void) {
        let rootViewController = RootViewController()
        rootViewController.setup(with: types, completion: completion)
        container.child = rootViewController
    }
    
    func showMainScreen() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
        container.child = vc
    }
    
    func showLoadingScreen() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController else { return }
        container.child = vc
    }
    
    func setupAppearance() {
        let navBar = UINavigationBar.appearance()
        
        navBar.prefersLargeTitles = false
        navBar.isTranslucent = true
        navBar.barTintColor = UIColor.navigationBarColor
        navBar.tintColor = .orange
        
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    }
    
}
