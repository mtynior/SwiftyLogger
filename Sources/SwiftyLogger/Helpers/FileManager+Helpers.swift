//
//  FileManager+Helpers.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

internal extension FileManager {
    enum Logger {
        static func getDefaultPathForFile(named fileName: String, fileManager: FileManager = FileManager.default) -> URL {
            guard let directoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return URL(string: "")! }
            
            return directoryURL.appendingPathComponent(fileName, isDirectory: false)
        }
        
        static func createFile(atPath path:String, fileManager: FileManager = FileManager.default) {
            fileManager.createFile(atPath: path, contents: nil, attributes: nil)
        }
        
        static func getSizeInBytesOfFile(atPath path: String, fileManager: FileManager = FileManager.default) -> Int64? {
            guard let fileAttributes = try? fileManager.attributesOfItem(atPath: path) else { return nil }
            return (fileAttributes[FileAttributeKey.size] as? NSNumber)?.int64Value
        }
        
        static func recreateFile(atPath path: String, fileManager: FileManager = FileManager.default) {
            do {
                try fileManager.removeItem(atPath: path)
                fileManager.createFile(atPath: path, contents: nil, attributes: nil)
            } catch {
                print("[SwiftyLogger] Couldn't recreate file at \(path)")
            }
        }
        
        static func renameFile(atPath sourcePath: String, toPath destinationPath: String, fileManager: FileManager = FileManager.default) {
            do {
                if fileManager.fileExists(atPath: destinationPath) {
                    try fileManager.removeItem(atPath: destinationPath)
                }
                
                try fileManager.moveItem(atPath: sourcePath, toPath: destinationPath)
            } catch {
                print("[SwiftyLogger] Couldn't copy file at \(sourcePath) to \(destinationPath)")
            }
        }
    }
}
