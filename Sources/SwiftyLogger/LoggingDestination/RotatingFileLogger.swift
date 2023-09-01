//
//  RotatingFileLogger.swift
//  SwiftyLogger
//
//  Created by Michal Tynior on 01/09/2023.
//

import Foundation

public final class RotatingFileLogger: LoggingDestination {
    private var _logFile: FileHandle?
    private var _fileConfiguration: FileConfiguration
    
    private var filePath: String {
        _fileConfiguration.logFileURL.path
    }
    
    public var configuration: LoggerConfiguration
    public var queue: DispatchQueue
    
    public init(fileConfiguration: FileConfiguration, loggerConfiguration: LoggerConfiguration) {
        self._fileConfiguration = fileConfiguration
        self.configuration = loggerConfiguration
        self.queue = DispatchQueue(label: UUID().uuidString)
       
        openAndRotateLogFilesIfNecessary()
    }
    
    deinit {
        _logFile?.closeFile()
    }
    
    public func log(message: LogMessage, context: LoggingContext) {
        _logFile = rotateLogFilesIfNecessary(fileHandle: _logFile)
        
        let formattedMessage = configuration.messageFormatter.format(message: message, context: context)
        guard let data = (formattedMessage + "\n").data(using: String.Encoding.utf8) else { return }
        
        _logFile?.write(data)
        _logFile?.synchronizeFile()
    }
}

// MARK: - File Configuration
public extension RotatingFileLogger {
    struct FileConfiguration {
        public static let defaultFileName: String = "application.log"
        public static let defaultArchiveFileName: String = "application_archive.log"
        public static let maximumFileSizeInBytes: Int64 = 5_242_880

        public let logFileURL: URL
        public let archiveLogFileURL: URL
        public let maximumFileSizeInBytes: Int64
        
        public init(logFileURL: URL, archiveLogFileURL: URL, maximumFileSizeInBytes: Int64) {
            self.logFileURL = logFileURL
            self.archiveLogFileURL = archiveLogFileURL
            self.maximumFileSizeInBytes = maximumFileSizeInBytes
        }
    }
}

// MARK: - LoggerConfigurable
public extension LoggerConfigurable {
    func addRotatingFile(fileConfiguration: RotatingFileLogger.FileConfiguration, loggerConfiguration: LoggerConfiguration? = nil) -> Self {
        let actualLoggerConfiguration = loggerConfiguration ?? self.configuration
        self.addDestination(RotatingFileLogger(fileConfiguration: fileConfiguration, loggerConfiguration: actualLoggerConfiguration))
        return self
    }
    
    func addRotatingFile(
        fileName: String = RotatingFileLogger.FileConfiguration.defaultFileName,
        archiveFileName: String = RotatingFileLogger.FileConfiguration.defaultArchiveFileName,
        maximumFileSizeInBytes: Int64 = RotatingFileLogger.FileConfiguration.maximumFileSizeInBytes,
        loggerConfiguration: LoggerConfiguration? = nil
    ) -> Self {
        let actualLoggerConfiguration = loggerConfiguration ?? self.configuration
        let fileConfiguration = RotatingFileLogger.FileConfiguration(
            logFileURL: FileManager.Logger.getDefaultPathForFile(named: fileName),
            archiveLogFileURL: FileManager.Logger.getDefaultPathForFile(named: archiveFileName),
            maximumFileSizeInBytes: maximumFileSizeInBytes
        )

        self.addDestination(RotatingFileLogger(fileConfiguration: fileConfiguration, loggerConfiguration: actualLoggerConfiguration))
        return self
    }
    
    func addRotatingFile(
        fileURL: URL,
        archiveFileUrl: URL,
        maximumFileSizeInBytes: Int64 = RotatingFileLogger.FileConfiguration.maximumFileSizeInBytes,
        loggerConfiguration: LoggerConfiguration? = nil
    ) -> Self {
        let actualLoggerConfiguration = loggerConfiguration ?? self.configuration
        let fileConfiguration = RotatingFileLogger.FileConfiguration(
            logFileURL: fileURL,
            archiveLogFileURL: archiveFileUrl,
            maximumFileSizeInBytes: maximumFileSizeInBytes
        )
        
        self.addDestination(RotatingFileLogger(fileConfiguration: fileConfiguration, loggerConfiguration: actualLoggerConfiguration))
        return self
    }
}

// MARK: - Helpers
private extension RotatingFileLogger {
    func openAndRotateLogFilesIfNecessary() {
        _logFile = FileHandle(forWritingAtPath: filePath)
        _logFile?.seekToEndOfFile()
        
        _logFile = rotateLogFilesIfNecessary(fileHandle: _logFile)
    }
    
    func rotateLogFilesIfNecessary(fileHandle: FileHandle?) -> FileHandle? {
        if let fileSizeInBytes = FileManager.Logger.getSizeInBytesOfFile(atPath: filePath) {
            if fileSizeInBytes >= _fileConfiguration.maximumFileSizeInBytes {
                fileHandle?.closeFile()
                
                FileManager.Logger.renameFile(atPath: _fileConfiguration.logFileURL.path, toPath: _fileConfiguration.archiveLogFileURL.path)
               
                return createNewLogFile()
            } else {
                return fileHandle
            }
        } else {
            fileHandle?.closeFile()
            return createNewLogFile()
        }
    }
    
    func createNewLogFile() -> FileHandle? {
        if !FileManager.default.fileExists(atPath: filePath) {
            FileManager.Logger.createFile(atPath: filePath)
        }
        
        let fileHandle = FileHandle(forWritingAtPath: filePath)
        fileHandle?.seekToEndOfFile()
        
        return fileHandle
    }
}
