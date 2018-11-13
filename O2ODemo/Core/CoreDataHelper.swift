//
//  CoreDataHelper.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/7.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import CoreData
import UIKit
import Foundation

class CoreDataHelper
{
    init()
    {
        
    }
    
    private static let instance:CoreDataHelper = CoreDataHelper();
    static func shared() ->CoreDataHelper
    {
        return instance;
    }
    
    func GetContext()->NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        return appDelegate.persistentContainer.viewContext
    }
    
   
    
   func GetSysConfigMO()->SysConfigMO
   {
        let context = GetContext();
        let fetchRequest:NSFetchRequest<SysConfigMO> = SysConfigMO.fetchRequest();
        var resultObj:SysConfigMO?;
        do
        {
            var list = try context.fetch(fetchRequest);
            if list.count == 0{
                resultObj = InsertSysConfigMO();
            }
            else{
                resultObj =  list[0]
            }
           
        }
        catch{
             print(error)
        }
    return resultObj!;
    
    
   }
    

    func InsertSysConfigMO()->SysConfigMO
    {
        let context = GetContext();
        
        let obj = NSEntityDescription.insertNewObject(forEntityName: "SysConfig",
                                                      into: context) as! SysConfigMO
        
        obj.bannerVersion = "1.0.1";
        obj.mainHost = URL(string: SysConfig.MainHost);
        
        do{
            try context.save()
        }
        catch{
            fatalError("保存失败：\(error)")
        }
        return obj;
        
    }
    
}
