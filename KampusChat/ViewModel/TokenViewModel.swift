//
//  TokenViewModel.swift
//  KampusChat
//
//  Created by Burak on 21.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation


/*
 Class Responsibility -> Handling All Token Processes.
*/

class TokenViewModel{
    
    private var token:Token?
    private var storage:Storage
    
    init(token:Token?, storage:Storage){
        self.token = token
        self.storage = storage
    }
    
    /*
    closure -> tokenModel
    description: A bridge for other classes to reach the token variable.
    responsibility: to initialize token from storage and return it.
     */
    
    var tokenModel:Token?{
        
        if(token == nil){
            
            let data = storage.getObject(key: StorageKeys.token.rawValue)
            token = decodeToken(data: data as! Data)
        
        }
        
        return self.token
    }
        
    func saveToken() {
        
        Log.info(key: "saveToken()", value: "is Begun")
        
        let encodedToken = encodeToken()
       
        if(encodedToken != nil){
            storage.saveObject(data:encodedToken as Any, key: StorageKeys.token.rawValue)
        }
    }
    
    
    func encodeToken()-> Data?{
        
        do{
            return try JSONEncoder().encode(token)
        } catch {
            return nil
        }
        
    }
    
    func decodeToken(data:Data) -> Token? {
        
        do{
            return try JSONDecoder().decode(Token.self, from: data)
        } catch {
            return nil
        }
    }
  
    
    
    
}
