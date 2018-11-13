//
//  EditNickNameController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/18.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class EditNickNameController: BaseUIViewController {

    
    lazy var _LoadingView:OOLoadingView = OOLoadingView(self);
    @IBOutlet var _txtNickName:OOTextField?;
    @IBOutlet var _txtTest:OOTextField?;
  
    @IBAction func Save(){

        let ud = UserData.GetUserDefault();
        let phone = ud?._Phone;
        let newName = _txtNickName?.text;
        
        if ud?._NickName == newName {
            ControllerManager.Single.PopPersonEdit(self);
            return;
        }
        else {
            _LoadingView.ShowLoading("处理中..");
            if newName != ""{
                
                let wc = WebCore();
                var p = Dictionary<String,AnyObject>();
                p["NickName"] = newName as AnyObject;
                p["Phone"] = phone as AnyObject
                
                wc.PostData(url: WebCore.SetNickName_Url, parameters: p, afterEvent: AfterPostNickName)
                
            }
            else {
                SysHelper.AlertMessage(vc: self, title: "错误", msg: "用户昵称不能为空");
                _LoadingView.CloseLoading();
            }
        }
      
    }
    
    func AfterPostNickName(result:JSON){
        
          _LoadingView.CloseLoading();
        
        if result["IsSuccess"].boolValue == true {
            let newName = _txtNickName?.text;
            let ud = UserData.GetUserDefault();
            ud?._NickName = newName!;
            
            UserData.SaveToUserDefault(ud: ud!);
            ControllerManager.Single.PopPersonEdit(self);

        }
        else {
            let msg = result["ErrorMsg"].stringValue;
            SysHelper.AlertMessage(vc: self, title: "错误", msg: msg);
        }
    }
    
    func InitNickName(){
        _txtNickName?.text = UserData.GetNickName();
      
       _txtNickName?.becomeFirstResponder();

      
        
    
     // _txtTest?.becomeFirstResponder();
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        InitNickName();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        _txtNickName?.SetDoneEvent {
            self.Save();
        }
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
