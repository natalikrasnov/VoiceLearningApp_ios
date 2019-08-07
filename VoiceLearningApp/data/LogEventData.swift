//
//  LogEventData.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 07/04/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import Foundation
import Firebase

class LogEventData {
    static var arrayResults:[String:String] = ["":""]

    class func save(event: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "he-IL")
        
        let date = dateFormatter.string(from: Date())
        print(date)
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child(date).setValue(event){
            (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error).")
                } else {
                    print("Data saved successfully!")
                }
        }
    }
    
    
    class func get(completion:@escaping (Bool) -> ()){
        arrayResults = [:]
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).observe(.value, with: {
        (snapshot) in
            print(snapshot)
            if !snapshot.exists(){
                print("not Exist")
                return
            }
            let snapshot: DataSnapshot = snapshot
            guard let childSnapshot = snapshot.value as? [String : String] else {
                print("error with convert result from firebase to an array of logEvent array")
                return
            }
            for key in childSnapshot.keys{
                arrayResults.updateValue(childSnapshot[key]!, forKey: key)
            }
            completion(true)
        })
    }
}
