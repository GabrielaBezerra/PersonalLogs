//
//  OnBoardingStatus.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 01/06/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

//MARK: - Codable 
struct OnBoardingStatus: Codable {
    static let plistName: String = "OnBoardingStatus"
    
    let firstLaunch: Bool = true
    let firstLaunchTimestamp: TimeInterval = Date().timeIntervalSince1970
    
    private enum CodingKeys: String, CodingKey {
        case firstLaunch, firstLaunchTimestamp
    }
}
