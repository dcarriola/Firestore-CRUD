//
//  User.swift
//  CRUD
//
//  Created by Daniel Alejandro Carriola on 3/29/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: String? { get set }
}

struct User: Codable, Identifiable {
    // Variables
    var id: String? = nil
    let name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
