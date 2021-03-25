//
//  SegueKeys.swift
//  KampusChat
//
//  Created by Burak on 23.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

/**
 What's this enum for?
 -> To control all segue keys in one hand.
 */

import Foundation

enum SegueKeys:String{
    
    // Splash
    case splash_to_signin = "splashTOsignin"
    case splash_to_home = "splashTOhome"
    
    // Sign in
    case signin_to_home = "signinTOhome"
    case sign_to_forgotpassword = "signinTOforgotpassword"
    case signin_to_city = "signinTOcity"
    case signin_to_email = "signinTOemail"
  
}
