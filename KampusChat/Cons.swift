//
//  Notes.swift
//  KampusChat
//
//  Created by Burak on 20.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
/*
 
 - Cons
 
 ----- Common
 
 - App screen structure should be determined.(Splash-> Signup-> Email-Forgot Password, City,University... Signup -> etc...)
 - Api links should be determined. (Links type, body, response keys(userName??) and datas)
 
 
 ----App
 - Dependency Injections -> All Dependencies should be controlled by one.
 - Name Rules -> All Name' Rules(ex: viewTOsignin, actionSignin, showScreen ...) should be written in a file.
 - Class Description -> All Classes(except ViewControllers) should be described on the top of it, like: what is for, what it does and what it uses?
 - Complex Functions -> Complex Functions should be documented on the top of it.
 - Enum -> Keys that using different places should be in enum.(segue keys, urls, communication keys(ex: Academic Keys))
 - Util -> Functions that could be used by different places should be in a utils.
 - Localize String Keys Need Rules -> error_name_etc
 - Static Functions -> Project shouldn't have any static structure. It's untestable and unnecessary. Creating instance cost low price and more testable for future.
 
 - Single Responsibilty -> One class should have only 1 responsibilities.
 EX: All token class processes should be done by TokenViewController
 
 */
