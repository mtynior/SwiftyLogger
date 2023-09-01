//
//  Logging.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public protocol Logging {
    func log(message: LogMessage)
}

public extension Logging {
    func logDebug(_ message: String, file: String = #file, function: String = #function, line: Int = #line, timestamp: Date = Date(), threadName: String? = nil) {
        let currentThread = threadName ?? currentThreadName()
        let logMessage = LogMessage(logLevel: .debug, message: message, file: file, function: function, line: line, timestamp: timestamp, threadName: currentThread)
        
        log(message: logMessage)
    }
    
    func logVerbose(_ message: String, file: String = #file, function: String = #function, line: Int = #line, timestamp: Date = Date(), threadName: String? = nil) {
        let currentThread = threadName ?? currentThreadName()
        let logMessage = LogMessage(logLevel: .verbose, message: message, file: file, function: function, line: line, timestamp: timestamp, threadName: currentThread)
        
        log(message: logMessage)
    }
    
    func logInfo(_ message: String, file: String = #file, function: String = #function, line: Int = #line, timestamp: Date = Date(), threadName: String? = nil) {
        let currentThread = threadName ?? currentThreadName()
        let logMessage = LogMessage(logLevel: .info, message: message, file: file, function: function, line: line, timestamp: timestamp, threadName: currentThread)
        
        log(message: logMessage)
    }
    
    func logWarning(_ message: String, file: String = #file, function: String = #function, line: Int = #line, timestamp: Date = Date(), threadName: String? = nil) {
        let currentThread = threadName ?? currentThreadName()
        let logMessage = LogMessage(logLevel: .warning, message: message, file: file, function: function, line: line, timestamp: timestamp, threadName: currentThread)
        
        log(message: logMessage)
    }
    
    func logError(_ message: String, file: String = #file, function: String = #function, line: Int = #line, timestamp: Date = Date(), threadName: String? = nil) {
        let currentThread = threadName ?? currentThreadName()
        let logMessage = LogMessage(logLevel: .error, message: message, file: file, function: function, line: line, timestamp: timestamp, threadName: currentThread)
        
        log(message: logMessage)
    }
    
    func logFatal(_ message: String, file: String = #file, function: String = #function, line: Int = #line, timestamp: Date = Date(), threadName: String? = nil) {
        let currentThread = threadName ?? currentThreadName()
        let logMessage = LogMessage(logLevel: .fatal, message: message, file: file, function: function, line: line, timestamp: timestamp, threadName: currentThread)
        
        log(message: logMessage)
    }
    
    private func currentThreadName() -> String {
        guard !Thread.isMainThread else { return "Main" }
        
        if let threadName = Thread.current.name, !threadName.isEmpty {
            return threadName
        } else {
            return String(format: "%p", Thread.current)
        }
    }
}
