//
//  SignupService.swift
//  KampusChat
//
//  Created by Burak on 21.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
import SwiftyJSON
class SignupService{
    
    var manager:ApiManager?
    var model:Signup
    var request:URLRequest
    
    var errors:[String]?{
        didSet{
            bindServiceToViewModel()
        }
    }
    
    var bindServiceToViewModel: (()->()) = {}
    
    init(model:Signup){
        self.model = model
        request = URLRequest(url: URL(string: ApiURL.createUser.rawValue)!)
        setRequest()
        manager = ApiManager(request: self.request)
        manager!.startTask()
        manager?.bindManagerToService = {
            self.handleResponse(data: self.manager?.data, response: (self.manager?.response)!, error: self.manager?.error)
        }
    }
    
    private func setRequest(){
        Log.info(key: "Request", value: "didset")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = JSONEncode()
    }
    
    private func JSONEncode()->Data?{
        let jsonEncoder = JSONEncoder()
        do {
            return try jsonEncoder.encode(model)
        } catch {
            Log.info(key: "SigninService JSONEncode()",value: "encoder error")
            return nil
            
        }
    }
    
    func handleResponse(data: Data?, response:URLResponse, error:Error?) {
        Log.info(key: "SignupService handleResponse()",value: "is Begun")
        
        if(error != nil){
            // External Error
            Log.info(key: "SignupService handleResponse()",value: "external error")
            self.errors?.append(NSLocalizedString("error_something_went_wrong", comment: ""))
            return
        }
        
        let httpResponse = response as? HTTPURLResponse
        if((200...299).contains((httpResponse?.statusCode)!)){
            // Success
            Log.info(key: "SignupService handleResponse()",value: "success")
            self.errors = nil
            return
        }
        
        // Failed
        Log.info(key: "SignupService handleResponse()",value: "failed")
        self.errors = JSONErrorParsing(data: data!)
    }
    
    private func JSONErrorParsing(data:Data?)->[String]?{
        let json = try? JSON(data: data!)
        var errors:[String]? = []
        
        for error in json!["error"]["errors"]{
            print(error.1.stringValue)
            errors?.append(error.1.stringValue)
        }
        
        if(errors != nil){
            print("Hahaha")
        }
        
        return errors
    }
    
    
}
