//
//  OOTextField.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/8/28.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit


class OOTextField: BaseTextField {


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /*
     文本在输入框中左边距的距离
     */
    var _txtLeftMargin:CGFloat = 0.0;
    
    @IBInspectable
    var txtLeftMargin:CGFloat = 0.0{

        didSet{
            _txtLeftMargin = txtLeftMargin;
            if _txtLeftMargin > 0{
                AddTxtLeftMargin();
            }
        }
    }
    
    var _LeftImgName:String = "";
    @IBInspectable
    var LeftImgName:String = "" {
        didSet{
            _LeftImgName = LeftImgName;
            if _LeftImgName != "" {
                SetLeftImg();
            }
        }
    }
    
    func SetLeftImg(){
        let LeftImg = UIImage(named: _LeftImgName);
        if LeftImg != nil {
            let imgWidth:CGFloat = 30.0;
            let imgHeight:CGFloat = 30.0;
            let imgX = (_txtLeftMargin - imgWidth)/2;
            let imgY = (self.frame.height - imgHeight)/2;
            
            let LeftImgView = UIImageView(frame:CGRect(x: imgX, y: imgY, width: imgWidth, height: imgHeight));
            LeftImgView.image = LeftImg;
            
            self.leftView?.addSubview(LeftImgView);
        }
      
    }
    
    func AddTxtLeftMargin(){
 
        self.leftView =	UIView(frame: CGRect(x: 0, y: 0, width: _txtLeftMargin, height: self.frame.height));

        self.leftViewMode = .always;
    }
    
    
    override func didMoveToSuperview() {
        SetupTopBar();
    }
}
