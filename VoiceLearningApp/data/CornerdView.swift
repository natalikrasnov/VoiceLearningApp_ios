//
//  CornerdView.swift
//  VoiceLearningApp
//
//  Created by hyperactive on 04/04/2019.
//  Copyright © 2019 hyperActive. All rights reserved.
//

import UIKit

class CornerdView: UIView {

   
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        super.draw(rect)
    }

}
