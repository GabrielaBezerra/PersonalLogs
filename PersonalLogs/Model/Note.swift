//
//  Note.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 25/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

//MARK: - Codable
class Note: RepositoryItem {
    
    static let placeholder: (title: String, body: String) = (title: "Untitled Note",
                                                             body: "It's your story to tell.")
        
    required init() {
        self.id = UUID()
        self.title = Self.placeholder.title
        self._body = Self.placeholder.body
        self.locked = false
    }
    
    let id: UUID
    var title: String
    var locked: Bool
    private var _body: String
    var body: String {
        get { locked ? "Classified. A secret is a secret, you know." : _body }
        set { _body = locked ? _body : newValue }
    }
    
    //Enum defining which properties are going to be saved. The "_body" property is going to be saved as "body"
    private enum CodingKeys: String, CodingKey {
        case id, title, _body = "body", locked
    }

}
