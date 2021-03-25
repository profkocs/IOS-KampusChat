//
//  TokenViewModel.swift
//  KampusChat
//
//  Created by Burak on 21.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
import SwiftyJSON


/*
 Class Responsibility ->
 
   - Getting Token From Storage and Delivering it.
   - Saving Token To Storage
   - Encoding Token To Store in Storage
   - Decoding Token To Deliver it.
   - Json Parsing To Save New Token
 
 Class Dependency ->
 
    - Storage
*/
 

class TokenViewModel{
    
    private var token:Token?
    private var storage = Storage()
    

    init(token:Token?){
        self.token = token
    }
    
    /*
    closure -> tokenModel
    description: A bridge for other classes to reach the token variable.
    responsibility: to initialize token from storage and return it.
     */
    
    var tokenModel:Token?{
        
        if(token == nil){
            
            let data = getEncodedTokenFromStorage()
            
            if(data != nil){
                
                token = decodeToken(data: data as! Data)
            }
            
        }
        
        return self.token
    }
    
    
    // Getting Token From Storage
    
    func getEncodedTokenFromStorage()->Any?{

        return storage.getObject(key: StorageKeys.token.rawValue)
    }
    
    // Saving Token To Storage
    
    func saveToken() {
        
        Log.info(key: "saveToken()", value: "is Begun")
        
        let encodedToken = encodeToken()
       
        if(encodedToken != nil){
            storage.saveObject(data:encodedToken as Any, key: StorageKeys.token.rawValue)
        }
    }
    
    // Encoding Token To Store in Storage
    
    func encodeToken()-> Data?{
        
        do{
            return try JSONEncoder().encode(token)
        } catch {
            return nil
        }
        
    }
    
    // Decoding Token To Deliver it.
    
    func decodeToken(data:Data) -> Token? {
        
        do{
            return try JSONDecoder().decode(Token.self, from: data)
        } catch {
            return nil
        }
    }
    
    // Getting Token Data From ViewController
    
    var data:Data?{
        
        didSet{
            
            self.token = JSONTokenParsing()
        }
        
    }
    
    // Json Parsing To Save New Token
    
    func JSONTokenParsing()-> Token{
        
        let json = JSON(self.data)
        
        let data = json[AuthServiceKeys.data.rawValue]
        
        let user_id = data[AuthServiceKeys.user_id.rawValue].stringValue
        
        let accessToken = data[AuthServiceKeys.accessToken.rawValue].stringValue
        
        let accessTokenExpiration = data[AuthServiceKeys.accessTokenExpiration.rawValue].stringValue
        
        let refreshToken = data[AuthServiceKeys.refreshToken.rawValue].stringValue
        
        let refreshTokenExpiration = data[AuthServiceKeys.refreshTokenExpiration.rawValue].stringValue
        
        
        return Token(user_id: user_id, accessToken: accessToken, accessTokenExpiration: accessTokenExpiration, refreshToken: refreshToken, refreshTokenExpiration: refreshTokenExpiration)
        
        
    }
  
    
    
    
}
