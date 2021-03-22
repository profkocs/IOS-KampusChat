//
//  ViewController.swift
//  KampusChat
//
//  Created by Burak on 10.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

/**
 Class Responsibility -> Checking token to determine direction(Signin or Home)
*/

class ViewController: UIViewController {
    
   
    @IBOutlet weak var labelStatus: UILabel!
    
    var tokenViewModel = TokenViewModel(token: nil, storage: Storage())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        determineDirection()
    }

   
     private func determineDirection(){
        
        Log.info(key: "determineDirection()",value: "is Begun")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            if (self.tokenViewModel.tokenModel != nil) {
                
                self.showHome()
                
            } else{
            
                self.showSignin()
            }
            
        }
        
    }

    
    private func showHome(){
        self.performSegue(withIdentifier: SegueKeys.splash_to_home.rawValue, sender: nil)
    }
    
    private func showSignin(){
        self.performSegue(withIdentifier: SegueKeys.splash_to_signin.rawValue, sender: nil)
    }
    
  
    
}

