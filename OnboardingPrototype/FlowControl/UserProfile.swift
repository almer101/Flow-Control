//
//  UserProfile.swift
//  OnboardingPrototype
//
//  Created by Ivan Almer on 11/01/2019.
//  Copyright © 2019 AG04. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    
    let userId: Int
    let username: String
    let firstName: String
    let lastName: String
    let company: String?
    let mood: String?
    var hasBeacon: Bool
}
