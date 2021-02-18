//
//  SigninViewController.swift
//  KampusChat
//
//  Created by Burak on 11.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    private var signup_direction_flag = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showSignup(_ sender: Any) {
        
        var direction = "signinTOcity"
        if(signup_direction_flag == 0){
            direction = "signinTOsignupwelcome"
        }
        
        self.performSegue(withIdentifier: direction, sender: nil)
    }
    
}
