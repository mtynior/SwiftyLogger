<div align="center">
    <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/6362174/265280638-8ea5e6d6-caf2-4a1c-ae79-0a76185e2d4f.png" width="256">
    <h1>SwiftyLogger</h1>
    <h3>A simple and flexible logging library written in Swift</h3>
</div>

<p align="center">
  <img src="https://img.shields.io/badge/language-Swift-orange" />
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" />
</p>

## Getting started 

### Swift Package Manager
You can add SwiftyLogger to your project by adding it as a dependency in your `Package.swift` file:
```swift
// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyProject",
    products: [
        .library(name: "MyProject", targets: ["MyProject"])
    ],
    dependencies: [
         .package(url: "https://github.com/mtynior/SwiftyLogger.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(name: "MyProject", dependencies: ["SwiftyLogger"]),
        .testTarget(name: "MyProjectTests", dependencies: ["MyProject"])
    ]
)
```

### Xcode
<p align="center">
    <img src="https://res.cloudinary.com/mtynior/image/upload/v1634748957/development/match_xcode_oleolc.jpg">
</p>

Open your project in Xcode, then:
1. Click File -> Add Packages,
2. In the search bar type: `https://github.com/mtynior/SwiftyLogger.git` and press `Enter`,
3. Once Xcode finds the library, set Dependency rule to `Up to next major version`,
4. Click Add Package,
5. Select the desired Target (If you have multiple targets, you can add the dependency manually from Xcode)
6. Confirm selection by clicking on Add Package.

### TL;DR
SwiftyLogger allows you to quickly start logging:

```swift
import SwiftyLogger

// 1. Create logger
let logger = Logger()
    .addConsole()
    .addFile()
    
// 2. Log messages
logger.logDebug("Debug message")
logger.logVerbose("Verbose message")
logger.logInfo("Info message")
logger.logWarning("Warning message")
logger.logError("Error message")
logger.logFatal("Fatal message")
```

### Available log functions
```swift
logDebug(message: "Debug log")
logDebug(message: "Debug log", file: "Main.swift")
logDebug(message: "Debug log", file: "Main.swift", function: "show()")
logDebug(message: "Debug log", file: "Main.swift", function: "show()", line: 21)
logDebug(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date())
logDebug(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date(), threadName: "Main")
```

```swift
logVerbose(message: "Debug log")
logVerbose(message: "Debug log", file: "Main.swift")
logVerbose(message: "Debug log", file: "Main.swift", function: "show()")
logVerbose(message: "Debug log", file: "Main.swift", function: "show()", line: 21)
logVerbose(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date())
logVerbose(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date(), threadName: "Main")
```

```swift
logInfo(message: "Debug log")
logInfo(message: "Debug log", file: "Main.swift")
logInfo(message: "Debug log", file: "Main.swift", function: "show()")
logInfo(message: "Debug log", file: "Main.swift", function: "show()", line: 21)
logInfo(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date())
logInfo(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date(), threadName: "Main")
```

```swift
logWarning(message: "Debug log")
logWarning(message: "Debug log", file: "Main.swift")
logWarning(message: "Debug log", file: "Main.swift", function: "show()")
logWarning(message: "Debug log", file: "Main.swift", function: "show()", line: 21)
logWarning(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date())
logWarning(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date(), threadName: "Main")
```

```swift
logError(message: "Debug log")
logError(message: "Debug log", file: "Main.swift")
logError(message: "Debug log", file: "Main.swift", function: "show()")
logError(message: "Debug log", file: "Main.swift", function: "show()", line: 21)
logError(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date())
logError(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date(), threadName: "Main")
```

```swift
logFatal(message: "Debug log")
logFatal(message: "Debug log", file: "Main.swift")
logFatal(message: "Debug log", file: "Main.swift", function: "show()")
logFatal(message: "Debug log", file: "Main.swift", function: "show()", line: 21)
logFatal(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date())
logFatal(message: "Debug log", file: "Main.swift", function: "show()", line: 21, timestamp: Date(), threadName: "Main")
```

### Console Logger
Default Console Logger uses `print` function to display log messages:

```swift
let logger = Logger()
    .addConsole()
```

### File Logger
By default, the File Logger saves log messages in `application.log` file located in `Caches` folder:

```swift
let logger = Logger()
    .addFile()
```

The name of the file can be changed:
```swift
let logger = Logger()
    .addFile(fileName: "myLogs.log")
```

Also the location of the file can be changed:
```swift
let url = URL(path: "/path/to/file.log")!

let logger = Logger()
    .addFile(fileURL: url)
```

### Rotating File Logger
The Rotating File Logger saves log messages into log file. When the size of the log file exceeds the maximum size, then the logs are transferred to archive file.
By default, the Rotating File Logger saves log messages in `application.log` file located in `Caches` folder. The archive logs are stored in `application.log` file:

```swift
let logger = Logger()
    .addRotatingFile()
```

By default the maximum log file size is set to 5MB, but can be changed with `maximumFileSizeInBytes`:
```swift
let logger = Logger()
    .addRotatingFile(maximumFileSizeInBytes: 1_048_576)
```

The name of both files can be changed:
```swift
let logger = Logger()
    .addFile(fileName: "myLogs.log", archiveFileName: "myArchiveLogs.log")
```

Also the location of both files can be changed:
```swift
let logFileUrl = URL(path: "/path/to/file.log")!
let archiveFileUrl = URL(path: "/path/to/archive.log")!

let logger = Logger()
    .addFile(fileURL: url, archiveLogFileURL: archiveFileUrl)
```

### Subsystem and category
You can define loggers dedicated to specific area of you application. You can distinguish those areas using optional `subsystem` and `category` properties:

```swift
let logger = Logger(subsystem: "Settings", category: "General")
    .addConsole()
    .addFile()
```

### Minimal log level
By default the minimum log level is set to `LogLevel.debug`. 

If you want to change minimum log level globally, for all logger targets, then set the `minimumLogLevel` on `LoggerConfiguration`:

```swift
let configuration = LoggerConfiguration(minimumLogLevel: .warning)

let logger = Logger(configuration: configuration)
    .addConsole()
    .addFile()
```

You can also set the minimum log level for the specific logger destination:
```swift
let logger = Logger(configuration: LoggerConfiguration(minimumLogLevel: .warning))
    .addConsole() // logs warnings and above
    .addFile(loggerConfiguration: LoggerConfiguration(minimumLogLevel: .error)) // logs errors and above
```

If the minimum log level for specific logger destination is defined, then he global `minimumLogLevel` is ignored:
```swift
let logger = Logger(configuration: LoggerConfiguration(minimumLogLevel: .warning))
    .addConsole() // logs warnings and above
    .addFile(loggerConfiguration: LoggerConfiguration(minimumLogLevel: .debug)) // logs debug and above
```

## Custom Destination
You can define your own destination. Every destination must conformance to the `LoggingDestination` protocol:

```swift
final class MyLogger: LoggingDestination {
    var configuration: LoggerConfiguration
    var queue: DispatchQueue
    
    init(configuration: LoggerConfiguration) {
        self.configuration = configuration
        self.queue = DispatchQueue(label: UUID().uuidString)
    }
    
    public func log(message: LogMessage, context: LoggingContext) {
        let formattedMessage = configuration.messageFormatter.format(message: message, context: context)
        print(formattedMessage, separator: "", terminator: "\n")
    }
}
```

Once the custom destination is defined, you can add it to Logger with `addDestination(_:)` method:
``` swift
let logger = Logger()
    .addDestination(MyLogger(configuration: LoggerConfiguration.default))
``` 

Or you can extend the `LoggerConfigurable` protocol and make fluent API:
```swift
public extension LoggerConfigurable {
    func addMyLogger(configuration: LoggerConfiguration? = nil) -> Self {
        let actualConfiguration = configuration ?? self.configuration
        self.addDestination(MyLogger(configuration: actualConfiguration))
        return self
    }
}
```

Now, you can use your custom logger like this:
``` swift
let logger = Logger()
    .addMyLogger()
```

## Message formatter
By default, the `Logger` has formatter that produces following output:

```
[2023-09-01T17:01:31.921Z][Debug][Subsystem][Category] Hello world
```

If you want to change the format of the log message you can create your own formatter. The only requirement for custom formatter is conformance of the `LogMessageFormatter` protocol:

```swift
final class MyFormatter: LogMessageFormatter {
    func format(message: LogMessage, context: LoggingContext) -> String {          
        return "<\(logMessage.logLevel)> " + logMessage.message
    }
}
```

One the formatter is defined you can use it by adjusting logger's configuration:

```swift
var configuration = LoggerConfiguration.default
configuration.messageFormatter = MyFormatter()

let logger = Logger(configuration: configuration)
    .addConsole()
```

Now, Logger will produce following output:

```
<Debug> Hello world
```

## License
SwiftyLogger is released under the MIT license. See LICENSE for details.