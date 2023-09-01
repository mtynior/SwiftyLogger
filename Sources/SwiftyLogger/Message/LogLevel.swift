//
//  LogLevel.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public enum LogLevel: Int {
    case debug
    case verbose
    case info
    case warning
    case error
    case fatal
}

extension LogLevel: CustomStringConvertible {
    public var description: String {
        switch(self) {
        case .debug: return "Debug"
        case .verbose: return "Verbose"
        case .info: return "Info"
        case .warning: return "Warning"
        case .error: return "Error"
        case .fatal: return "Fatal"
        }
    }
}
