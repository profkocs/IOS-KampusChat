//
//  ForgotPasswordViewController.swift
//  KampusChat
//
//  Created by Burak on 11.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func isEmailValid(_ sender: Any) {
        
        if(EmailValidation.isValidEmailAddress(emailAddressString: textFieldEmail.text!)){
            labelMessage.text = ""
            sendCode()
        }else{
            //showToast(message: "Invalid Email", font: .systemFont(ofSize: 20.0),viewController: self)
            labelMessage.text = NSLocalizedString("invalid_email",comment:"")
        }
        
    }
    
    
    
    
    private func sendCode(){
        // send code
        showCodeViewController()
    }
    
    private func showCodeViewController(){
        self.performSegue(withIdentifier: "forgotpasswordTOcode", sender: nil)
    }
    
    
   
    

}
