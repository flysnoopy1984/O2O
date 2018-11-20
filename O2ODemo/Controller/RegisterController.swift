//
//  RegisterController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/3.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class RegisterController: BaseUIViewController {

    @IBOutlet var _NavigationBar: UINavigationBar?;
    @IBOutlet var _OOScrollView:OOScrollView?;
    @IBOutlet var _txtPhone:OOTextField_OneLine?;
    @IBOutlet var _txtVerifyCode:OOTextField_OneLine?;
    @IBOutlet var _txtPwd:OOTextField_OneLine?;
    
   
    
    
    @IBOutlet var _btnVerify:OOButton_SMSVerify?;
    lazy var _LoadingView:OOLoadingView = OOLoadingView(self);

    @IBAction func DoRegister(){
         _LoadingView.ShowLoading();
        
        if VerifyFormControl(){
            let phone = _txtPhone?.text;
            let pwd = _txtPwd?.text;
            let verifyCode = _txtVerifyCode?.text;
            
            let url = WebCore.Url_Register;
            let wc = WebCore();
            
            var parameter = Dictionary<String,AnyObject>();
            parameter["Phone"] = phone as AnyObject;
            parameter["Pwd"] = pwd as AnyObject;
            parameter["VerifyCode"] = verifyCode as AnyObject;
            parameter["AppName"] = "OOAPP" as AnyObject;
            wc.PostData(url: url, parameters: parameter, afterEvent: CallBack_Register)
            
        }
        else{
            _LoadingView.CloseLoading();
        }
    }
    
    func CallBack_Register(result:JSON){
        let IsScuess = result["IsSuccess"].bool;
         _LoadingView.CloseLoading();
        
        guard IsScuess == false else{
            SysHelper.AlertMessage(vc: self, title: "成功", msg: "恭喜！已注册成功！", AfterAlertEvent: AfterAlert_RegisterSuccess)
            
            return;
        }
    
    }
    
    func AfterAlert_RegisterSuccess(){
        
    }
    
    func VerifyFormControl() -> Bool{
        if !(_txtPhone?.CheckFieldIsEmpty(checkEmpty: true))!{
            SysHelper.AlertAndClose(alertVC: self, title: "错误", msg: "手机号码不能为空");
            return false;
        }
        if !(_txtPwd?.CheckFieldIsEmpty(checkEmpty: true))!{
            SysHelper.AlertAndClose(alertVC: self, title: "错误", msg: "密码不能为空");
            return false;
        }
        if !(_txtVerifyCode?.CheckFieldIsEmpty(checkEmpty: true))!{
            SysHelper.AlertAndClose(alertVC: self, title: "错误", msg: "验证码不能为空");
            return false;
        }
        
        return true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //先禁用按钮
        _btnVerify?.DisableButton();
        _btnVerify?.LoadingView = _LoadingView;
        
        //手机输入框添加事件，监控输入变化
        _txtPhone?.AddTextChangeEvent_ForButton(smsBtn: _btnVerify!);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func ChangeNavBarStyle(){
        _NavigationBar?.setBackgroundImage(UIImage(), for: .default);
        _NavigationBar?.isTranslucent = true;
        
        _NavigationBar?.shadowImage = UIImage();
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        ChangeNavBarStyle();
        
    }
    
    
    
   
    
   
  

}
