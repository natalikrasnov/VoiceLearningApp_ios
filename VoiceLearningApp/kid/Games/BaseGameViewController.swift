//
//  BaseGameViewController.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 26/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit
import AVFoundation
import Speech
import AVKit

class BaseGameViewController: UIViewController, SFSpeechRecognizerDelegate {

    //SPEACH DELEGATE
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
    }
//---------------------------------------------------------------------
//INIT WORD AND TRANLATE
    var wordInEnglish = ""
    var wordInHebrew = ""
    var isItFromHE: Bool? {
        didSet{
            self.setupSpeech(languege: isItFromHE! ? "en-US" : "he-IL")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        wordInEnglish = Words.giveMeWordInEnglish() ?? ""
        wordInHebrew = Words.gimeMeWordInHebrew() ?? ""
        declareCircleAnimation()
    }
    
//---------------------------------------------------------------------
    
    //MARK:- show dalog for information:
    func showAlertDialog() {
        let alertController = UIAlertController(title: nil,
                                                message: """
        שלום
        הגעת לאפליקציה שבה תלמד/ תלמדי באנגלית את הספרות 0-9
         כחלק מהאפליקציה יהיו לך תרגילים שיופיע במהלך השימוש בפלאפון הזה.
        כמו למשל:
        ברגע שיתקבל סמס, או שתסתיים שיחת פלאפון עם מישהוא או בשימוש באפליקצית הווטסאפ.
        כחלק מהתירגול ישמעו לך המספרים ותצטרכו להקליט את עצמכם.
        בשביל להקליט פשוט תלחצו על המספר או על השורה שבה כתוב שתורכם.
        בשביל לשמוע שוב את מה שנאמר אם לא הספקת, תוכל ללחוץ על המסך עצמו.
        תהנו ובהצלחה!
""",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .destructive, handler: {
            alert -> Void in
        })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    
//--------------------------------------------------------------------------
    
    //MARK:- go to new game:
    static let gamesIdentifier:[String] = ["HearAndRecordFromEN", "HearAndRecordFromHE", "SeeAndRecordInEN" ]
    
    func newRandomGame(){
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController?
        if Person.currentLesson.lesson == "אותיות"{
            vc = storyBord.instantiateViewController(withIdentifier: MainViewController.gamesIdentifier[2])
        }else{
            vc = storyBord.instantiateViewController(withIdentifier: MainViewController.gamesIdentifier[Int.random(in: 0..<3)])
        }
        self.present(vc!, animated: true, completion: nil)
    }
    
//-------------------------------------------------
    
    //MARK:- animation circle:
    let orbit = CAKeyframeAnimation(keyPath: "position")
    let ANIMATON_KEY = "orbit"
   
    func declareCircleAnimation(){
        let affineTransform = CGAffineTransform(rotationAngle: 0.0)
        affineTransform.rotated(by:CGFloat(M_PI))
        let circlePath = UIBezierPath(arcCenter: CGPoint.zero, radius:  CGFloat(2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        orbit.path = circlePath.cgPath
        orbit.duration = 8
        orbit.isAdditive = true
        orbit.repeatCount = 100
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
    }
    
    func startCircularAnimation(forView view: UIView){
        view.layer.add(orbit, forKey: ANIMATON_KEY)
    }
   
    func stopCircularAnimation(forView view: UIView){
        view.layer.removeAnimation(forKey: ANIMATON_KEY)
    }
    
//-------------------------------------------------
    
    //MARK:- talking function:
    func talk() {
        do{
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        }catch{
            print("Error")
        }

        let utterance = AVSpeechUtterance(string: isItFromHE! ? wordInHebrew : wordInEnglish )
        utterance.voice = AVSpeechSynthesisVoice(language: isItFromHE! ? "he-IL" : "en-US")
        utterance.rate = 0.5
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
 //----------------------------------------------------------------
    
    //MARK:- recordinging function
    var speechRecognizer        : SFSpeechRecognizer?
    var recognitionRequest      : SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask         : SFSpeechRecognitionTask?
    let audioEngine             = AVAudioEngine()
    var inputNode               :AVAudioInputNode?
    var resultsArray:[String]   = []

    //DECLERISHAN:
    func setupSpeech(languege :String) {
        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: languege))
        self.speechRecognizer?.delegate = self
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            switch authStatus {
            case .authorized:
                print("you can record in "+languege)
            case .denied:
                print("User denied access to speech recognition")
            case .restricted:
                print("Speech recognition restricted on this device")
            case .notDetermined:
                print("Speech recognition not yet authorized")
            }
        }
    }

 //STARTING RECORD
    func startRecording(textLable: UILabel!) {
        // Clear all previous session data and cancel task
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = false
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            if result != nil {
                print(result?.bestTranscription.formattedString)
                self.resultsArray.append((result?.bestTranscription.formattedString)!.lowercased())
                isFinal = (result?.isFinal)!
                self.checkResults(textLable: textLable)
            }
        
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.takeASecondAndGoToNewGame()
            }
        })
  
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
    }
    
//STOPING RECORD
    func stopRecording(){
        //checkResults(textLable: textLable)
    }
  
    func checkResults(textLable: UILabel!){
        for word: String in resultsArray{
            let words = word.replacingOccurrences(of: "\u{200F}", with: "", options: .regularExpression).split(separator: " ")
            
            for initWord in words{
                if initWord == (isItFromHE! ? wordInEnglish : wordInHebrew) || Int(initWord) ?? nil == Person.currentLesson.lessonNumber ||
                    initWord.contains((isItFromHE! ? wordInEnglish : wordInHebrew)){
                    print("צדקת")
                   
                    textLable.text = "יאיי צדקת!!"
                    LogEventData.save(event: "\(isItFromHE! ? wordInEnglish : wordInHebrew) הילד/ה צדק במילה")
                    Person.userUnswered(isthisTheARightAnswer: true)
                    takeASecondAndGoToNewGame()
                    return
                }
            }
        }
        print("טעית")
        textLable.text = "התשובה הנכונה היא: "+(isItFromHE! ? wordInEnglish : wordInHebrew)
         LogEventData.save(event: "\(isItFromHE! ? wordInEnglish : wordInHebrew) הילד/ה טעה במילה")
        Person.userUnswered(isthisTheARightAnswer: false)
        takeASecondAndGoToNewGame()
    }
    
    func takeASecondAndGoToNewGame(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newRandomGame()
        }
    }
}
