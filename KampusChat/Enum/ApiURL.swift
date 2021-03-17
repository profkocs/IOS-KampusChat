//
//  ApiURL.swift
//  KampusChat
//
//  Created by Burak on 10.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
enum ApiURL: String{
    
    
    case createToken = "https://kampuschatdeneme.herokuapp.com/api/Auth/CreateToken"
    case cities = "https://kampuschatdeneme.herokuapp.com/api/SignUp/GetCities/id"
    case universities = "https://kampuschatdeneme.herokuapp.com/api/SignUp/GetUniversities/id"
    case faculties = "https://kampuschatdeneme.herokuapp.com/api/SignUp/GetFaculties/id"
    case departments = "https://kampuschatdeneme.herokuapp.com/api/SignUp/GetDepartments/id"
    case createUser = "https://kampuschatdeneme.herokuapp.com/api/SignUp/CreateUser"
    
}
