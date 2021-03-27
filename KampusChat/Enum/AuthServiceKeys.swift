//
//  ServiceErrorKeys.swift
//  KampusChat
//
//  Created by Burak on 25.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
enum AuthServiceKeys:String{
    
    // Common
    case data = "data"
    case error = "error"
    case errors = "errors"
    
    
    // Sign in
    
    case user_id = "user_id"
    case accessToken = "accessToken"
    case accessTokenExpiration = "accessTokenExpiration"
    case refreshToken = "refreshToken"
    case refreshTokenExpiration = "refreshTokenExpiration"
    
    
    // Academic
    
    case city = "cities"
    case university = "universities"
    case faculty = "universityFaculties"
    case faculty_inline = "faculty"
    case department = "departments"
    
    // Academic Model
    
    case id = "id"
    case name = "name"
    
    
    // Sign up
    
    case signup_error_username = "User name"
    case signup_error_email = "Email"
    
    
}
