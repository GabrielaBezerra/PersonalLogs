//
//  NotesRepository.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 25/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

class NoteRepository: Repository {
    typealias Item = Note
    var items: [Note] = []
}
