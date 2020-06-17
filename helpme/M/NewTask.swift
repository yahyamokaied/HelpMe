//
//  NewTask.swift
//  helpme
//
//  Created by Yahya Mokaied on 17/06/2020.
//  Copyright © 2020 Yahya Mokaied. All rights reserved.
//

import Foundation


struct NewTask : Codable {
    let subjectName : String
    
    
    enum CodingKeys: String, CodingKey {
        case subjectName
        
    }
}


