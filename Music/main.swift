//
//  main.swift
//  Music
//
//  Created by Shape on 28/02/2018.
//  Copyright © 2018 Shape. All rights reserved.
//

import Foundation
import UIKit

setenv("CFNETWORK_DIAGNOSTICS", "3", 1)

// very first statement after load.. the current time
let WaysStartTime = CFAbsoluteTimeGetCurrent()

// build the parameters for the call to UIApplicationMain()
let argc = CommandLine.argc
let argv = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))

// start the main loop
UIApplicationMain(argc, argv, nil, NSStringFromClass(AppDelegate.self))
