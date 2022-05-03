//
//  Employee.swift
//  jadidi
//
//  Created by Leila Nezaratizadeh on 20/04/2022.
//

import Foundation



struct Pet: Codable , Equatable {
    
   
    var id: UInt64 
    var name: String?
    var status: String?
    var tags: [Tag]
    var category: Category?
    var photoUrls: [String]
    
    static func == (lhs: Pet, rhs: Pet) -> Bool {
        return lhs.name == rhs.name
    }
    
    
}


