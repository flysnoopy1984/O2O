//
//  OOButton.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/8/13.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class OOButton: UIButton {

    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview();
        
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 1;
        self.layer.borderColor  = SysConfig.Color_BtnFrame.cgColor;
        //UIColor.init(red: 42/255, green: 138/255, blue: 134/255, alpha: 100).cgColor;
    }
}
