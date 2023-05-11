//
//  NoteListDelegate.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 26/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

protocol NoteListDelegate: AnyObject {
    func didSelectNote(with id: UUID)
    func deleteNote(for id: UUID)
    func askForPasswordToLock(for id: UUID)
    func askForPasswordToUnlock(for id: UUID)
}
