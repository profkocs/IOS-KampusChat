//
//  ResponseProtocol.swift
//  KampusChat
//
//  Created by Burak on 9.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
protocol ResponseProtocol {
    func handleResponse(data:Data?, response:URLResponse, error:Error?)
}
