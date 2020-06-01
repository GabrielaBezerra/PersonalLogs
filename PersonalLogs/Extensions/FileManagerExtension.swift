//
//  FileManagerExtension.swift
//  PersonalLogs
//
//  Created by Gabriela Bezerra on 5/31/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation


extension FileManager {
    
    func printContent(from path: String, recursivelly: Bool = false) {
        let lastComponent = path.split(separator: "/").last!
        var isDirectory: ObjCBool = false
        fileExists(atPath: path, isDirectory: &isDirectory)
        if isDirectory.boolValue {
            print("\n📁 Directory: \(lastComponent)")
            if let contents = try? contentsOfDirectory(atPath: path) {
                print("Contents: \(contents)")
                if recursivelly {
                    for item in contents {
                        let itemPath = path+"/"+(item.replacingOccurrences(of: " ", with: "\\ "))
                        printContent(from: itemPath, recursivelly: true)
                    }
                }
            }
        } else {
            print("\n📊 File: \(lastComponent)")
            let fileExtension = lastComponent.split(separator: ".").last
            switch fileExtension {
            case "plist":
                let url = URL(fileURLWithPath: path)
                if let data  = try? Data(contentsOf: url),
                   let plist = try? PropertyListSerialization.propertyList(from: data,options: .mutableContainers, format: nil) as? [String : Any] {
                    print("Content: \(plist.description)")
                }
            default:
                if let content = try? String(contentsOfFile: path, encoding: .utf8) {
                    print("Content: \(content)")
                }
            }
        }
    }
    
}
