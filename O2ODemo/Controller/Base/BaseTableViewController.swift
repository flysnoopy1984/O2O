//
//  BaseTableViewController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/17.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    @IBAction func BackToPrevPage(){
        
        self.navigationController?.popViewController(animated: true);
    }
    
    @IBOutlet var _MainTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if _MainTableView != nil{
            _MainTableView.tableFooterView = UIView(frame: CGRect.zero);
           
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath);
        cell?.isSelected = false;
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
  
   
    

  

  

}

