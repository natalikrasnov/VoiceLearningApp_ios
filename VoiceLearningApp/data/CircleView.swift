//
//  CircleView.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 25/03/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit

class CircleView: UIView {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        super.draw(rect)
    }
}
