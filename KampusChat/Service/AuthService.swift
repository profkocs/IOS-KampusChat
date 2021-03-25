//
//  AuthService.swift
//  KampusChat
//
//  Created by Burak on 25.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

/*
  Class Responsibilites ->
    - Creating a request and sending it to API manager.
    - Getting Response from the API manager and delivering it in specific
    - Json Parsing For Error
 
  Class Dependencies ->
    - AuthViewModel
    - Request
    - ApiManager
    - URL
*/

import Foundation
import SwiftyJSON
class AuthService{
    
    
    var viewModel:AuthViewModel
    
    init(viewModel:AuthViewModel){
        
        self.viewModel = viewModel
        
    }
    
    // Request
    
    private var request:URLRequest?
    
    func createPostRequest(url: URL){
        
        request = URLRequest(url: url)
        request?.httpMethod = "POST"
        
        setRequestHeader()
        setRequestBody()
        
        setApiManager()
        
    }
    
    func createGetRequest(url: URL){
        
        request = URLRequest(url: url)
        request?.httpMethod = "GET"
        
        setRequestHeader()
        setRequestBody()
        
        setApiManager()
        
        
    }
    
    private func setRequestHeader(){
        
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    private func setRequestBody(){
        
        print(self.viewModel.encodeModel())
        request?.httpBody = self.viewModel.encodeModel()
    }
    
    // Api Manager
    
    private var apiManager:ApiManager?
    
    private func setApiManager(){
        
        apiManager = ApiManager(request: self.request!)
        
        setApiManagerBinding()
    }
    
    private func setApiManagerBinding(){
        
        apiManager?.bindManagerToService = {
            
            self.setResponse(response:(self.apiManager?.response)!)
            
            self.setError(error:(self.apiManager?.error))
            
            self.setData(data:(self.apiManager?.data))
        }
        
    }
    
    func startTask(){
        
        apiManager?.startTask()
    }
    
    func stopTask(){
        
        apiManager?.stopTask()
    }
    
    // Response, Data, Error
    
    private func setResponse(response:URLResponse){
        self.response = response
    }
    
    private func setError(error:Error?){
        
        if(error != nil){
            self.error = error
        }
        
    }
    
    private func setData(data:Data?){
        
        if(data != nil){
            self.data = data
        }
        
    }
    
    private var statusCode = 0
    
    private var response:URLResponse?{
        
        didSet{
            
            let httpResponse = response as? HTTPURLResponse
            
            self.statusCode = (httpResponse?.statusCode)!
            
        }
        
    }
    
    
    private var error:Error?{
        
        didSet{
            
            Log.info(key: "AuthService error", value: "is Begun")
            
            // External Error
            viewModel.getAPIResponse(data: nil, error: preapareExternalErrorsArray())
            
        }
        
    }
    
    private var data:Data?{
        
        didSet{
            
            if((200...299).contains((statusCode))){
                // Success
                
                Log.info(key: "AuthService data", value: "success")
                
                viewModel.getAPIResponse(data: data, error: nil)
                
            }else{
                // Failed
                
                Log.info(key: "AuthService data", value: "failed")
                
                viewModel.getAPIResponse(data: nil, error: JSONErrorParsing(data: self.data))
            }
            
        }
    }
    
    // Error JSON Parsing
    
    private func preapareExternalErrorsArray() -> [String]{
        
        var errors:[String] = []
        
        let error = NSLocalizedString("error_something_went_wrong", comment: "")
        
        errors.append(error)
        
        return errors
    }
    
    private func JSONErrorParsing(data:Data?)->[String]?{
        
        let json = try? JSON(data: data!)
        
        
        var errors:[String]? = []
        
        for error in json![AuthServiceKeys.error.rawValue][AuthServiceKeys.errors.rawValue] {
            
            errors?.append(error.1.stringValue)
        }
        
        
        return errors
    }
    
    
   
    
    
}
