//
//  UniversitiesViewController.swift
//  KampusChat
//
//  Created by Burak on 13.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import UIKit

class UniversitiesViewController: UIViewController {

    var signupViewModel:SignupViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cities = segue.destination as? CityViewController {
            Log.info(key: "prepare", value: "is Begun")
            signupViewModel = cities.signupViewModel
            print("City Id:",signupViewModel.signup.city_id)
        }
    }
*/
}
