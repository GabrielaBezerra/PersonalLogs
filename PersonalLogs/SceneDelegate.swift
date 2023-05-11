//
//  SceneDelegate.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 25/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: ListViewController())
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .primaryAction
        return navigationController
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
            
            //MARK: - App Sandbox
//            FileManager.default.printContent(from: NSHomeDirectory(), recursivelly: true)
            
            //MARK: - PropertyLists
//            let onBoardingStatusURL = URL(fileURLWithPath: NSHomeDirectory()+"/Library/Preferences/"+OnBoardingStatus.plistName)
//
//            if let data = try? Data(contentsOf: onBoardingStatusURL),
//               let onBoardingPropertyList = try? PropertyListDecoder().decode(OnBoardingStatus.self, from: data) {
//
//                print("FirstLaunch:",onBoardingPropertyList.firstLaunch)
//                print("FirstLaunchTimestamp:",onBoardingPropertyList.firstLaunchTimestamp)
//                print("OnBoarding has already been seen by the user.")
//
//            } else {
//
//                let status = OnBoardingStatus()
//                if let data = try? PropertyListEncoder().encode(status) {
//                    try? data.write(to: onBoardingStatusURL)
//                }
//
//                navigationController.present(OnBoardingViewController(), animated: true)
//            }
            
            //MARK: - UserDefaults
            let isFirstLaunch = (UserDefaults.standard.value(forKey: "FirstLaunch") as? Bool) ?? false
            if !isFirstLaunch {
                UserDefaults.standard.set(true, forKey: "FirstLaunch")
                UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "FirstLaunchTimestamp")
                navigationController.present(OnBoardingViewController(), animated: true)
            }
        }
    
    }

}

