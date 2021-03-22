//
//  Storage.swift
//  KampusChat
//
//  Created by Burak on 21.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation


/**
 Class Responsibility -> Storing All Types of Data And Giving Back to  Classes When They Need Data.
*/

class Storage{
    
    private let defaults = UserDefaults.standard
    
    init(){}
    
    public func saveString(data:String, key:String){
        Log.info(key: "saveString", value: "is Begun")
        defaults.set(data, forKey: key)
    }
    
    public func saveObject(data:Any, key:String){
        Log.info(key: "saveObject", value: "is Begun")
        defaults.set(data, forKey: key)
    }
    
    public func getString(key:String) -> String?{
        Log.info(key: "getString()", value: "is Begun")
        return defaults.string(forKey:key)
    }
    
    public func getObject(key:String) -> Any?{
        Log.info(key: "getObject()", value: "is Begun")
        return defaults.object(forKey:key)
    }
    
}
