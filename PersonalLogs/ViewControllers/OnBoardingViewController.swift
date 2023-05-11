//
//  OnBoardingViewController.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 01/06/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation
import UIKit

class OnBoardingViewController: UIViewController {
    
    lazy var onBoardingView: OnBoardingView = {
        let view = OnBoardingView()
        view.dismissAction = {
            self.dismiss(animated: true, completion: nil)
        }
        return view
    }()
    
    override func loadView() {
        self.view = onBoardingView
    }
    
}
