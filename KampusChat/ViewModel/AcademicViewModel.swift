//
//  CitiesViewModel.swift
//  KampusChat
//
//  Created by Burak on 12.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

/**
 
 Class Responsibilites ->
 
 -
 - Getting Datas From Service
 - Delivering Datas To ViewController
 - Making Start Action
 - Faculty List Parsing
 - Academic List(City,University,Department) Parsing
 
 Class Dependencies ->
 
 - Service
 
 */

import Foundation
import SwiftyJSON

class AcademicViewModel:AuthViewModel{
   
    
    
    var service:AuthService?
  
    var url:String
    
    init(url:String){
        
        self.url = url
        
        self.service = AuthService(viewModel: self)
    }
    
    // Making Start Action
    
    func startAction(){
        
        service?.createGetRequest(url: URL(string: self.url)!)
        
        service?.startTask()
    }
    
    //Getting Datas From Service
    
    func getAPIResponse(data: Data?, error: [String]?) {
        
        self.error = error
        self.data = data
    }
    
    func encodeModel() -> Data? {
        return nil
    }
    
    
    // Delivering Data To ViewController
    
    var bindViewModelToController: (()->()) = {}
    
    var data:Data?{
        
        didSet{
            
            Log.info(key: "AcademicViewModel data", value: "didSet")
            
            bindViewModelToController()
        }
    }
    
    var error: [String]?
    
    // Faculty List Parsing
    
    func getFacultyList()->[Academic]?{
        
        var list:[Academic] = []
        
        let json = JSON(self.data)
        
        let data = json[AuthServiceKeys.data.rawValue]
        
        for item in data[AuthServiceKeys.faculty.rawValue]{
        
            let id = item.1[AuthServiceKeys.faculty_inline.rawValue][AuthServiceKeys.id.rawValue].intValue
            
            let name = item.1[AuthServiceKeys.faculty_inline.rawValue][AuthServiceKeys.name.rawValue].stringValue
            
            let academic = Academic(id: id, name: name)
            
            print(academic.id)
            
            list.append(academic)
            
        }
        
        return list
        
    }
    
    /** Academic List(City or University or Department) Parsing
     @param key:String -> AuthServiceKeys -> city, university, department
    */
    
    func getAcademicList(key:String) -> [Academic]?{
        
        var list:[Academic] = []
        
        let json = JSON(self.data)
        
        let data = json[AuthServiceKeys.data.rawValue]
        
        for item in data[key]{
            
            let id = item.1[AuthServiceKeys.id.rawValue].intValue
            
            let name = item.1[AuthServiceKeys.name.rawValue].stringValue
            
            let academic = Academic(id: id, name: name)
            
             print(academic.id)
            
            list.append(academic)
            
        }
        
        return list
        
    }
    
    
}
