//
//  AuthService.swift
//  KampusChat
//
//  Created by Burak on 9.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
import SwiftyJSON
class SigninService{
    
    var manager:ApiManager?
    var model:Signin
    var request:URLRequest
    
    var token:Token?{
        didSet{
            bindServiceToViewModel()
        }
    }
    var error:String?
    
    var bindServiceToViewModel: (()->()) = {}
    
    init(model:Signin){
        self.model = model
        request = URLRequest(url: URL(string: ApiURL.createToken)!)
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
        Log.info(key: "SigninService handleResponse()",value: "is Begun")
        
        if(error != nil){
            // External Error
            Log.info(key: "SigninService handleResponse()",value: "external error")
            self.error = NSLocalizedString("error_something_went_wrong", comment: "")
            self.token = nil
            return
        }
        
        let httpResponse = response as? HTTPURLResponse
        if((200...299).contains((httpResponse?.statusCode)!)){
         // Success
            Log.info(key: "SigninService handleResponse()",value: "success")
            self.error = nil
            self.token = JSONTokenParsing(data:data!)
            return
        }
        
        // Failed
        Log.info(key: "SigninService handleResponse()",value: "failed")
        self.error = JSONErrorParsing(data: data!)
        self.token = nil
    }
    
    private func JSONTokenParsing(data:Data?)->Token?{
        let json = try? JSON(data: data!)
        let tokenData = json!["data"]
        return Token(user_id: tokenData["userId"].stringValue, accessToken: tokenData["accessToken"].stringValue, accessTokenExpiration: tokenData["accessTokenExpiration"].stringValue, refreshToken: tokenData["refreshToken"].stringValue, refreshTokenExpiration: tokenData["refreshTokenExpiration"].stringValue)
        
    }
    
    private func JSONErrorParsing(data:Data?)->String?{
        let json = try? JSON(data: data!)
        return json!["error"]["errors"][0].stringValue
    }
    
    
}
