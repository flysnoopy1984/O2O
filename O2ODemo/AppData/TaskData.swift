//
//  TaskData.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/29.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation

class TaskData:BaseData,DataFunc
{
    func GetData() -> [ETask] {
        return _Data!;
    }
    
    func GetCount() -> Int {
        
        return (_Data?.count)!;
    }
    
    func InitData() {
        
        var parameter = Dictionary<String,AnyObject>();
        parameter["pageIndex"] = 0 as AnyObject;
        parameter["pageSize"] = 5 as AnyObject;
        
        _WebCore.PostData(url: BaseData.TaskUrl, parameters:parameter,afterEvent: DownLoadData);
    }
    
    typealias T = ETask
    
    private var _Data:Array<ETask>?;
    private var _WebCore = WebCore();
    
    public var AllTask:Array<ETask>? {
        get{
            if _Data == nil{
                
                InitData();
            }
            return _Data;
        }
    }
    
    public func HasData() -> Bool{
        
        return  _Data != nil && (_Data?.count)! > 0
        
    }
    
    private func DownLoadData(result:JSON){
        
        let IsSuccess = result["IsSuccess"].bool
        
        if IsSuccess!
        {
            let list = result["resultList"];
            _Data  = Array<ETask>();
            
            list.forEach{(i,item) in
                
                var task = ETask();
                
                task.Title = item["Title"].string!;
                task.Description = item["Description"].string!;
                task.CreatedTime = item["CreatedTime"].string!;
                task.TaskType = item["TaskType"].int!;
                task.RewardAmount = item["RewardAmount"].double!;
                _Data?.append(task);
                
            }
            AfterInitData?();
        }
        else
        {
            print (result["ErrorMsg"].string);
        }
       
       

    }
    
}
