//
//  CodeViewController.swift
//  KampusChat
//
//  Created by Burak on 11.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldCode: UITextField!
    @IBOutlet weak var labelStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       setTextfieldAcceptOnlyNumber()
    }
    
    
    private func setTextfieldAcceptOnlyNumber(){
        textFieldCode.keyboardType = .numberPad
        textFieldCode.delegate = self
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let invalidCharacters =
            CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }

    @IBAction func isCodeValid(_ sender: Any) {
  
        if(textFieldCode.text?.count != 6){
            labelStatus.text = NSLocalizedString("insufficient_code_digit_number",comment:"")
        }else{
            labelStatus.text = ""
            checkCode()
        }
    }
    
    
    
    private func checkCode(){
        //Check code from api
        showResetPassword()
    }
    
    private func showResetPassword(){
        self.performSegue(withIdentifier: "codeTOresetpassword", sender: nil)
    }
    
}
