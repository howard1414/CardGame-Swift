//
//  MatchingGame.swift
//  CardGame
//
//  Created by Lab1422 on 2021/3/22.
//

import Foundation

struct MatchingGame{
    
    var cards =  [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    init(numberOfPairsOfCards : Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            //cards.append(card)
            cards += [card,card]
        }
        
        
    }
    
    
    mutating func chooseCard(at index : Int) -> Int{
        var point:Int = 0
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    point = 5
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                point = -1
            }
        }
        return point
        
        
    }

    mutating func coverAllcard(){
        for index in cards.indices{
            cards[index].isFaceUp = false
        }
    }
    
    mutating func flipAllcard(){
        for index in cards.indices{
            cards[index].isFaceUp = true
        }
    }
    
    
}

