//
//  HearAndRecordFromHE.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 25/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit
import AVFoundation
import Speech
import AVKit

class HearAndRecordFromHE: BaseGameViewController {
    
    @IBOutlet weak var recordLable: UILabel!
    @IBOutlet weak var textLable: UILabel!
    @IBAction func viewForRepeatTalkButton(_ sender: UIButton) {
        talk()
    }
    
    @IBOutlet weak var numbersImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
        LogEventData.save(event: "הילד/ה התחיל את המשחק של שמיעה בעברית ואמירת המילה באנגלית")
        isItFromHE = true
        talk()
    }
   
    @IBAction func touchStartMic(_ sender: UIButton) {
        if !audioEngine.isRunning {
            recordLable.isHidden = false
            startCircularAnimation(forView: numbersImage)
            self.startRecording(textLable: textLable)
        }else{
            recordLable.isHidden = true
            sender.isEnabled = false
            stopCircularAnimation(forView: numbersImage)
            self.stopRecording()
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            Person.updateLEssons()
        }
    }
   
}
   
