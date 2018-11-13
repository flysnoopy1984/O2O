//
//  PersonControllerViewController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/8/24.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class PersonController: BaseTableViewController{

    @IBOutlet var _ImgProfileHeader:OOImageView_UserHeader?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //table 分组头去除空白
        _MainTableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //没有之前的图片，说明不是抄稿
        if _ImgProfileHeader?.PrevImage == nil {
            //尝试加载头像
            _ImgProfileHeader?.SetImageFromLocal();
        }
        
        
    }
    
    func test(){
        
        let loading = OOLoadingView(self);
        loading.ShowLoading();
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 5) {
            loading.CloseLoading();
        }
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        super.tableView(tableView, didSelectRowAt: indexPath);
        
        if indexPath.section == 0{
            switch indexPath.row {
            case 1:
                ControllerManager.Single.ToPersonEdit(self);
            case 2:
                ControllerManager.Single.ToPersonAccountIndex(self);
            default:
                return;
            }
        }
        else if indexPath.section == 1 && indexPath.row == 0{
            self.LoginOff();
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1;
    }
    

  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func LoginOff()
    {
        UserData.RemoveUserDefault();
        ControllerManager.Single.ToLoginPage(self,true);
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


