//
//  NoteDelegate.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 26/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

protocol NoteDelegate: AnyObject {
    func didChange(title: String, body: String)
}
