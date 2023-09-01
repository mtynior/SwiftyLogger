//
//  FileLogger.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public final class FileLogger: LoggingDestination {
    private var _logFile: FileHandle?
    private var _fileConfiguration: FileConfiguration
    
    private var filePath: String {
        _fileConfiguration.logFileURL.path
    }
    
    public var configuration: LoggerConfiguration
    public var queue: DispatchQueue
    
    public init(fileConfiguration: FileLogger.FileConfiguration, loggerConfiguration: LoggerConfiguration) {
        self._fileConfiguration = fileConfiguration
        self.configuration = loggerConfiguration
        self.queue = DispatchQueue(label: UUID().uuidString)
                
        createLogFileIfNecessary()
    }
    
    public convenience init(fileURL: URL, loggerConfiguration: LoggerConfiguration) {
        let fileConfiguration = FileLogger.FileConfiguration(logFileURL: fileURL)
        self.init(fileConfiguration: fileConfiguration, loggerConfiguration: loggerConfiguration)
    }
    
    deinit {
        _logFile?.closeFile()
    }
    
    public func log(message: LogMessage, context: LoggingContext) {
        createLogFileIfNecessary()
        
        let formattedMessage = configuration.messageFormatter.format(message: message, context: context)
        guard let data = (formattedMessage + "\n").data(using: String.Encoding.utf8) else { return }
        
        _logFile?.write(data)
        _logFile?.synchronizeFile()
    }
}

// MARK: - File Configuration
public extension FileLogger {
    struct FileConfiguration {
        public static let defaultFileName: String = "application.log"
        public let logFileURL: URL
        
        public init(logFileURL: URL) {
            self.logFileURL = logFileURL
        }
    }
}

// MARK: - LoggerConfigurable
public extension LoggerConfigurable {
    func addFile(fileConfiguration: FileLogger.FileConfiguration, loggerConfiguration: LoggerConfiguration? = nil) -> Self {
        let actualLoggerConfiguration = loggerConfiguration ?? self.configuration
        self.addDestination(FileLogger(fileConfiguration: fileConfiguration, loggerConfiguration: actualLoggerConfiguration))
        return self
    }
    
    func addFile(fileName: String = FileLogger.FileConfiguration.defaultFileName, loggerConfiguration: LoggerConfiguration? = nil) -> Self {
        let actualLoggerConfiguration = loggerConfiguration ?? self.configuration
        let fileUrl = FileManager.Logger.getDefaultPathForFile(named: fileName)
        self.addDestination(FileLogger(fileURL: fileUrl, loggerConfiguration: actualLoggerConfiguration))
        return self
    }
    
    func addFile(fileURL: URL, loggerConfiguration: LoggerConfiguration? = nil) -> Self {
        let actualLoggerConfiguration = loggerConfiguration ?? self.configuration
        self.addDestination(FileLogger(fileURL: fileURL, loggerConfiguration: actualLoggerConfiguration))
        return self
    }
}

// MARK: - Helpers
private extension FileLogger {
    func createLogFileIfNecessary() {
        if !FileManager.default.fileExists(atPath: filePath) {
            FileManager.Logger.createFile(atPath: filePath)
        }
        
        _logFile = FileHandle(forWritingAtPath: filePath)
        _logFile?.seekToEndOfFile()
    }
}
