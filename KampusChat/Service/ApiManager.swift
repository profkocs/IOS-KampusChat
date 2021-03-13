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
    
    
    var task:URLSessionDataTask?
    var request:URLRequest
    
    var data:Data?{
        didSet{
            self.bindManagerToService()
        }
    }
    var response:URLResponse?
    var error:Error?
    
    var bindManagerToService: (()->()) = {}
    
    init(request:URLRequest){
        self.request = request
    }
    
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
