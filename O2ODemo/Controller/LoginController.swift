//
//  LoginController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/8/29.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class LoginController: BaseUIViewController {

   
    @IBOutlet weak var _txtPhone:OOTextField_OneLine?;
    @IBOutlet weak var _txtPwd:OOTextField_OneLine?;
   
    
    var _RegisterVC:RegisterController? = nil;

    lazy var _WebCore:WebCore = WebCore();
    
    lazy var _OOFileManager = OOFileManager();
    
    lazy var _LoadingView:OOLoadingView = OOLoadingView(self);

    //登录按钮事件
    @IBAction func DoLogin(){
        
        _LoadingView.ShowLoading();
        
        if VerifyFormControl(){
            let loginName = _txtPhone?.text;
            let pwd = _txtPwd?.text;
            let IDFV = UIDevice.current.identifierForVendor;
            let url = WebCore.Url_Login+"?loginName=\(loginName!)&pwd=\(pwd!)&DeviceIdentify="+(IDFV?.uuidString)!;
          //  url+="?loginName=" + loginName! + "&pwd=" + pwd! + "&DeviceIdentify="+IDFV;
             //print(url);
            _WebCore.PostData(url: url, afterEvent: LoginCallBack);

        }
        else{
            _LoadingView.CloseLoading();
        }
    }
    
    func Login_SaveUserDefault(result:JSON){
        
        
        let ui = result["resultObj"];
        let name = ui["LoginName"].stringValue;
        let Phone = ui["Phone"].stringValue;
       
       
        UserData.SaveToUserDefault(name: name, phone: Phone, IsLogin: true);
        
    }
    
    func Login_SetUserHeader(result:JSON){
        let ImgUrl = SysConfig.ResHost+result["resultObj"]["HeaderImgUrl"].stringValue;
        print("imageUrl:\(ImgUrl)");
        if ImgUrl != ""
        {
            if !_OOFileManager.ExistFile_HeaderImage() {
                let imgPath = _WebCore.DownloadFile(url: ImgUrl);
                print(imgPath);
            }
           
        }
     
    }
    
    //登录结果处理，成功或失败
    func LoginCallBack(result:JSON){
        
        let IsScuess = result["IsSuccess"].bool;
         _LoadingView.CloseLoading();
        if IsScuess == true
        {
           // 用户数据持久化
            Login_SaveUserDefault(result: result);
            //下载用户头像
            Login_SetUserHeader(result: result);
            //跳转主页
            ControllerManager.Single.ToMainPage(self);
        }
        else
        {
            let errMsg = result["ErrorMsg"].stringValue;
            SysHelper.AlertAndClose(alertVC: self, title: "登录失败", msg: errMsg);
        }
        
     
    }
    
    //登录时校验手机和密码
    func VerifyFormControl() -> Bool{
        if !(_txtPhone?.CheckFieldIsEmpty(checkEmpty: true))!{
            SysHelper.AlertAndClose(alertVC: self, title: "验证失败", msg: "手机号码不能为空");
            return false;
        }
        if !(_txtPwd?.CheckFieldIsEmpty(checkEmpty: true))!{
            SysHelper.AlertAndClose(alertVC: self, title: "验证失败", msg: "密码不能为空");
            return false;
        }
        return true;
    }
    
    //转到注册
    @IBAction func ToRegister()
    {
        ControllerManager.Single.ToRegisterPage(self);
    }
    
    //返回当前登录
    @IBAction func backToLogin(segue: UIStoryboardSegue) {
        
        print("backtoLogin in Register");
    }
    
    func InitControlData()
    {
        if let ud = UserData.GetUserDefault()
        {
            _txtPhone?.text =  ud._Phone;
        }
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        InitControlData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
