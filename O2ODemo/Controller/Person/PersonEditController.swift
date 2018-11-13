//
//  PersonEditController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/17.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class PersonEditController: BaseTableViewController {

    @IBOutlet var _ImgProfileHeader:OOImageView_UserHeader?;
    @IBOutlet var _lbNickName:UILabel?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
      
       
        
       
    }
    
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        super.tableView(tableView, didSelectRowAt: indexPath);
      
        
        switch indexPath.row
        {
            case 0: ControllerManager.Single.toEditHeaderImage(self);
            case 1:
                ControllerManager.Single.toEditNickName(self);

            default:
                return;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //没有之前的图片，说明不是抄稿
        if _ImgProfileHeader?.PrevImage == nil {
            //尝试从本地读取
            _ImgProfileHeader?.SetImageFromLocal();
        }
        
         InitNickName();
    }
    
    func InitNickName(){
        _lbNickName?.text = UserData.GetNickName();
    
    }
  

}
