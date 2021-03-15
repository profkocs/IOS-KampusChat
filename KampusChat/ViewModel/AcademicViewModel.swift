//
//  CitiesViewModel.swift
//  KampusChat
//
//  Created by Burak on 12.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
class AcademicViewModel{
    
    var service:AcademicService
    var datas:[Academic]?{
        didSet{
            bindViewModelToController()
        }
    }
    var error:String?
    
    var bindViewModelToController: (()->()) = {}
    
    
    init(url:String, key:String){
        service = AcademicService(url: url, key: key)
        service.bindServiceToViewModel = {
            self.error = self.service.error
            self.datas = self.service.datas
        }
    }
    

}
