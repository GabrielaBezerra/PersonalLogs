//
//  NoteViewController.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 25/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    private let noteRepository: NoteRepository
    private let noteID: UUID
    private var note: Note? {
        noteRepository.readItem(id: noteID)
    }
    
    lazy var noteView: NoteView = {
        let view = NoteView()
        view.delegate = self
        return view
    }()
    
    init(noteRepository: NoteRepository, id: UUID) {
        self.noteRepository = noteRepository
        self.noteID = id
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = noteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        
        noteView.titleField.text = note?.title
        noteView.bodyTextView.text = note?.body
    }
    
    func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NoteViewController: NoteDelegate {

    func didChange(title: String, body: String) {
        guard let note = note else { return }
        note.title = title
        note.body = body
        noteRepository.update(item: note)
    }

}
