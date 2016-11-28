//
// ContainerViewSegueManager.swift
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

/**
  Responsible for perfoming the segue to the desired view, in the interface builder.
  This class should be set as your containerView Custom Class.
  You shouldn't override any of its methods.
 */
open class ContainerViewSegueManager: UIViewController {
    
    /// The reference to your ContainerDataManager subclass
    open var containerDataClass: ContainerDataManager?
    
    // MARK: - Class setup
    
    /// Call to class setup
    override open func viewDidLoad() {
        self.setupDataManagerClass(containerDataClass!)
    }
    
    /// Guarantees that containerDataClass is a subClass of ContainerDataManager.
    fileprivate func setupDataManagerClass(_ container: ContainerDataManager) {
        container.performSegue()
    }
    
    // MARK: - Segue and views transitions management
    
    /// Handles the transitions between all ViewControllers.
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.childViewControllers.count > 0 {
            self.swapFromViewController(self.childViewControllers.first!, toViewController: segue.destination)
        }
        else {
            self.addChildViewController(segue.destination)
            segue.destination.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.addSubview(segue.destination.view)
            segue.destination.didMove(toParentViewController: self)
        }
    }
    
    /**
     Swap from one ViewController to another.
     
     - parameter fromViewController: Current ViewController.
     - parameter toViewController:   Next ViewController.
     
     */
    open func swapFromViewController(
        _ fromViewController: UIViewController,
        toViewController: UIViewController)
    {
        toViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        if fromViewController.parent != self {
            self.addChildViewController(fromViewController)
        }
        
        fromViewController.willMove(toParentViewController: nil)
        self.addChildViewController(toViewController)
        
        self.transition(from: fromViewController, to: toViewController, duration: 0.1, options: UIViewAnimationOptions.transitionCrossDissolve, animations: nil) { (finished) in
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
        }
    }
}
