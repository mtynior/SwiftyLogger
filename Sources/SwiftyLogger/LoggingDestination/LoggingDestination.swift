//
//  LoggingDestination.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public protocol LoggingDestination {
    var configuration: LoggerConfiguration { get set }
    var queue: DispatchQueue { get set }
    
    func log(message: LogMessage, context: LoggingContext)
}
