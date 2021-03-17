//
//  Spinner.swift
//  KampusChat
//
//  Created by Burak on 24.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
import UIKit
class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var child:UIViewController? = nil
    
    override func loadView() {
        Log.info(key: "SpinnerloadView()", value: "is Begun")
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    func showSpinner(viewController:UIViewController){
        Log.info(key: "showSpinner()", value: "is Begun")
        child = self
        
        // add the spinner view controller
        viewController.addChild(child!)
        child?.view.frame = viewController.view.frame
        viewController.view.addSubview(child!.view)
        child?.didMove(toParent: viewController)
        
    }
    
    func disableSpinner(){
        Log.info(key: "disableSpinner()", value: "is Begun")
        child?.willMove(toParent: nil)
        child?.view.removeFromSuperview()
        child?.removeFromParent()
    }
    
    
    
    /*
     // wait two seconds to simulate some work happening
     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
     // then remove the spinner view controller
     child.willMove(toParent: nil)
     child.view.removeFromSuperview()
     child.removeFromParent()
     }
     */
    
}
