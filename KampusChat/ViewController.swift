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
        perform(#selector(self.determineDirection),with:nil,afterDelay: 1)
        //doldur()
    }

   
    @objc private func determineDirection(){
        Log.info(key: "determineDirection()",value: "is Begun")
        
        if(tokenViewModel.token != nil){
            self.performSegue(withIdentifier: "viewTOhome", sender: nil)
        }else{
            self.performSegue(withIdentifier: "viewTOsignin", sender: nil)
        }
        
    }
    
    
    /*
     ---- Version2 -----
    private func checkTokenFromApi(){
     // check out if token still is valid.
    }
 */
    
    
    
}

