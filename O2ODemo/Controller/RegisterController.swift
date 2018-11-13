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
    @IBOutlet var _btnVerify:OOButton_SMSVerify?;
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //先禁用按钮
        _btnVerify?.DisableButton();
        
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
