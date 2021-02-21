//
//  ResetPasswordViewController.swift
//  KampusChat
//
//  Created by Burak on 12.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldRepeatPassword: UITextField!
    @IBOutlet weak var labelStatus: UILabel!
    
    
    @IBAction func checkPasswords(_ sender: Any) {
        
        if(isPasswordValid() && arePasswordsMatch()){
            resetPassword()
        }
    }
    
    
    private func isPasswordValid() -> Bool{
        
        if(textFieldNewPassword.text!.count >= 6 && textFieldNewPassword.text!.count <= 10){
            labelStatus.text = ""
            return true;
        }
        labelStatus.text = NSLocalizedString("invalid_password",comment:"")
        return false;
    }
    
    private func arePasswordsMatch() -> Bool{
    
        if(textFieldNewPassword.text == textFieldRepeatPassword.text){
            labelStatus.text = ""
            return true;
        }
         labelStatus.text = NSLocalizedString("error_match_passwords",comment:"")
        return false;
    }
    
    
    private func resetPassword(){
        // reset password
        showSignin()
    }
    
    private func showSignin(){
        self.performSegue(withIdentifier: "resetpasswordTOsignin", sender: nil)
    }
    
}
