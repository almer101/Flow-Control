//
//  FlowControllerType.swift
//  OnboardingPrototype
//
//  Created by Ivan Almer on 11/01/2019.
//  Copyright © 2019 AG04. All rights reserved.
//

import Foundation

enum FlowControllerType {
    
    case none
    
    // beacon related view controllers
    case beaconInfo
    case beaconSearch
    case beaconFailed
    case beaconSuccess
    
    // user info
    case firstNameAndLastName
    case company
    case mood
    
    // finishing view controller
    case finish
}
