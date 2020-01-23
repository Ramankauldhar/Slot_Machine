/*MAPD724-W2020
 Assignment 1 - Slot Machine
 
 Group 13 (Dalwinder Singh - 301089722, Vishal Patel - 301090662, Ramandeep - 301095150)
 
 Date: 22/01/20
 
 Version: 1.2
 */

import UIKit

class ViewController: UIViewController {

    //Image Outlets (The 3 Reel Images)
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    //Outlets for Player Money, Bet Amount, and Info Message
    @IBOutlet weak var playerMoney: UILabel!
    @IBOutlet weak var bet: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Default values on App Launch
        playerMoney.text = "1000"
        bet.text = "10"
        message.text = ""
    }

    //Function to Start the Slot Machine
    @IBAction func start(_ sender: UIButton) {
        
        //If Player Money is 0, don't let him start
        if(playerMoney.text == "0") {
            message.text = "You are out of Money!!"
        }
            
        //else deduct Bet Amount from Player Money
        else {
            var plMoney = Int(playerMoney.text!)  //Player Money from String to Integer
            let betNum = Int(bet.text!)     //Bet Amount from String to Integer
            plMoney = plMoney! - betNum!
            /*if(plMoney! < betNum!) {
                bet.text = String(plMoney!)
            }*/
            playerMoney.text = String(plMoney!)  //Player Money from Integer to String
            
            //Determine the images to display now
            reels()
        }
    }
    
    //Function to implement Reels' Images
    private func reels() -> Void {
        var spinResult:[String] = ["", "", ""]
        //var randVal:Int
        
        //Find the 3 random outcomes and create a string array
        for i in 0...2
        {
            //Random Value between 1 and 65 (inclusive)
            let randVal:Int = Int.random(in: 0..<65) + 1
            
            switch(randVal)
            {
                //Interval Matching
                case 1..<28:spinResult[i] = "blank"     //41.5% probability
                            break
                case 28..<38:spinResult[i] = "grapes"   //15.4% probability
                            break
                case 38..<47:spinResult[i] = "banana"   //13.8% probability
                            break
                case 47..<55:spinResult[i] = "orange"   //12.3% probability
                            break
                case 55..<60:spinResult[i] = "cherry"   //7.7% probability
                            break
                case 60..<63:spinResult[i] = "apple"    //4.6% probability
                            break
                case 63..<65:spinResult[i] = "bells"    //3.1% probability
                            break
                case 65:spinResult[i] = "7"             //1.5% probability
                            break
                default:break
            }
            //print(spinResult[i])
        }
        //Set Images now
        setImages(ResArray: spinResult)
        
        //Determine Winnings
        calcRewards(ResArray: spinResult)
    }
    
    //Function to set Images on each Reel
    private func setImages(ResArray:[String]) -> Void {
        
        //Each Array String is basically the exact image file name without extension, add it
        let image1:UIImage = UIImage(named: "\(ResArray[0]).png")!
        img1.image = image1
        let image2:UIImage = UIImage(named: "\(ResArray[1]).png")!
        img2.image = image2
        let image3:UIImage = UIImage(named: "\(ResArray[2]).png")!
        img3.image = image3
    }
    
    //Function to determine winnings
    private func calcRewards(ResArray:[String]) -> Void {
        
        //Set counts to 0 for each Fruit/Item
        var blanks = 0
        var grapes = 0
        var bananas = 0
        var oranges = 0
        var cherries = 0
        var apples = 0
        var bells = 0
        var sevens = 0
        
        var winnings = 0
        let betNum = Int(bet.text!)          //Bet Amount from String to Integer
        var plMoney = Int(playerMoney.text!) //Player Money from String to Integer
        
        //jackpot Flag
        var jackFlag = false
        
        //count each occurrence of items in Array
        for string in ResArray
        {
            switch(string) {
            case "blank":blanks+=1
                break
            case "grapes":grapes+=1
                break
            case "banana":bananas+=1
                break
            case "orange":oranges+=1
                break
            case "cherry":cherries+=1
                break
            case "apple":apples+=1
                break
            case "bells":bells+=1
                break
            case "7":sevens+=1
                break
            default:break
            }
        }
        //print(blanks)
        
        //if there are no blanks, player won something
        if(blanks == 0)
        {
            if(grapes == 3) {
                winnings = betNum! * 10
            }
            else if(bananas == 3) {
                winnings = betNum! * 20
            }
            else if(oranges == 3) {
                winnings = betNum! * 30
            }
            else if(cherries == 3) {
                winnings = betNum! * 40
            }
            else if(apples == 3) {
                winnings = betNum! * 50
            }
            else if(bells == 3) {
                winnings = betNum! * 75
            }
            else if(sevens == 3) {
                winnings = betNum! * 100
                message.text = "YOU WON THE JACKPOT!!!"
                
                //jackpot flag set to true for info message distinction
                jackFlag = true
            }
            else if(grapes == 2) {
                winnings = betNum! * 2
            }
            else if(bananas == 2) {
                winnings = betNum! * 2
            }
            else if(oranges == 2) {
                winnings = betNum! * 3
            }
            else if(cherries == 2) {
                winnings = betNum! * 4
            }
            else if(apples == 2) {
                winnings = betNum! * 5
            }
            else if(bells == 2) {
                winnings = betNum! * 10
            }
            else if(sevens == 2) {
                winnings = betNum! * 20
            }
            else if(sevens == 1) {
                winnings = betNum! * 5
            }
            else {
                winnings = betNum! * 1
            }
            
            if(!jackFlag) {
                message.text = "You won \(winnings)!"
            }
        }
            
        //if any blanks appear, player loses
        else {
            message.text = "You lose!"
        }
        
        //add winnings, if any
        plMoney = plMoney! + winnings
        playerMoney.text = String(plMoney!)  //Player Money from Int to String
        
        //if last Bet Amount becomes larger than resultant Player Money, make it as large as Player money
        if(plMoney! < betNum!) {
            bet.text = String(plMoney!)
        }
    }
    
    //Function to Reset the Slot Machine
    @IBAction func reset(_ sender: UIButton) {
        
        //3 7's are default images
        let imgDefault:UIImage = UIImage(named: "7.png")!
        img1.image = imgDefault
        img2.image = imgDefault
        img3.image = imgDefault
        
        playerMoney.text = "1000"
        bet.text = "10"
        message.text = ""
    }
    
    /*
     Functions to Increase/Decrease Bet Amounts
     --Increase Functions will not let the player bet more than what he currently owns
     --Decrease Functions will not let the player bet less than 10 (Least Bet Amount)
    */
    
    //Function to increase Bet Amount by 10
    @IBAction func plusTen(_ sender: UIButton) {
        var betNum = Int(bet.text!)
        let plMoney = Int(playerMoney.text!)
        if((betNum! + 10) <= plMoney!) {
            betNum = betNum! + 10
            bet.text = String(betNum!)
        }
    }
    
    //Function to decrease Bet Amount by 10
    @IBAction func minusTen(_ sender: UIButton) {
        var betNum = Int(bet.text!)
        if((betNum! - 10) > 0) {
            betNum = betNum! - 10
            bet.text = String(betNum!)
        }
    }
    
    //Function to increase Bet Amount by 50
    @IBAction func plusFifty(_ sender: UIButton) {
        var betNum = Int(bet.text!)
        let plMoney = Int(playerMoney.text!)
        if((betNum! + 50) <= plMoney!) {
            betNum = betNum! + 50
            bet.text = String(betNum!)
        }
    }
    
    //Function to decrease Bet Amount by 50
    @IBAction func minusFifty(_ sender: UIButton) {
        var betNum = Int(bet.text!)
        if((betNum! - 50) > 0) {
            betNum = betNum! - 50
            bet.text = String(betNum!)
        }
    }
    
    //Function to increase Bet Amount by 100
    @IBAction func plusHundred(_ sender: UIButton) {
        var betNum = Int(bet.text!)
        let plMoney = Int(playerMoney.text!)
        if((betNum! + 100) <= plMoney!) {
            betNum = betNum! + 100
            bet.text = String(betNum!)
        }
    }
    
    //Function to decrease Bet Amount by 100
    @IBAction func minusHundred(_ sender: UIButton) {
        var betNum = Int(bet.text!)
        if((betNum! - 100) > 0) {
            betNum = betNum! - 100
            bet.text = String(betNum!)
        }
    }
    
}

