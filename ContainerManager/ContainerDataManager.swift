//
//  ContainerDataManager.swift
//
// Created by Bruno Rendeiro.
// Copyright © 2016 brurend.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

/// Responsible for managing your data and deciding which segue identifier should be used
public class ContainerDataManager: NSObject {
    
    /// This is the segue Identifier that will be used by the performSegue method.
    /// Your class should set it with your own segue set in the Interface Builder.
    public var currentSegueIdentifier: String!
    
    /// Reference to its parent ViewController class.
    public var parent: UIViewController!
    
    /// Reference to its ContainverViewSegueManager class.
    public var container: ContainerViewSegueManager!
    
    
    public override init() {
        
    }
    
    /**
     Swap from one ViewController to another.
     
     - parameter fromViewController: Current ViewController.
     - parameter toViewController:   Next ViewController.
     
     */
    public init (fromParent:UIViewController!, fromContainer:ContainerViewSegueManager!) {
        super.init()
        self.parent = fromParent
        self.container = fromContainer
    }
    
    /**
     This method calls all setup methods and perform the segue with the desired identifier.
    */
    func performSegue() {
        self.superSetup()
        fetchAPIDataWithCompletion(){ (finished: Bool) in
            if (finished) {
                self.container.performSegueWithIdentifier(self.currentSegueIdentifier, sender: nil)
            }
        }
    }
    
    /**
     This method guarantees that segueIdentifier won't be nil.
    */
    final func superSetup() {
        self.additionalSetup()
        
        assert(self.currentSegueIdentifier.characters.count > 0, "")
    }
    
    /**
     This method should be overridden with your application setup.
     Here is where you should call your methods to decide which
     segue identifier should be performed next.
    */
    public func additionalSetup() {
        preconditionFailure("This method must be overridden")
    }
    
    /**
     This method should be used if your class is doing any asynchronous request.
     If you do not use this method your performSegue method may be called before
     the request finished and may crash the application.
    */
    public func fetchAPIDataWithCompletion(completion:(finished: Bool) -> Void) {
        completion(finished: true)
    }
    
}
