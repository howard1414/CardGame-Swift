//
//  Card.swift
//  CardGame
//
//  Created by Lab1422 on 2021/3/22.
//

import Foundation

struct Card : Hashable{
    
    var hashValue:Int{
        return identifier
    }
    var getIdentifi:Int = 0
    
 
    
    static func ==(lhs: Card, rhs:Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
   
    
    var isFaceUp = false
    var isMatched = false
    
    var identifier:Int
    
    static var idF = 0
    init(){
        self.identifier = Card.getUniqueIdentifer()
    }
    static func getUniqueIdentifer() -> Int{
        idF += 1
        return idF
    }
    
}
