//
//  Words.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 25/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import Foundation

class Words {
    static let lessons = ["מספרים", "אותיות"]
    
    class func giveMeWordInEnglish() -> String?{
        switch Person.currentLesson.lesson {
        case lessons[0]:
            return Numbers.spellThisNumberToEnglish(Person.currentLesson.lessonNumber)
        case lessons[1]:
            return Letters.giveMeLetter(index: Person.currentLesson.lessonNumber)
        default:
            return nil
        }
    }
    
    class func gimeMeWordInHebrew() -> String?{
        switch Person.currentLesson.lesson {
        case lessons[0]:
            return Numbers.spellThisNumberToHebrew(Person.currentLesson.lessonNumber)
        case lessons[1]:
            return nil
        default:
            return nil
        }
    }
}
