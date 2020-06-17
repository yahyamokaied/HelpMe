//
//  Users.swift
//  helpme
//
//  Created by Yahya Mokaied on 17/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import Foundation

struct Users : Codable {
    
    let subjectName : String
       let name : String
       let email : String
       let price : String
       let isTeacher : Bool
    
    
    enum CodingKeys: String, CodingKey {
        case subjectName
        case name
        case email
        case price
        case isTeacher
    }
}
