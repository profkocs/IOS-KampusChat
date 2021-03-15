//
//  CitiesService.swift
//  KampusChat
//
//  Created by Burak on 12.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
import SwiftyJSON
class AcademicService{
   
    var request:URLRequest
    var manager:ApiManager?
    
    var datas:[Academic]?{
        didSet{
            bindServiceToViewModel()
        }
    }
    var error:String?
    
    var bindServiceToViewModel: (()->()) = {}
    
    /**
     variable key
     description: To know which response type(City,University,Faculty,Department)
                    will be used for Json parsing.
    */
    
    var key:String = ""
    
    init(url:String, key:String){
        
        self.key = key
        
        request = URLRequest(url: URL(string: url)!)
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
        request.httpMethod = "GET"
    }
    
    func handleResponse(data: Data?, response: URLResponse, error: Error?){
        Log.info(key:"Academic Service handleResponse",value:"is Begun")
        
        if(error != nil){
            // External Error
            Log.info(key:"Academic Service handleResponse()",value:"external error")
            self.error = NSLocalizedString("error_something_went_wrong", comment: "")
            self.datas = nil
            return
        }
        
        let httpResponse = response as? HTTPURLResponse
        if((200...299).contains((httpResponse?.statusCode)!)){
            // Success
            Log.info(key: "Academic Service handleResponse()",value: "success")
            self.error = nil
            self.datas = JSONParsing(data:data!)
            return
        }
        
        // Failed
        Log.info(key: "Academic Service handleResponse()",value: "failed")
        self.error = JSONErrorParsing(data: data!)
        self.datas = nil
        
    }
    
    
    private func JSONParsing(data:Data?)->[Academic]?{
        let json = try? JSON(data: data!)
        var jsonDatas = json!["data"]
        
        if(key == AcademicKeys.faculty2.rawValue){
            jsonDatas = json!["data"][AcademicKeys.faculty.rawValue]
        }
        
        var datas:[Academic] = []
        
        for item in jsonDatas[key]{
            
            let temp = Academic(id:item.1["id"].intValue,name: item.1["name"].stringValue)
            datas.append(temp)
            
        }
        
        return datas
    }
    
    private func JSONErrorParsing(data:Data?)->String?{
        let json = try? JSON(data: data!)
        return json?["error"]["errors"][0].stringValue
    }
    
    
    
}
