//
//  Users.swift
//  helpme
//
//  Created by Yahya Mokaied on 17/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import Foundation


    


struct TaskDetails : Codable {
    
    let title : String
       let desc : String
       let comments : [String]

    
    
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case desc
        case comments
    }
}

