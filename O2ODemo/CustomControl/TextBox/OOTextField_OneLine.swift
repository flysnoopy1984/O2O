//
//  TextField_OneLine.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/8/30.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class OOTextField_OneLine: BaseTextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var _SmsBtn:OOButton_SMSVerify?;
   
    func ChangeTextFieldStyle(){
        
        //将边框至为无边
        self.borderStyle = .none;
        
        //添加一条线
        let line  = UIView(frame: CGRect(x: 0,y: self.frame.height-1,
                                         width: self.frame.width, height: 1));
        //线颜色
        line.backgroundColor =  SysConfig.Color_LoginLine;
        self.addSubview(line);
        
        //设置光标颜色
        self.tintColor = SysConfig.Color_LoginLine;

    }
    

    func AddTextChangeEvent_ForButton(smsBtn:OOButton_SMSVerify){

       // self.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents);
        _SmsBtn = smsBtn;
        _SmsBtn?.RefTextField = self;
        self.addTarget(self,action: #selector(textChangeWithSMSButton(_:)),for: .allEditingEvents);
   
    }


    //输入框事件
    @objc func textChangeWithSMSButton(_ textField:OOTextField_OneLine) {
 
        if _SmsBtn?._IsCounting != true {
            if HasPhoneTextValue() {
                _SmsBtn?.EnableButton();
            }
            else{
                _SmsBtn?.DisableButton();
            }
        }
 
    }
    
    //返回是否有输入
    func HasPhoneTextValue() -> Bool{
        let isempty =  (self.text?.count)! > 0;
        if isempty{
            return false;
        }
        else{
            return isTelNumber(num: self.text!)
           
        }
    }
    
    func isTelNumber(num:String)->Bool    
    {
        
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)

        if (regextestmobile.evaluate(with: num) == true)
        {
            return true
        }
        else
        {
            return false
        }
        
    }

    override func didMoveToSuperview() {
     //   SetupNotification();
        SetupTopBar();
        ChangeTextFieldStyle();
     
    }
    
    
}
