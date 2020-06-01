//
//  ListView.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 25/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import UIKit

class ListView: UIView {
    
    weak var delegate: NoteListDelegate? = nil
    
    var notes: [Note] = [] {
        didSet {
            if notes.isEmpty {
                setupEmptyState()
            } else if tableView.superview == self {
                self.tableView.reloadData()
            } else {
                setupTableView()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .background
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var emptyStateImageView: UIImageView = {
        let emptyStateImageView = UIImageView(image: UIImage(named: "emptyState"))
        emptyStateImageView.clipsToBounds = false
        return emptyStateImageView
    }()
    
    func showDetailOfNote(with id: UUID) {
        delegate?.didSelectNote(with: id)
    }
    
    //MARK: Setup Views
    func setupTableView() {
        emptyStateImageView.removeFromSuperview()
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        tableView.reloadData()
    }
    
    func setupEmptyState() {
        tableView.removeFromSuperview()
        self.addSubview(emptyStateImageView)
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyStateImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}


//MARK: - UITableView Delegate and DataSource
extension ListView: UITableViewDataSource, UITableViewDelegate {
 
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            notes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let currentNote = notes[indexPath.row]
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            cell.detailTextLabel?.numberOfLines = 3
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            
            cell.textLabel?.text = currentNote.title
            cell.detailTextLabel?.text = currentNote.body
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let currentNote = notes[indexPath.row]
            
            let deleteAction = UIContextualAction(style: .destructive, title: "") {
                [weak self] (action, view, _) in
                self?.delegate?.deleteNote(for: currentNote.id)
            }
            deleteAction.image = UIImage(systemName: "trash.fill")
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let currentNote = notes[indexPath.row]
            
            let lockAction = UIContextualAction(style: .normal, title: "") {
                [weak self] (action, view, _) in
                currentNote.locked ? self?.delegate?.askForPasswordToUnlock(for: currentNote.id) : self?.delegate?.askForPasswordToLock(for: currentNote.id)
            }
            
            lockAction.backgroundColor = UIColor(named: "primaryActionColor")
            lockAction.image = UIImage(systemName: "lock.fill")
            
            return UISwipeActionsConfiguration(actions: [lockAction])
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let currentNote = notes[indexPath.row]
            
            if !currentNote.locked {
                showDetailOfNote(with: currentNote.id)
            } else {
                delegate?.askForPasswordToUnlock(for: currentNote.id)
            }
        }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            UIView()
        }
    
}
