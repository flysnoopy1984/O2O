//
//  SMSManager.swift
//  YJOO
//
//  Created by jackyPC on 2018/11/16.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit

class SMSManager{
    
   
    private var _PhoneNumber:String;
    private let _WebCore = WebCore();
    
    
    public init(PhoneNumber:String)
    {
        _PhoneNumber = PhoneNumber;
    }
    
    public func GetNormalVerifyMessage(){
        let url = WebCore.Url_SMSSend+"?Phone="+_PhoneNumber;
        _WebCore.PostData(url: url, afterEvent: CallBack_GetNormalVerifyMessage);
    
    }
    
    private func CallBack_GetNormalVerifyMessage(result:JSON){
        let IsScuess = result["IsSuccess"].bool;
        let vc = ControllerManager.Single._RegisterController;
        if IsScuess == false
        {
            
            let errMsg = result["ErrorMsg"].stringValue;
            let errInt = result["IntMsg"].int32;
            if errInt == 100
            {
             //   SysHelper.AlertAndClose(alertVC: vc!, title: "【验证码】", msg: errMsg)
                SysHelper.AlertAndClose(alertVC: vc!, title: "【验证码】", msg: errMsg,
                                        dismissSec:2.0,
                                        AfterAlertEvent:AfterAlert_PhoneExist);
                
            }
            else {
                 SysHelper.AlertAndClose(alertVC: vc!, title: "【验证码失败】", msg: errMsg);
            }
           
        }
        else{
            SysHelper.AlertAndClose(alertVC: vc!, title: "【短信已发送】", msg: "短信已发送到您手机，请注意查收！");
        }
      
    }
    
    private func AfterAlert_PhoneExist(){
        let vc = ControllerManager.Single._RegisterController as! RegisterController;
        vc._btnVerify?.EndCounting();
        
       vc.presentingViewController!.dismiss(animated: false, completion: nil)
    }
}
