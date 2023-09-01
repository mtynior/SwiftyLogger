//
//  LoggerConfigurable.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public protocol LoggerConfigurable {
    var configuration: LoggerConfiguration { get set }

    func addDestination(_ destination: LoggingDestination)
}
