//
//  CitiesViewModel.swift
//  KampusChat
//
//  Created by Burak on 12.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
class CitiesViewModel{
    
    

    var service:CitiesService
    var cities:[City]?{
        didSet{
            bindViewModelToController()
        }
    }
    var error:String?
    
    var bindViewModelToController: (()->()) = {}
    
    
    init(){
        service = CitiesService()
        service.bindServiceToViewModel = {
            self.error = self.service.error
            self.cities = self.service.cities
        }
    }
  
    
}
