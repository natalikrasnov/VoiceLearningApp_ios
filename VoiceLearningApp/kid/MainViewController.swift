//
//  ViewController.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 25/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit

class MainViewController: BaseGameViewController{

    @IBOutlet weak var pointsLable: UILabel!
    @IBOutlet weak var startButtonLable: UIButton!
    @IBOutlet weak var LessonPicker: UIPickerView!
    
    @IBAction func infoButton(_ sender: UIButton) {
        showAlertDialog()
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        stopCircularAnimation(forView: startButtonLable)
        LogEventData.save(event: "הילד/ה התחיל משחק")
        newRandomGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogEventData.save(event: "הילד/ה נכנס לאפליקציה")
        Person.getPersonFromUserDefaults()
        LessonPicker.delegate = self
        LessonPicker.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pointsLable.text = "נקודות: \(Person.user?.points ?? 0)"
        startCircularAnimation(forView: startButtonLable)
    }
}


extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Words.lessons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        for i in 0..<Words.lessons.count{
            if Person.user?.lessons[i].lesson == Words.lessons[row]{
                Person.currentLesson = (Person.user?.lessons[i])!
                LogEventData.save(event: " \((Person.user?.points)!) נקודות לילד יש\n  הילד/ה בחר ללמוד:\(Person.currentLesson.lesson) ")
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string: Words.lessons[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

