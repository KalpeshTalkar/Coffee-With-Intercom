//
//  Commons.swift
//
//  Created by Kalpesh Talkar on 05/11/19.
//  Copyright © 2019 Kalpesh Talkar. All rights reserved.
//

import Foundation

// MARK: - Print / Log

/// Print logs only in debug mode with file > method > line#
///
/// - Parameters:
///   - items: items to print
///   - fileName: name of the class file
///   - methodName: name of the method from the class file
///   - lineNumber: line number of the method
public func print(items: Any..., fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fn = URL(fileURLWithPath: fileName).lastPathComponent
        let path = "\(fn) > \(methodName) #\(lineNumber)"
        Swift.print("\(path):\n\(items)")
    #endif
}


/// Print logs only in debug mode
///
/// - Parameter items: items to print
public func print(_ items: Any...) {
    #if DEBUG
        Swift.print(items)
    #endif
}
