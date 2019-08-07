//
//  Letters.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 31/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import Foundation

class Letters{
    static let letters:[String] = ["a", "b" ,"c" ,"d" , "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w","x","y", "z"]
    
    class func giveMeLetter(index: Int)->String {
        return letters[index]
    }
}
