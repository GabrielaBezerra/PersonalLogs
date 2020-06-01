//
//  KeychainHelper.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 01/06/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

struct KeychainHelper {
    
    private let service = "PersonalLogsService"
    
    func check(password: String, for id: UUID) -> Bool {
        do {
            let item = KeychainPasswordItem(service: service, account: id.uuidString)
            let keychainPassword = try item.readPassword()
            if keychainPassword == password { try item.deleteItem() }
            return keychainPassword == password
        } catch {
            print(error)
            return false
        }
    }
    
    func save(password: String, id: UUID) -> Bool {
        do {
            try KeychainPasswordItem(service: service, account: id.uuidString).savePassword(password)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    @discardableResult
    func removePassword(from id: UUID) -> Bool {
        do {
            try KeychainPasswordItem(service: service, account: id.uuidString).deleteItem()
            return true
        } catch {
            print(error)
            return false
        }
    }
    
}
