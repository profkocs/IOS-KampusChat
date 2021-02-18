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
    let database = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkStorageForToken()
    }

    
    private func checkStorageForToken(){
        Log.info(key: "checkStorageForToken",value: "is Begun")
        
        let token = database.getCurrentToken()
        if(token != nil){
           
            if(token?.token != nil){
                perform(#selector(self.showHome),with:nil,afterDelay: 1)
            }else{
                perform(#selector(self.showSignin),with:nil,afterDelay: 1)
            }
            
        }else{
             // Something went wrong
            Log.info(key: "checkStorageForToken",value: "Error Something Went Wrong")
            labelStatus.text = NSLocalizedString("error_something_went_wrong",comment:"")
            
        }
 
        
    }
    
   
    @objc private func showSignin(){
        Log.info(key: "showSignin",value: "is Begun")
        self.performSegue(withIdentifier: "viewTOsignin", sender: nil)
    }
    
    @objc private func showHome(){
    Log.info(key: "showHome",value: "is Begun")
     self.performSegue(withIdentifier: "viewTOhome", sender: nil)
    
    }

    /*
     ---- Version2 -----
    private func checkTokenFromApi(){
     // check out if token still is valid.
    }
 */
    
    
    
}

