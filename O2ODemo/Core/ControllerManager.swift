//
//  ControllerManager.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/19.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class ControllerManager
{
    static let Single:ControllerManager = ControllerManager();
    
    var _PersonEditController:PersonEditController?;
    var _EditNickNameController:EditNickNameController?;
    var _EditHeaderImageController:EditHeaderImageController?;
    var _LoginController:LoginController?;
    var _RegisterController:RegisterController?;
    var _PersonAccountIndex:PersonAccount_IndexController?;
    var _PersonAccountModifyPWd:PersonAccount_ModifyPwdController?;
    
    typealias AfterPopEvent = (UIViewController) -> Void
   
    //个人编辑主页
    func ToPersonEdit(_ mainVC:UIViewController,_ isNew:Bool = false){
        
        if isNew == true {
            _PersonEditController = nil;
        }
        if _PersonEditController == nil {

            let sb  = UIStoryboard(name: "Person", bundle: nil);
            _PersonEditController = sb.instantiateViewController(withIdentifier: "PersonEditVC") as? PersonEditController;
        }
        toPage(mainVC,_PersonEditController!);
      
    }
    
    //编辑昵称
    func toEditNickName(_ mainVC:UIViewController,
                        _ isNew:Bool = false
                       ){
        if isNew == true {
            _EditNickNameController = nil;
        }
        
        if _EditNickNameController == nil{
            let sb  = UIStoryboard(name: "Person", bundle: nil);
            _EditNickNameController = sb.instantiateViewController(withIdentifier: "EditNickNameVC") as? EditNickNameController;
        }

        toPage(mainVC,_EditNickNameController!);
    }
    
    //编辑头像
    func toEditHeaderImage(_ mainVC:UIViewController,_ isNew:Bool = false){
        if isNew == true {
            _EditHeaderImageController = nil;
        }
        
        if _EditHeaderImageController == nil{
            let sb  = UIStoryboard(name: "Person", bundle: nil);
            _EditHeaderImageController = sb.instantiateViewController(withIdentifier: "EditHeaderImageVC") as? EditHeaderImageController;
        }
        
       toPage(mainVC,_EditHeaderImageController!);
    }
    
    
    //登录界面
    func ToLoginPage(_ mainVC:UIViewController,_ isNew:Bool = false)
    {
        if isNew == true {
            _LoginController = nil;
        }
        
        if _LoginController == nil{
            let sb  = UIStoryboard(name: "Main", bundle: nil);
            _LoginController = sb.instantiateViewController(withIdentifier: "LoginVC") as? LoginController;
        }
       // _LoginController!.navigationController.c
        
        toPage(mainVC,_LoginController!,true);
    }
    //注册页面
    func ToRegisterPage(_ mainVC:UIViewController,_ isNew:Bool = false){
        if isNew == true {
            _RegisterController = nil;
        }
        
        if _RegisterController == nil{
            let sb  = UIStoryboard(name: "Main", bundle: nil);
            _RegisterController = sb.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterController;
        }
        
        toPage(mainVC,_RegisterController!);
    }
    
    //用户账户主页
    func ToPersonAccountIndex(_ mainVC:UIViewController,_ isNew:Bool = false){
        
        if isNew == true {
            _PersonAccountIndex = nil;
        }
        if _PersonAccountIndex == nil {
            
            let sb  = UIStoryboard(name: "Person", bundle: nil);
            _PersonAccountIndex = sb.instantiateViewController(withIdentifier: "PersonAccountIndex") as? PersonAccount_IndexController;
        }
        toPage(mainVC,_PersonAccountIndex!);
        
    }
    
    //修改密码
    func ToPersonAccountModifyPwd(_ mainVC:UIViewController,_ isNew:Bool = false){
        
        if isNew == true {
            _PersonAccountModifyPWd = nil;
        }
        if _PersonAccountModifyPWd == nil {
            
            let sb  = UIStoryboard(name: "Person", bundle: nil);
            _PersonAccountModifyPWd = sb.instantiateViewController(withIdentifier: "PersonAccountModifyPWd") as? PersonAccount_ModifyPwdController;
        }
        toPage(mainVC,_PersonAccountModifyPWd!);
        
    }
    
    func ToMainPage(_ mainVC:UIViewController){
        let sb  = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "TabBarVC");
        mainVC.present(vc, animated: true, completion: nil);
    }
    
    func ToCreateTaskPage(_ mainVC:UIViewController){
        let sb  = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "CreateTaskVC");
        mainVC.present(vc, animated: true, completion: nil);
    }
    
    func toPage(_ mainVC:UIViewController,_ targetVC:UIViewController,_ NoNav:Bool = false){
     
        if NoNav == true
        {
             mainVC.present(targetVC, animated: true, completion: nil);
        }
        else
        {
            if mainVC.navigationController == nil {
                mainVC.present(targetVC, animated: true, completion: nil);
            }
            else {
                mainVC.navigationController?.pushViewController(targetVC, animated: true);
            }
        }
      
    }
    
    func PopPersonEdit(_ mainVC:UIViewController,AfterPopEvent:AfterPopEvent){
        
        mainVC.navigationController?.popToViewController(_PersonEditController!, animated: true);
        
        AfterPopEvent(_PersonEditController!);
        
    }
    
    func PopPersonEdit(_ mainVC:UIViewController){
        
        mainVC.navigationController?.popToViewController(_PersonEditController!, animated: true);
        
    }
    
  
    
   
}
