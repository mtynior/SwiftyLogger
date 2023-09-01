//
//  ConsoleLogger.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public final class ConsoleLogger: LoggingDestination {
    public var configuration: LoggerConfiguration
    public var queue: DispatchQueue
    
    public init(configuration: LoggerConfiguration) {
        self.configuration = configuration
        self.queue = DispatchQueue(label: UUID().uuidString)
    }
    
    public func log(message: LogMessage, context: LoggingContext) {
        let formattedMessage = configuration.messageFormatter.format(message: message, context: context)
        print(formattedMessage, separator: "", terminator: "\n")
    }
}

// MARK: - LoggerConfigurable
public extension LoggerConfigurable {
    func addConsole(configuration: LoggerConfiguration? = nil) -> Self {
        let actualConfiguration = configuration ?? self.configuration
        self.addDestination(ConsoleLogger(configuration: actualConfiguration))
        return self
    }
}
