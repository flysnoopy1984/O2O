//
//  PersonAccount_IndexTableViewController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/10/5.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class PersonAccount_IndexController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        super.tableView(tableView, didSelectRowAt: indexPath);
        
        
        switch indexPath.row
        {
            case 0: ControllerManager.Single.ToPersonAccountModifyPwd(self);
          
            default:
                return;
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
