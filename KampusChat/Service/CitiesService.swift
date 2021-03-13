//
//  CitiesService.swift
//  KampusChat
//
//  Created by Burak on 12.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
import SwiftyJSON
class CitiesService{
   
    var request:URLRequest
    var manager:ApiManager?
    
    var cities:[City]?{
        didSet{
            bindServiceToViewModel()
        }
    }
    var error:String?
    
    var bindServiceToViewModel: (()->()) = {}
    
    init(){
        request = URLRequest(url: URL(string: ApiURL.getCities)!)
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
        Log.info(key:"Cities Service handleResponse",value:"is Begun")
        
        if(error != nil){
            // External Error
            Log.info(key:"Cities Service handleResponse()",value:"external error")
            self.error = NSLocalizedString("error_something_went_wrong", comment: "")
            self.cities = nil
            return
        }
        
        let httpResponse = response as? HTTPURLResponse
        if((200...299).contains((httpResponse?.statusCode)!)){
            // Success
            Log.info(key: "CitiesService handleResponse()",value: "success")
            self.error = nil
            self.cities = JSONCitiesParsing(data:data!)
            return
        }
        
        // Failed
        Log.info(key: "CitiesService handleResponse()",value: "failed")
        self.error = JSONErrorParsing(data: data!)
        self.cities = nil
        
    }
    

    private func JSONCitiesParsing(data:Data?)->[City]?{
        let json = try? JSON(data: data!)
        let datas = json!["data"]
        var cities:[City] = []
        
        for item in datas["cities"]{
            
            let temp = City(id:item.1["id"].intValue,name: item.1["name"].stringValue)
            cities.append(temp)
            
        }
        
        return cities
    }
    
    private func JSONErrorParsing(data:Data?)->String?{
        let json = try? JSON(data: data!)
        return json?["error"]["errors"][0].stringValue
    }
    
    
    
}
