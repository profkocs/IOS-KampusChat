//
//  AuthViewModel.swift
//  KampusChat
//
//  Created by Burak on 25.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
protocol AuthViewModel {
    
    func getAPIResponse(data: Data?, error:[String]?)
    func encodeModel()->Data?
}
