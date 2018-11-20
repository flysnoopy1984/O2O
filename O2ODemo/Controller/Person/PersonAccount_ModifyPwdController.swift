//
//  PersonAccount_ModifyPwdController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/10/8.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit
import WebKit

class PersonAccount_ModifyPwdController: BaseWebViewController,WKScriptMessageHandler{

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _WebView?.configuration.preferences.javaScriptEnabled = true;
        _WebView?.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true;
        _WebView?.configuration.userContentController.add(self, name: "ModifyPwd");
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
         self.LoadUrlString(WebCore.Url_PersonAccount_ModifyPwd);
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        switch message.name
        {
            //1 Ok -1失败。
            case "ModifyPwd":
                if message.body as! Int32  == 1{
                   
                }
            default:
                break;
        }
    }

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
