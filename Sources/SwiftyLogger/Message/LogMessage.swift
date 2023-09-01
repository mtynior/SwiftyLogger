//
//  LogMessage.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public struct LogMessage {
    public let logLevel: LogLevel
    public let message: String
    public let file: String
    public let function: String
    public let line: Int
    public let timestamp: Date
    public let threadName: String
    
    public init (logLevel: LogLevel, message: String, file: String, function: String, line: Int, timestamp: Date, threadName: String) {
        self.logLevel = logLevel
        self.message = message
        self.file = file
        self.function = function
        self.line = line
        self.timestamp = timestamp
        self.threadName = threadName
    }
}
