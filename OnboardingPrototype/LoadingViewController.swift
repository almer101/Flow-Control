//
//  LoadingViewController.swift
//  OnboardingPrototype
//
//  Created by Ivan Almer on 14/01/2019.
//  Copyright © 2019 AG04. All rights reserved.
//

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
