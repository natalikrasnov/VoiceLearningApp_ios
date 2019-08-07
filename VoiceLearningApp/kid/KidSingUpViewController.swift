//
//  KidSingUpViewController.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 04/04/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class KidSingUpViewController: UIViewController {
    
    var emailTamplate = "@voicelearningapp.com"
    @IBOutlet weak var codeLAble: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let password = giveMeRendomeCode()
        print(password)
        singMeUp(email: password+emailTamplate, password: password)
    }
    
  
    
    func giveMeRendomeCode() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<6).map{ _ in letters.randomElement()! })
    }
    
    func singMeUp(email:String ,password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                return
            }else{
                self.codeLAble.text = password
                Person.setIsKid(isKid: true)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showErrorAlert()

        Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Auth.auth().removeStateDidChangeListener(self)
    }
    
    func showErrorAlert(){
        let alertController = UIAlertController(title: "שים לב!", message: "הסיסמא הזאת היא חד פעמית. שמור אותה או תרשם עכשיו", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "אוקי", style: .destructive, handler: {
            alert -> Void in
        })
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
