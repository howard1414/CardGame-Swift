//
//  ViewController.swift
//  CardGame
//
//  Created by Lab1422 on 2021/3/10.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    

    var emojis = ["🧑","👨‍🦱","🧕","🧑","😀","🎃","🥺","👩‍🦳"]
    var emojiChoices = ["🚗","🚙","🚕","🛺","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🚚","🚛","🚜","🏍","🛵"]
    var emojiDict = [Int:String]()
    var res:Bool = false
    
    
    @IBOutlet weak var ct: UILabel!
    
    var flipCount:Int = 0 {
        didSet{
            ct.text = "Counts: \(flipCount)"
        }
    }
    
    @IBOutlet weak var sc: UILabel!
    
    var Score:Int = 0 {
        didSet{
            sc.text = "Score: \(Score)"
        }
    }
    
    @IBOutlet var CardButtons: [UIButton]!
    var game = MatchingGame(numberOfPairsOfCards: 16)
    var tempscore:Int=0
    @IBAction func touchcard(_ sender: UIButton) {
        if let cardNumber = CardButtons.firstIndex(of: sender){
            tempscore = game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        }else{
            print("not in collection")
        }
        Score = tempscore + Score
        flipCount =  flipCount + 1
        
        
        
    }
    
    func flipCard(withEmoji emoji: String, on button:UIButton){
        if button.currentTitle == emoji{
            button.setTitle("",for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }else{
            button.setTitle(emoji,for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    @IBAction func ShuffleButton(_ sender: UIButton) {
        
        
            for index in CardButtons.indices{
                var shuffle = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                var temp:Int
                
                temp = game.cards[index].hashValue
                game.cards[index].identifier = game.cards[shuffle].identifier
                game.cards[shuffle].identifier = temp
                 
            }
            updateViewFromModel()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
 

    
    @IBAction func Reset(_ sender: UIButton) {
        var flipcount:Int = 0
        for index in CardButtons.indices{
            if(game.cards[index].isFaceUp){
                flipcount += 1
            }
        }
        if(flipcount == 0){
            for index in CardButtons.indices{
                game.cards[index].isFaceUp = true
                game.cards[index].isMatched = true
                
            }
        }else if(flipcount > 0 && flipcount < CardButtons.count){
            for index in CardButtons.indices{
                game.cards[index].isFaceUp = true
                game.cards[index].isMatched = true
            }
        }else if(flipcount == CardButtons.count){
            
            for index in CardButtons.indices{
                game.cards[index].isFaceUp = false
                game.cards[index].isMatched = false
            }
            flipCount = 0
            Score = 0
            tempscore = 0
        }
        updateViewFromModel()
        
        //flipCount = 0
        //Score = 0
        //tempscore = 0
    }
    
    var emojiDic = [Card:String]()
    func getEmoji(for card: Card) -> String{
        if emojiDic[card] == nil, emojiChoices.count>0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            //emojiDict[card.identifier] = emojiChoices[randomIndex]
            emojiDic[card] = emojiChoices.remove(at: randomIndex)
        }
            return emojiDic[card] ?? "?"
    }
    
    /*
    func emoji(for card: Card) -> String{
        if emojiDict[card] == nil, emojiChoices.count>0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            //emojiDict[card.identifier] = emojiChoices[randomIndex]
            emojiDict[card] = emojiChoices.remove(at: randomIndex)
        }
            return emojiDict[card] ?? "?"
            
    }
    */
    
    func updateViewFromModel() {
        
        for index in CardButtons.indices{
            let button = CardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                
                button.setTitle(getEmoji(for: card),for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.7952535152, green: 0.7952535152, blue: 0.7952535152, alpha: 1):#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            }
        }
        
        
        
        
        
        
    }
    
    
    

}


