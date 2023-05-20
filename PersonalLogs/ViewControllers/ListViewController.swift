//
//  ListViewController.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 25/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    //MARK: - Model
    private var noteRepository: NoteRepository {
        NoteRepository()
    }
    
    //MARK: - Views
    lazy var listView: ListView = {
        let view = ListView()
        view.delegate = self
        return view
    }()
    
    lazy var newNoteBarButtonItem: UIBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "plus"),
        style: .done,
        target: self,
        action: #selector(newNote)
    )

    lazy var onboardingBarButtonItem: UIBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "info"),
        style: .plain,
        target: self,
        action: #selector(showOnboarding)
    )
    
    //MARK: - Alerts
    func showPasswordAlert(okAction: @escaping (String) -> Void) {
        let alert = UIAlertController(title: nil, message: "Insert the Secret Password", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.tintColor = UIColor(named: "primaryActionColor")
            textField.textContentType = .password
            textField.isSecureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelAction)

        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            guard let pass = alert.textFields?.first?.text, !pass.isEmpty else { return }
            okAction(pass)
        }
        okAction.setValue(UIColor.primaryAction, forKey: "titleTextColor")
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConfirmationAlert(okAction: @escaping () -> Void) {
        let alert = UIAlertController(title: "This operation cannot be undone", message: "Are you sure you want to continue?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelAction)

        let okAction = UIAlertAction(title: "OK", style: .default) { action in okAction() }
        okAction.setValue(UIColor.primaryAction, forKey: "titleTextColor")
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showFadingAlert(message: String) {
        let lockedAlert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        self.present(lockedAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            lockedAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - ViewController Cycle
    override func loadView() {
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the title that shows on NavigationBar
        self.title = "Personal Logs"

        //Adding the newNoteBarButtonItem
        navigationItem.rightBarButtonItem = newNoteBarButtonItem
        navigationItem.leftBarButtonItem = onboardingBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Calling the repository to read all notes
        listView.notes = noteRepository.readAllItems()
    }
    
    //MARK: - Actions
    @objc func showOnboarding() {
        navigationController?.present(OnBoardingViewController(), animated: true)
    }
    
    @objc func newNote() {
        if let newNote = noteRepository.createNewItem() {
            showNoteDetail(id: newNote.id)
        }
    }
    
    func showNoteDetail(id: UUID) {
        let noteViewController = NoteViewController(noteRepository: noteRepository, id: id)
        navigationController?.pushViewController(noteViewController, animated: true)
    }
    
}

//MARK: - NoteListDelegate
extension ListViewController: NoteListDelegate {
    
    func didSelectNote(with id: UUID) {
        showNoteDetail(id: id)
    }
    
    func deleteNote(for id: UUID) {
        showConfirmationAlert { [weak self] in
            self?.noteRepository.delete(id: id)
            self?.listView.notes = self?.noteRepository.readAllItems() ?? []
        }
    }
    
    func askForPasswordToLock(for id: UUID) {
        showPasswordAlert { [weak self] (password) in
            guard let self = self else { return }
            
            if self.noteRepository.lock(id: id, password: password) {
                self.showFadingAlert(message: "Locked 🔒")
            }
            
            self.listView.notes = self.noteRepository.readAllItems()
        }
    }
    
    func askForPasswordToUnlock(for id: UUID) {
        showPasswordAlert { [weak self] (password) in
            guard let self = self else { return }
            
            if self.noteRepository.unlock(id: id, password: password) {
                self.showFadingAlert(message: "Unlocked 🔓")
            } else {
                self.showFadingAlert(message: "Wrong Password ☠️")
            }
            
            self.listView.notes = self.noteRepository.readAllItems()
        }
    }
    
}
