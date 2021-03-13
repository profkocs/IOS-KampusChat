//
//  CitiesProtocol.swift
//  KampusChat
//
//  Created by Burak on 14.03.2021.
//  Copyright © 2021 KampusChat. All rights reserved.
//

import Foundation
protocol CitiesProtocol {
    func handleCitiesResponse(cities: [City]?, error: String?) 
}
