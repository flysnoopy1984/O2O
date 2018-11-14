//
//  BannerData.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/27.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit


class BannerData:BaseData,DataFunc{
    
    typealias T = EBanner

    func GetData() -> [EBanner] {
        return Array(Banner.values);
    }
    func GetCount() -> Int {
        
        return Banner.count;
    }
    
    private var _WebCore = WebCore();
    private var _Banner:Dictionary<Int,EBanner>?;
    private var _ItemList:Array<Any>?;
  
 
    func InitData()
    {
        for i in 1...3
        {
            var banner = EBanner();
            banner.Image = BaseData.LoadingImg;
            Banner[i] = banner;
        }
        
        _WebCore.PostData(url: WebCore.Url_Banner, afterEvent: SetBannerFromJson);
    }
    
   
    var Banner:Dictionary<Int,EBanner>{
        get{
            if _Banner == nil
            {
                _Banner = Dictionary<Int,EBanner>();
                InitData();
             
            }
            return _Banner!;
        }
        set{
            _Banner = newValue;
        }
    }


    
    public func SetBannerFromJson(result:JSON)
    {
        let list = result["resultList"];
        
        list.forEach{(i,item) in
            
            var banner = EBanner();
            
            banner.ImgUrl = item["BannerImg"].string!;
            banner.Pos = item["Position"].int!;
            banner.Title = item["Title"].string!;
            
            let imgUrl = SysConfig.GetFullURL(virPath: banner.ImgUrl);
            let data = NSData(contentsOf: imgUrl);
            
            banner.Image = UIImage(data: data! as Data);
            Banner.updateValue(banner, forKey: banner.Pos);
        }
       // print("SetBannerFromJson Done");
        AfterInitData?();
       
    }
    
}
