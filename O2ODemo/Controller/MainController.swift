//
//  ViewController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/5/23.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit
import WebKit

class MainController: BaseUIViewController,UITableViewDelegate,UITableViewDataSource {
    
    weak var _BannerView:OOBannerView!;
    weak var _PagerControl:UIPageControl?;
    let _CellLatestTask = "TaskCell";
    var _TaskData:TaskData!;
    var _FootView:UIView!;
    var _BtnCreateTask:UIButton!;
    
   
    @IBOutlet weak var _TaskTable:UITableView?;
    @IBOutlet weak var _loadingView:UIActivityIndicatorView!

    
    var _CreateTaskController:UIViewController!;
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated);
        
        if UserData.GetLoginStatus() == .LoginOff {
            
             ControllerManager.Single.ToLoginPage(self);
        }

    }
    
    override func viewDidLoad() {
    
       
        super.viewDidLoad()
        
//        var userdata = UserData.GetUserDefault();
//
//        if userdata != nil &&  userdata?._IsLogin == true {
        
        if UserData.IsLogin(){
            
            _TaskData = TaskData();
            
            _TaskData.InitData();
            
            _TaskData.AfterInitData = AfterInitData;
            
            SetupCollectionView();
            
            SetupTaskTable();
            
            // Do any additional setup after loading the view, typically from a nib.
            SetupViewFooter();
        }

    }
    
   
    
    func AfterInitData(){
        
      _TaskTable?.reloadData();
    }
    
    func SetupViewFooter(){
        
        //Footer BK
        let y = (_TaskTable?.frame.origin.y)!+(_TaskTable?.frame.height)!
        
        let h = self.view.frame.height - y-(self.tabBarController?.tabBar.frame.size.height)!;
    
        let rect = CGRect(origin: CGPoint(x: 0, y: y), size:CGSize(width: self.view.frame.width, height: h));
    
        _FootView = UIView(frame: rect);
        _FootView.backgroundColor = UIColor(patternImage: UIImage(named: "BKIndexFooter")!)
        self.view.addSubview(_FootView)
        
         //按钮
       
        _BtnCreateTask = UIButton(type:.custom);
        _BtnCreateTask.frame.size = CGSize(width: 150, height: 150)
        _BtnCreateTask.center = CGPoint(x: _FootView.frame.width/2, y: _FootView.frame.height/2)
        _BtnCreateTask.setImage(UIImage(named: "Btn_StartTask"), for: .normal);
        _BtnCreateTask.addTarget(self, action: #selector(GoToCreateTask), for: .touchUpInside)
        
        _FootView.addSubview(_BtnCreateTask)
        
    }
    
    func SetupTaskTable(){
        
      //  _TaskTable?.rowHeight = 200;
      //  _TaskTable?.estimatedRowHeight = 200;
        
    }
    
    func SetupCollectionView()
    {
        let rect = CGRect(origin: CGPoint(x: 0, y: 25), size:CGSize(width: self.view.frame.width, height: 200));
        
        _BannerView = OOBannerView(frame: rect)
        self.view.addSubview(_BannerView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (_TaskData != nil && _TaskData.HasData())
        {
            return (_TaskData!.AllTask?.count)!;
        }
        else
        {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: _CellLatestTask) as! OOTaskCell;
        if (_TaskData?.HasData())!
        {
            let task = _TaskData.AllTask![indexPath.row];
            
            cell.LB_Price.text = String(task.RewardAmount);
            
            cell.LB_Desc.text = task.Description;
        }
        
        return cell;
    }
    
    @objc func GoToCreateTask(){
        ControllerManager.Single.ToCreateTaskPage(self);
   
       // self.performSegue(withIdentifier: "SegueToCreateTask", sender: self);
    }

    @IBAction func BackToMain(segue:UIStoryboardSegue) {
        print ("close In ");
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    

    
}

