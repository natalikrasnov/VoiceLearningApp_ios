//
//  HearAndRecordFromEN.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 25/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class HearAndRecordFromEN: BaseGameViewController {

    @IBOutlet weak var recordLable: UILabel!
    @IBOutlet weak var textLable: UILabel!
    @IBAction func viewForRepeatTalkButton(_ sender: UIButton) {
        talk()
    }
    
    @IBOutlet weak var numbersImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isItFromHE = false
        print("start")
         LogEventData.save(event: "הילד/ה התחיל את המשחק של שמיעה באנגלית ואמירת המילה בעברית")
        talk()
    }
    
    @IBAction func touchStartMic(_ sender: UIButton) {
        if !audioEngine.isRunning {
            recordLable.isHidden = false
            startCircularAnimation(forView: numbersImage)
            self.startRecording(textLable: textLable)
        }else{
            self.stopRecording()
            recordLable.isHidden = true
            sender.isEnabled = false
            stopCircularAnimation(forView: numbersImage)
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            Person.updateLEssons()
        }
    }
}
