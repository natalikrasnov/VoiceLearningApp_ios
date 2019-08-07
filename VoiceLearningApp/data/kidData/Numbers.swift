//  Numbers.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 31/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import Foundation

class Numbers{
    let startNumberToLearn = 0
    let EndNumberToLearn = 9
    
    class func spellThisNumberToEnglish(_ number : Int)-> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(integerLiteral: number)) ?? ""
    }
    
    class func spellThisNumberToHebrew(_ number : Int)-> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: "he_IL")
        return formatter.string(from: NSNumber(integerLiteral: number)) ?? ""
    }
}
