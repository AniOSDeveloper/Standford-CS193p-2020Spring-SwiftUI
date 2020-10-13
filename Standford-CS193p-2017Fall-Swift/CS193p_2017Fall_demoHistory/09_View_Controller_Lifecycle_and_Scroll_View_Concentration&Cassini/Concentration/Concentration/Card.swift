//
//  Card.swift
//  Concentration
//
//  Created by Sophia_fez on 2020/7/28.
//  Copyright © 2020 Sophia_fez. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    // hashable
    var hashValue: Int { return identifier }
    func hash(into hasher: inout Hasher){

    }
    
    // equitable
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
