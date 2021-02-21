//
//  Storage.swift
//  KampusChat
//
//  Created by Burak on 21.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation

class Storage{
    
    private let defaults = UserDefaults.standard
    
    init(){}
    
    public func saveString(object:String, key:String){
        Log.info(key: "saveString()", value: "is Begun")
        defaults.set(object,forKey:key)
    }
    
    public func saveInt(object:Int64, key:String){
        Log.info(key: "saveInt()", value: "is Begun")
        defaults.set(object, forKey: key)
    }
    
    public func getString(key:String) -> String?{
        Log.info(key: "getString()", value: "is Begun")
        return (defaults.object(forKey: key) as! String?)
    }
    
    public func getInt(key:String) -> Int64?{
        Log.info(key: "getInt()", value: "is Begun")
        return defaults.object(forKey: key) as! Int64?
    }
}
