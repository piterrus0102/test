//
//  Note.swift
//  test
//
//  Created by Элеста Элестов on 16.12.2020.
//  Copyright © 2020 Ruslan. All rights reserved.
//

import Foundation

class Note {
    
    var name: String!
    var time: NSDate!
    var description: String!
    
    init(name: String, time: NSDate, description: String) {
        self.name = name
        self.time = time
        self.description = description
    }
    
    
}
