//
//  File.swift
//  KampusChat
//
//  Created by Burak on 12.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
struct Signup:Codable{
    
    var countryId = 1
    var cityId:Int?
    var universityId:Int?
    var facultyId:Int?
    var departmentId:Int?
    var password:String?
    var userName:String?
    var email:String?
    
    
    init(){}
    
}
