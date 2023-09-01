//
//  Logger.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public class Logger: Logging, LoggerConfigurable {
    private var _destinations: [LoggingDestination]
    private var _context: LoggingContext
    public var configuration: LoggerConfiguration
    
    public init(subsystem: String? = nil, category: String? = nil, configuration: LoggerConfiguration = .default) {
        self._destinations = []
        self._context = LoggingContext(subsystem: subsystem, category: category)
        self.configuration = configuration
    }
    
    public func addDestination(_ destination: LoggingDestination) {
        _destinations.append(destination)
    }
    
    public func log(message: LogMessage) {
        for destination in _destinations {
            guard message.logLevel.rawValue >= destination.configuration.minimumLogLevel.rawValue else { continue }
                        
            if destination.configuration.isAsync {
                destination.queue.async { [unowned self] in
                    destination.log(message: message, context: self._context)
                }
            } else {
                destination.queue.sync { [unowned self] in
                    destination.log(message: message, context: self._context)
                }
            }
        }
    }
}
