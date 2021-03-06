//
//  SysHelper.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/8/24.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class SysHelper{
    
    typealias AfterAlertEvent = () -> Void
    
    static func AlertMessage(vc:UIViewController, title:String,msg:String,AfterAlertEvent:@escaping AfterAlertEvent = {}){
        
        let alertController = UIAlertController.init(title: title, message: msg, preferredStyle:.alert);
        
        let cancel = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default,handler: {
        action in
             AfterAlertEvent();
        }) ;
        
        alertController.addAction(cancel);
        
        vc.present(alertController, animated: true, completion: {});
    }
    
    static func AlertAndClose(alertVC:UIViewController,title:String,msg:String,dismissSec:Double = SysConfig.AlertClose_Sec,AfterAlertEvent:@escaping AfterAlertEvent = {}){
        
        let alertController = UIAlertController.init(title: title, message: msg, preferredStyle:.alert);
        var IsClose = false;
        
        let cancel = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default,handler: {
            action in
            IsClose = true;
            AfterAlertEvent();
            }) ;
        
       
        alertController.addAction(cancel);
        alertVC.present(alertController, animated: true, completion: {});
        
       // let t:Double = 1.0;
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + dismissSec) {

            if IsClose == false{
                
                alertVC.dismiss(animated:true, completion:{
                   AfterAlertEvent();
                   
                })

            }
        }
 
    }
}


