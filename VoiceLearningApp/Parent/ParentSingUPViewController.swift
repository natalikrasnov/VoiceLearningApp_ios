//
//  ParentSingUPViewController.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 04/04/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ParentSingUPViewController: UIViewController, UITextFieldDelegate {
    
    var emailTamplate = "@voicelearningapp.com"
    @IBOutlet weak var textField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if textField.text != ""{
                SingIn( password: textField.text!)
            }
    self.view.endEditing(true)
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != ""{
            SingIn( password: textField.text!)
        }
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    
    func SingIn(password: String){
        let credential = EmailAuthProvider.credential(withEmail: password+emailTamplate, password: password)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if error != nil {
                print("error: \(error?.localizedDescription)")
                self.showErrorAlert()
                return
            }
            Person.setIsKid(isKid: false)
            let storyBord = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBord.instantiateViewController(withIdentifier: "ParentTableViewController")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func showErrorAlert(){
        let alertController = UIAlertController(title: nil, message: "טעות, נסה שנית", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "אוקי", style: .destructive, handler: {
            alert -> Void in
        })
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
