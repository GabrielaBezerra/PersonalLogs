//
//  RepositoryItem.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 01/06/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

//MARK: - RepositoryItem
protocol RepositoryItem: class, Codable {
    var id: UUID { get }
    var locked: Bool { get set }
    func lock(password: String) -> Bool
    func unlock(password: String) -> Bool
    init()
}

//MARK: - RepositoryItem Default Implementations
extension RepositoryItem {
    
    func lock(password: String) -> Bool {
        //save password on keychain
        let success = KeychainHelper().save(password: password, id: self.id)
        
        self.locked = success
        return success
    }
    
    func unlock(password: String) -> Bool {
        //check if password matches with the one on keychain
        let success = KeychainHelper().check(password: password, for: self.id)
        
        self.locked = success ? false : true
        return success
    }

}
