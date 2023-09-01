//
//  DefaultLogMessageFormatter.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public final class DefaultLogMessageFormatter: LogMessageFormatter {
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    public init() {}
    
    public func format(message: LogMessage, context: LoggingContext) -> String {
        let dateTimeString: String = dateFormatter.string(from: message.timestamp)
        let subsystem: String = {
            guard let subsystem = context.subsystem, !subsystem.isEmpty else { return "" }
            return "[\(subsystem)]"
        }()
        
        let category: String = {
            guard let category = context.category, !category.isEmpty else { return "" }
            return "[\(category)]"
        }()
                
        return "[" + dateTimeString + "][\(message.logLevel)]\(subsystem)\(category) " + message.message
    }
}
