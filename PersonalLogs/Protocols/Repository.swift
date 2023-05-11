//
//  Repository.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 26/05/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

//MARK: - Repository
protocol Repository: AnyObject {
    
    associatedtype Item: RepositoryItem
    
    var items: [Item] { get set }
    
    func createNewItem() -> Item?
    func readAllItems() -> [Item]
    func readItem(id: UUID) -> Item?
    func update(item: Item)
    func delete(id: UUID)
    func lock(id: UUID, password: String) -> Bool
    func unlock(id: UUID, password: String) -> Bool
    
}

//MARK: - Repository Default Implementations
extension Repository {
    
    func createNewItem() -> Item? {
        
        //creating new item
        let newItem = Item()
        
        //persist file
        if let data = try? JSONEncoder().encode(newItem) {
            FileHelper().createFile(with: data, name: newItem.id.uuidString)
            return newItem
        }

        return nil
    }
    
    func readAllItems() -> [Item] {
        
        //read the content of the documents path
        let fileNames: [String] = FileHelper().contentsForDirectory(atPath: "")
        
        //retrieve items from fileNames and updating items array
        self.items = fileNames.compactMap { fileName in
            if let data = FileHelper().retrieveFile(at: fileName) {
                //decode from Data type to Item type
                let item = try? JSONDecoder().decode(Item.self, from: data)
                // TODO: remove body content from here in case its locked
                return item
            }
            return nil
        }
        
        return items
    }
    
    func readItem(id: UUID) -> Item? {
        //read one file by name. In our case, note files are named with their id.uuidString.
        if let data = FileHelper().retrieveFile(at: id.uuidString) {
            //decode from Data type to Item type
            let item = try? JSONDecoder().decode(Item.self, from: data)
            return item
        }
        return nil
    }
    
    func update(item: Item) {
        //encode to Data format
        if let data = try? JSONEncoder().encode(item) {
            //overrite persisted file
            FileHelper().updateFile(at: item.id.uuidString, data: data)
        }
    }
    
    func delete(id: UUID) {
        //remove file
        FileHelper().removeFile(at: id.uuidString)
        //remove password from keychain
        KeychainHelper().removePassword(from: id)
    }
    
    func lock(id: UUID, password: String) -> Bool {
        //get item by id
        guard let item = readItem(id: id) else { return false }
        
        //lock item with password
        if item.lock(password: password) {
            //if it was successfully locked, persist its new locked state.
            update(item: item)
            return true
        }
        return false
    }
    
    func unlock(id: UUID, password: String) -> Bool {
        //get item by id
        guard let item = readItem(id: id) else { return false }
        
        //unlock item with password
        if item.unlock(password: password) {
            //if it was successfully unlocked, persist its new unlocked state.
            update(item: item)
            return true
        }
        return false
    }
    
}
