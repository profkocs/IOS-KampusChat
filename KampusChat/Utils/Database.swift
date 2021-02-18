//
//  Database.swift
//  KampusChat
//
//  Created by Burak on 17.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class Database{
    
    var context:NSManagedObjectContext?
    var items: [NSManagedObject]?;
    
    
    init() {
        context = ((UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext);
    }
    
    
    /* Common */
    
    func save() -> Bool{
        do{
            try self.context?.save()
            return true
        }
        catch{
            print("Saving Data Error")
            return false
        }
    }
    
    
    /* Token */
    
    func getCurrentToken()-> Token?{
        Log.info(key: "getToken()", value: "is Begun")
        
        let token = Token(context: self.context!)
        
        do{
            self.items = try context!.fetch(Token.fetchRequest())
            
            if((items?.count)! > 0){
                Log.info(key: "getToken()", value: "Token is loading")
                let itemFirst = (items as! [Token]).first
                
                if(itemFirst?.user_id != nil && itemFirst?.token != nil && itemFirst?.token_refresh != nil){
                    token.user_id = (itemFirst!.user_id)
                    token.token = (itemFirst!.token)
                    token.token_refresh = (itemFirst!.token_refresh)
                }
                
                return token
            }
            
        }
        catch{
            Log.info(key: "getToken()", value: "Error Reading Token Data")
            return nil
        }
 
        Log.info(key: "getToken()", value: "Token isn't exist")
 
        return token
    }
    
    func saveToken(user_id:Int64, token:String, token_refresh:String) -> Bool{
        Log.info(key: "saveToken()", value: "is Begun")
        let newToken = Token(context: self.context!)
        
        newToken.user_id = user_id;
        newToken.token = token;
        newToken.token_refresh = token_refresh;
        let success = save()
        
        if(success){
            Log.info(key: "saveToken()", value: "is saved")
            return true
        }
         Log.info(key: "saveToken()", value: "Error Saving")
        return false
    }
    
    
   
    
    
    
    
    
}
