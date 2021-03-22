//
//  ApiManager.swift
//  KampusChat
//
//  Created by Burak on 9.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

// Quote:If you don't know how it's gonna happen,
//          then don't bother to build design. Just get experience.

import Foundation
class ApiManager{
    
    /**
     responsibility: Send Request To server and get data, response and error.
                     Then trasmit them to service.
     
     **/
    
    // Required Variables
    var task:URLSessionDataTask?
    var request:URLRequest
    
    // Return Variables
    var data:Data?{
        didSet{
            self.bindManagerToService()
        }
    }
    var response:URLResponse?
    var error:Error?
    
    // Trasmition Way
    var bindManagerToService: (()->()) = {}
    
    //Initialize
    init(request:URLRequest){
        self.request = request
    }
    
    // Process Function
    func startTask(){
        Log.info(key: "Task", value: "is Begun")
        task =  URLSession.shared.dataTask(with:request) { (data, response, error) in
            Log.info(key: "task", value: "is done")
            self.error = error
            self.response = response
            self.data = data
        }
        task!.resume()
    }
    
    public func stopTask(){
        task!.cancel()
    }

    
}
