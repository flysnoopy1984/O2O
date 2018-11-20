//
//  OOSys.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/11.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit

class SysConfig
{
    //主API 网站
    public static let MainHost = "https://oo.iqianba.cn/";
    
    //资源 网站
    public static let ResHost = "https://data.iqianba.cn/";
    
    public static let WebHost = "http://pp.iqianba.cn/";
    
    public static func GetFullURL(virPath:String) -> URL
    {
        var fullUrl = "";
        
        fullUrl = MainHost+virPath;
        
        return URL(string: fullUrl)!;
    }
    
    //登录输入框行样色
    public static let Color_LoginLine = UIColor(red: 45/255, green: 216/255, blue: 208/255, alpha: 100);
    //登录按钮边框色
    public static let Color_BtnFrame = UIColor(red: 50/255, green: 148/255, blue: 143/255, alpha: 100);
    
    //发短信SMS按钮灰色
    public static let Color_Register_DisableButton = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 100);
    //发短信按钮可用
    public static let Color_Register_EnableButton = UIColor.init(red: 248/255, green: 255/255, blue: 175/255, alpha: 100);
    
    //发短信间隔时间（秒）
    public static let SMS_RepeatSend_Sec = 60;
    
    public static let AlertClose_Sec:Double  = 3.0;
    
    static let HeaderDirPath_Name:String = "HeaderImg.jpg";
    static let HeaderDirPath_FileName:String = "OOImages/HeaderImg.jpg";
    static let HeaderDirPath:String = NSHomeDirectory() + "/Documents/OOImages/";

    static let HeaderDirPath_CopyName:String = "Copy_HeaderImg.jpg";
}
