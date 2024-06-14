//
//  model.swift
//  UI-DesignPatterns
//
//  Created by Sparkout on 13/06/24.
//

import Foundation

struct Item: Decodable {
    let id: Int
        let title: String
        let price: Double
        let description: String
        let category: String
        let image: String
        let rating: Rating
        
        struct Rating: Decodable {
            let rate: Double
            let count: Int
        }
}
