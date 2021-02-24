//
//  ViewController.swift
//  KampusChat
//
//  Created by Burak on 10.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var labelStatus: UILabel!
    let tokenViewModel = TokenViewModel(token: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenViewModel.initilazeToken()
        determineDirection()
    }

   
     private func determineDirection(){
        Log.info(key: "determineDirection()",value: "is Begun")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            if(self.tokenViewModel.token != nil){
                self.showHome()
            }else{
                self.showSignin()
            }
            
        }
        
    }
    
    
    private func showHome(){
        self.performSegue(withIdentifier: "viewTOhome", sender: nil)
    }
    
    private func showSignin(){
        self.performSegue(withIdentifier: "viewTOsignin", sender: nil)
    }
    
  
    
}

