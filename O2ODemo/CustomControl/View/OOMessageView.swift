//
//  OOMessage.swift
//  YJOO
//
//  Created by jackyPC on 2018/11/20.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit

//protocol OOMessageViewDelegate{
//    func AfterOK();
//}

class OOMessageView{
    
    typealias BtnOKEvent = ( ) -> Void;
    
    private var _MessageView:UIView?=nil;
    private var _ParentVC:UIViewController;
    
    private let screenWidth = UIScreen.main.bounds.width;
    private let screenHeight = UIScreen.main.bounds.height;
    
    private let MainX:CGFloat;
    private let MainY:CGFloat;
    private let MainWidth:CGFloat;
    private let MainHeight:CGFloat;
    
    private let titleHeight = 50.0;
    
    private let msgX = 40.0;
    
    private let btnX = 50.0;
    private let btnHeight = 50.0;
    private let btnBottomPadding = 20.0;

    private var msgText:UILabel?;
    private let msgView:UIView;
    
    private var _ExtOKEvent:BtnOKEvent? = nil;
    
//    private var _OKdelegate : OOMessageViewDelegate? = nil;
    
    init(_ ParentVC:UIViewController)
    {
        
        _ParentVC = ParentVC;
        MainX = screenWidth*1/10;
        MainY = self.screenHeight*3/10;
        
        MainWidth = self.screenWidth*8/10;
        MainHeight = self.screenHeight*4/10;
        
        msgView = UIView(frame: CGRect(x: MainX, y: MainY, width: MainWidth, height: MainHeight));
    }
    
    func Show(msgText:String,title:String = "信息",complete:@escaping BtnOKEvent = {}){
        if _MessageView == nil {
            _MessageView = CreateMessageView(msg: msgText,title: title);
            _ParentVC.view.addSubview(_MessageView!);
        }
        else
        {
            _MessageView?.isHidden = false;
            
        }
        _ExtOKEvent = complete;
    }
    
    func Close(){
        if _MessageView != nil {
            _MessageView = nil;
        }
    }
    
    func Hide(){
        if _MessageView != nil {
            _MessageView?.isHidden = true;
        }
    }
    
   //Msg Title
   private func CreateTitle(title:String){
    
        let titleText = UILabel(frame: CGRect(x: 0.0, y: 0.0,
                                              width: Double(MainWidth),
                                              height: titleHeight));
    
        titleText.text = title;
        titleText.textAlignment = .center;
        titleText.numberOfLines = 1;
        msgView.addSubview(titleText);
    }
    
    private func CreateLineUnderTitle(){
        let line  = UIView(frame: CGRect(x: 0,y:titleHeight+1,
                                         width: Double(MainWidth), height: 1.0));
        line.backgroundColor = UIColor.gray;
        
        msgView.addSubview(line);
    }
    
    private func CreateButton(btnText:String){
        
     //   let btnX = 50.0; //全局定义
        let btnWidth = Double(MainWidth)-btnX*2;
        
     //   let btnHeight = 50.0; //全局定义
        let btnY = Double(MainHeight) - btnHeight - btnBottomPadding;
        let btnView = UIButton(frame: CGRect(x: btnX, y: btnY, width: btnWidth, height: btnHeight))
        
        btnView.backgroundColor = UIColor.init(red: 72/255, green: 134/255, blue: 255/255, alpha: 255/255);
        btnView.layer.cornerRadius = 10;
        btnView.setTitle(btnText, for: .normal);
        
        btnView.addTarget(self, action: #selector(btn_DoOK), for: .touchUpInside);
        
        msgView.addSubview(btnView);
    }
    
    private func CreateMsgText(msg:String)
    {
        let msgWidth = Double(MainWidth) - msgX*2;
        let msgHeight = Double(MainHeight) - titleHeight - btnHeight - btnBottomPadding;
        
        msgText = UILabel(frame: CGRect(x: msgX, y: titleHeight, width: msgWidth, height: msgHeight));
        
        msgText!.text = msg;
        msgText!.textAlignment = .center;
    //    msgText.layer.borderWidth = 1;
        msgText!.numberOfLines = 0;
        
        msgView.addSubview(msgText!);
        
    }
    
    private func CreateMessageView(msg:String,title:String = "信息",btnText:String = "确定") -> UIView
    {
        
       
        msgView.backgroundColor = UIColor.white;
        msgView.layer.cornerRadius = 15;
     
        //Title
        CreateTitle(title: title);
        //加条线
        CreateLineUnderTitle();
        
        //Text
        CreateMsgText(msg: msg);
        
        //Button
        CreateButton(btnText: btnText);
        
        
        return msgView;
    }
    
     @objc private func btn_DoOK(sender:UIButton){
        if _ExtOKEvent != nil {
            _ExtOKEvent!();
        }
        self.Hide();
    }
    
    private func SetMessage(_ msg:String){
        if msgText != nil{
            msgText!.text = msg;
        }
    }
    
    
}
