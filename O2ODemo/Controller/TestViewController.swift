//
//  TestViewController.swift
//  YJOO
//
//  Created by jackyPC on 2018/11/21.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    lazy var _MsgView:OOMessageView = OOMessageView(self);
    
    @IBAction func ShowMsg(){
        _MsgView.Show(msgText: "第二次打开",complete: DoOK)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        _MsgView.Show(msgText: "你好 这里是测试信息",complete: DoOK);
    }

    func DoOK(){
        print("External OK");
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
