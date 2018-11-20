//
//  OOButton_OneLine.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/4.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class OOButton_SMSVerify: OOButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var _CountTimer: DispatchSourceTimer?;
    var _IsCounting = false;
    var RefTextField:OOTextField_OneLine?;
    var LoadingView:OOLoadingView?;
    
    
    var RemainSec:Int = 0 {
        willSet{
            if newValue > 0 {
                self.setTitle("\(newValue)秒后重新获取", for: .disabled);
                 _IsCounting = true;
               
            }
            else
            {
                EndCounting();
            }
             print(newValue);
        }
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        ChangeStyle();
        
        
        
        self.addTarget(self, action: #selector(StartCounting(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder);
        ChangeStyle();
        self.addTarget(self, action: #selector(StartCounting(_:)), for: .touchUpInside)
    }
    
    //按钮点击后开始倒计时 - 60秒
    @objc func StartCounting(_ sender:OOButton_SMSVerify){
        
        //发送短信
        SendSMS();
        
        
        //开始计时
        if _CountTimer == nil || _CountTimer?.isCancelled == true  {
            _CountTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main);
        }
        RemainSec = SysConfig.SMS_RepeatSend_Sec

        _CountTimer?.schedule(wallDeadline: .now(), repeating:.seconds(1));

        _CountTimer?.setEventHandler{

            DispatchQueue.main.async {
                self.RemainSec -= 1
            }
        }

         DisableButton();
        _CountTimer?.resume();

    }
    
    func EndCounting(_ IsFromTextFiled:Bool = false){
        
        if self._CountTimer != nil {
            self._CountTimer?.suspend();
        }
        
        _IsCounting = false;
        
        if !IsFromTextFiled {
            //判断是否给了输入框引用。主调用者配置
            if RefTextField != nil{
                if RefTextField?.HasPhoneTextValue() == true {
                    EnableButton();
                }
                else{
                    DisableButton();
                }
            }
            else
            {
                EnableButton();
            }
        }
       
        
        self.setTitle("获取验证码", for: .disabled);
    }

    //下划线和按钮的距离
    var _MarginBottom:CGFloat = 1;
    @IBInspectable     //属性可是化设置的关键字
    var MarginBottom:CGFloat = 1{
        didSet{
            _MarginBottom = MarginBottom;
            if _MarginBottom != -1{
                 AddButtomLine();
            }
           
        }
    }
    
    //按钮图片和左边距距离
    var _ImageLeftMargin:CGFloat = 10;
    @IBInspectable
    var ImageLeftMargin:CGFloat = 10{
        
        didSet{
            _ImageLeftMargin = ImageLeftMargin;
            if _ImageLeftMargin >= 0{
                ChangeImgPosition();
            }
        }
    }
    
    

    //改变按钮图片左间距的距离
    private func ChangeImgPosition(){
        self.imageEdgeInsets = UIEdgeInsets(top: 0,left: _ImageLeftMargin,bottom: 0,right: 0);
    }

    //添加按钮下面一条线的实现
    private func AddButtomLine()
    {
        //添加一条线
        let line  = UIView(frame: CGRect(x: 0,y: self.frame.height+_MarginBottom,
                                         width: self.frame.width, height: 1));
        
        //线颜色
        line.backgroundColor = SysConfig.Color_LoginLine;
        
        self.addSubview(line);
    }
    
    //改变按钮样式
    private func ChangeStyle(){

        //按钮字体颜色
        self.setTitleColor(SysConfig.Color_LoginLine, for: .normal);
        
        
        self.layer.cornerRadius = self.frame.height/2;
        self.layer.borderWidth = 1;
        self.layer.borderColor  = SysConfig.Color_BtnFrame.cgColor;
        
    }
    
    //禁用按钮
    func DisableButton()
    {
        self.isEnabled = false;
        self.layer.borderWidth = 0;
        self.layer.backgroundColor = SysConfig.Color_Register_DisableButton.cgColor;
    }
    
    //启用按钮
    func EnableButton()
    {
        self.isEnabled = true;
        self.layer.borderWidth = 1;
        self.layer.borderColor  = SysConfig.Color_BtnFrame.cgColor;
        self.layer.backgroundColor = SysConfig.Color_Register_EnableButton.cgColor;
    }
    
    func SendSMS(){
        
        let sms = SMSManager(PhoneNumber: (RefTextField?.text)!);
        sms.GetNormalVerifyMessage();
    }
  
    
}
