//
//  LoggerConfiguration.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public struct LoggerConfiguration {
    public var minimumLogLevel: LogLevel
    public var messageFormatter: LogMessageFormatter
    public var isAsync: Bool
    
    public static let `default` = LoggerConfiguration(minimumLogLevel: .debug, messageFormatter: DefaultLogMessageFormatter())
    
    public init(minimumLogLevel: LogLevel, messageFormatter: LogMessageFormatter, isAsync: Bool = true) {
        self.minimumLogLevel = minimumLogLevel
        self.messageFormatter = messageFormatter
        self.isAsync = isAsync
    }
}
