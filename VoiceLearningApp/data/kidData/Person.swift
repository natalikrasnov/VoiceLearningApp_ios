//
//  Person.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 25/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import Foundation

struct Personality: Codable {
    var points: Int
    var lessons: [Lesson]
}

struct Lesson: Codable {
    var lessonNumber: Int
    var counOfRepeatCurrentLesson: Int
    var lesson: String
}


class Person {
    static let USER_DEFAULTS_SAVE = "SavedPerson"
    static let LESON_DEFAULTS_SAVE = "SavedLesson"
   
    static var user:Personality?
    static var currentLesson: Lesson = Lesson(lessonNumber: 0, counOfRepeatCurrentLesson: 0, lesson: Words.lessons[0])

    class func userUnswered(isthisTheARightAnswer: Bool){
        if isthisTheARightAnswer{
            user?.points+=1
            Person.currentLesson.counOfRepeatCurrentLesson+=1
        }
        savePersonInUserDefaults()
    }
    
    class func updateLEssons(){
      print(currentLesson.counOfRepeatCurrentLesson)
      if currentLesson.counOfRepeatCurrentLesson >= 3 {
            currentLesson.counOfRepeatCurrentLesson = 0
            currentLesson.lessonNumber+=1
        }
        savePersonInUserDefaults()
    }
    
    class func makeNewPerson() {
        Person.user = Personality(points: 0, lessons: initAllLessonsToNewPerson())
        savePersonInUserDefaults()
    }
    
    class func initAllLessonsToNewPerson()->[Lesson]{
        var lessons:[Lesson] = []
         for  i in 0..<Words.lessons.count{
           lessons.append(Lesson(lessonNumber: 0, counOfRepeatCurrentLesson: 0, lesson: Words.lessons[i]))
        }
        return lessons
    }
    
    class func savePersonInUserDefaults(){
        let encoder = JSONEncoder()
        for  i in 0..<(Person.user?.lessons.count)!{
            if Person.user?.lessons[i].lesson == Person.currentLesson.lesson{
                Person.user?.lessons[i] = Person.currentLesson
            }
        }
        if let encoded = try? encoder.encode(Person.user) {
            UserDefaults.standard.set(encoded, forKey: Person.USER_DEFAULTS_SAVE)
        }
    }
    
    class func getPersonFromUserDefaults(){
        if let savedPerson = UserDefaults.standard.object(forKey: Person.USER_DEFAULTS_SAVE) as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Personality.self, from: savedPerson) {
                Person.user = loadedPerson
            }else{
                makeNewPerson()
            }
        }else{
            makeNewPerson()
        }
    }
    
    //////////////////////////////
    //MARK:- kid or parent:
    static let ISTHISISAKID_DEFAULTS_SAVE = "isThisIsAKid"
    
    class func setIsKid(isKid: Bool){
        UserDefaults.standard.set(isKid ? 1 : 2, forKey: ISTHISISAKID_DEFAULTS_SAVE)
    }
    class func getIsKid()->Int{
        return UserDefaults.standard.integer(forKey: ISTHISISAKID_DEFAULTS_SAVE)
    }
    //////////////////////////////
    
}
