//
// SplashScreen
// AppDelegate.swift
//
// last build: macOS 10.13, Swift 4.0
//
// Created by Gene De Lisa on 3/17/19.

//  Copyright ©(c) 2019 Gene De Lisa. All rights reserved.
//
//  This source code is licensed under the MIT license found in the
//  LICENSE file in the root directory of this source tree.
//
//  In addition:
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//



import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var splashWindowController: SplashWindowController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        NSLog("\(#function)")
        
        self.setupSplashScreen()
    }
    
    func setupSplashScreen() {
        NSLog("\(#function)")
        
        self.splashWindowController = SplashWindowController()
        self.splashWindowController.showWindow(self)
        
        let operationQueue = OperationQueue()
        
        let startUpCompletionOperation = BlockOperation {
            NSLog("\(#function) startup comp op")
            OperationQueue.main.addOperation {
                // this is on the main thread
                self.splashWindowController.window?.close()
                self.showMainWin()
            }
        }
        
        let startUpOperation = BlockOperation {
            NSLog("\(#function) startup op")
            self.doTheInitialization()
            operationQueue.addOperation(startUpCompletionOperation)
        }
        startUpCompletionOperation.addDependency(startUpOperation)
        operationQueue.addOperation(startUpOperation)
    }
    
    
    func showMainWin() {
        NSLog("\(#function)")
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        if let mc = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("MainWC"))
            as? NSWindowController,
            let vc = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("MainVC"))
                as? NSViewController {
            mc.window?.contentViewController = vc
            mc.window?.makeKeyAndOrderFront(self)
        }
    }
    
    func doTheInitialization() {
        NSLog("\(#function)")
        
        // this is not on the main thread
        
        // actually do the initialization here. Faking it here with the sleep
        sleep(4)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}

