//
//  ImageViewExtension.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/18.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func SetImgCorner(_ borderWidth:CGFloat = 0.0,_ borderColor:UIColor = UIColor.white)
    {
        
        self.layer.cornerRadius = self.frame.width/2;
        self.clipsToBounds = true;
        
        if borderWidth > 0 {
            self.layer.borderColor = borderColor.cgColor;
            self.layer.borderWidth = borderWidth;
        }
 
    }
}
