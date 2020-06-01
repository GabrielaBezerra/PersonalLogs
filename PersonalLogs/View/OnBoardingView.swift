//
//  OnBoardingView.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 01/06/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation
import UIKit

class OnBoardingView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        label.textColor = .text
        label.numberOfLines = 0
        label.text = "Simple & Safe"
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .text
        label.numberOfLines = 0
        label.text = """
        
        📗 Personal Logs is the best way to save your personal notes and reflections.
        
        1. Create a new note taping the + button on the right corner and write your note, quite simple.
        
        2. Don't worry about saving the changes you make on your notes, every letter you type is automatically saved by default.
        
        3. You can add a password for each individual note, if you'd like. Just find the note you want to lock on the Personal Logs list, and swipe right to see the option.
        
        ✨ Enjoy the app, and keep writing!
        
        🖋
        """
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START WRITING", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.backgroundColor = .primaryAction
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()
    
    var dismissAction: (() -> Void)!
    @objc func dismiss() {
        dismissAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .background
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
        ])
        
        self.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
        ])
        
        self.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            startButton.widthAnchor.constraint(equalTo: bodyLabel.widthAnchor, multiplier: 1),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
