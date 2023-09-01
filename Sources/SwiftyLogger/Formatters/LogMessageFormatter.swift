//
//  LogMessageFormatter.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public struct LoggingContext {
    public let subsystem: String?
    public let category: String?
    
    public init(subsystem: String?, category: String?) {
        self.subsystem = subsystem
        self.category = category
    }
}

public protocol LogMessageFormatter {
    func format(message: LogMessage, context: LoggingContext) -> String
}
