//
//  UserData.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/7/4.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit

class UserData:NSObject,NSCoding
{
    var _NickName:String = "";
    var _Phone:String = "";
    var _DeviceToken:String = "";
    
    var _IsLogin:Bool = Bool.init();
    
  //  var _HeadImg:UIImage?
    
    static var _UserDefaultKey = "UserInfo";
    
    required override init()
    {
        super.init();
    }
    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        
        self._NickName = decoder.decodeObject(forKey: "Name") as? String ?? ""
        self._Phone = decoder.decodeObject(forKey: "Phone") as? String ?? ""
        self._IsLogin = decoder.decodeBool(forKey: "IsLogin");
        self._DeviceToken = decoder.decodeObject(forKey: "DeviceToken") as? String ?? ""
      //  self._HeadImg = decoder.de
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(_NickName, forKey:"Name")
        coder.encode(_Phone, forKey:"Phone")
        coder.encode(_IsLogin, forKey:"IsLogin")
        coder.encode(_DeviceToken,forKey: "DeviceToken")
    }
    
    // 0  登录中 ，-1 登出
    static func GetLoginStatus() -> UserLoginStatus{

        let userdata = UserData.GetUserDefault();

        if  userdata == nil  || (userdata?._IsLogin)! == false{
            return .LoginOff;
        }
        return  .Login;
    }

    static func SaveToUserDefault(ud:UserData){
        SaveToUserDefault(name: ud._NickName, phone: ud._Phone, IsLogin: ud._IsLogin);
    }
    static func SaveToUserDefault(name:String, phone:String,IsLogin:Bool){
        
        var ud = UserData.GetUserDefault();
        if ud == nil{
            ud = UserData();
        }
        
        
        ud!._IsLogin = IsLogin;
        ud!._NickName = name;
        ud!._Phone = phone;
        
        let modelData = NSKeyedArchiver.archivedData(withRootObject: ud!)
        
        UserDefaults.standard.set(modelData, forKey: _UserDefaultKey);
        
    }
    
    
    
    static func IsLogin() -> Bool{
        
      let userdata = UserData.GetUserDefault();
      return userdata != nil &&  userdata?._IsLogin == true
    }
    
    static func GetPhone() -> String{
        let ud = GetUserDefault();
        return (ud?._Phone)!;
        
    }
    
    static func GetNickName() -> String{
        let ud = GetUserDefault();
        return (ud?._NickName)!;
        
    }

    static func GetUserDefault() -> UserData?{
        
        var model:UserData?;
        if let modelData = UserDefaults.standard.data(forKey: _UserDefaultKey){
            model = NSKeyedUnarchiver.unarchiveObject(with: modelData) as? UserData
        }
        
        return model;
    }

    static func RemoveUserDefault(){
        
        var data:UserData?;
        var modelData = UserDefaults.standard.data(forKey: _UserDefaultKey);
        
        if modelData != nil {
            
            data = NSKeyedUnarchiver.unarchiveObject(with: modelData!) as? UserData
            
            if data != nil{
                data?._IsLogin = false;
                
                modelData = NSKeyedArchiver.archivedData(withRootObject: data!)
                
                UserDefaults.standard.set(modelData, forKey: _UserDefaultKey);
            }
            
        }
    }
    
    static func SetDeviceToken(){
        let ud = GetUserDefault();
        if ud == nil{
            
        }
    }
    
    
    static func PostDeviceToken(deviceToken:String)
    {
        let wc = WebCore();
        var url = "";
        url += "?DevToken="+deviceToken+"&phone="+GetPhone();
        wc.PostData(url: url, afterEvent: wc.EmptyAfterLoad);
        
    }
    
    
}


