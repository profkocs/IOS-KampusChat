//
//  Token+CoreDataProperties.swift
//  KampusChat
//
//  Created by Burak on 17.02.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//
//

import Foundation
import CoreData


extension Token {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Token> {
        return NSFetchRequest<Token>(entityName: "Token")
    }

    @NSManaged public var token: String?
    @NSManaged public var token_refresh: String?
    @NSManaged public var user_id: Int64

}
