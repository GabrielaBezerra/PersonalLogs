//
//  NoteView.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 25/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import UIKit

class NoteView: UIView {
    
    weak var delegate: NoteDelegate? = nil

    lazy var titleField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.tintColor = .primaryAction
        textField.minimumFontSize = 18
        textField.delegate = self
        return textField
    }()
    
    lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textView.backgroundColor = .clear
        textView.textColor = .lightGray
        textView.tintColor = .primaryAction
        textView.delegate = self
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundCell
        setupTitleField()
        setupBodyTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleField() {
        self.addSubview(titleField)
        titleField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            titleField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            titleField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05)
        ])
    }
    
    func setupBodyTextView() {
        self.addSubview(bodyTextView)
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyTextView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 5),
            bodyTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bodyTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bodyTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
}


extension NoteView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = .text
        if textView.text == Note.placeholder.body {
            textView.text.removeAll()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.textColor = .lightGray
        if textView.text.isEmpty {
            textView.text = Note.placeholder.body
        }
        delegate?.didChange(title: titleField.text!, body: bodyTextView.text!)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        delegate?.didChange(title: titleField.text!, body: bodyTextView.text!+text)
        return true
    }
    
}


extension NoteView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == Note.placeholder.title {
            textField.text!.removeAll()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = Note.placeholder.title
        }
        delegate?.didChange(title: titleField.text!, body: bodyTextView.text!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.didChange(title: titleField.text!+string, body: bodyTextView.text!)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
}
