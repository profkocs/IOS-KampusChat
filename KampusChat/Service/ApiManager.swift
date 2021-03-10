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
    
    
    var responseProtocol:ResponseProtocol
    var task:URLSessionDataTask?
    var request:URLRequest
    
    init(request:URLRequest,responseProtocol:ResponseProtocol){
        self.request = request
        self.responseProtocol =  responseProtocol
    }
    
    func startTask(){
        Log.info(key: "Task", value: "is Begun")
        task =  URLSession.shared.dataTask(with:request) { (data, response, error) in
            Log.info(key: "task", value: "is done")
            self.responseProtocol.handleResponse(data: data, response: response!, error: error)
            
        }
        task!.resume()
    }
    
    
    public func stopTask(){
        task!.cancel()
    }

    
}
