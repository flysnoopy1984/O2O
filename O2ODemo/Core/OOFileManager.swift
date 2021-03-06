//
//  FileManager.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/19.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit
import Foundation

class OOFileManager {

    let _FileManager = FileManager.default;
    static let HeaderImageFullPath = SysConfig.HeaderDirPath + SysConfig.HeaderDirPath_Name;
    
    init() {
        
        if _FileManager.fileExists(atPath: SysConfig.HeaderDirPath) == false {
        
            try! _FileManager.createDirectory(atPath: SysConfig.HeaderDirPath, withIntermediateDirectories: true, attributes: nil);
        }
    }
 
    func SetUserHeaderImage(result:JSON){
        let ImgUrl = SysConfig.ResHost+result["resultObj"]["HeaderImgUrl"].stringValue;
       
        let wc = WebCore();
        
        print("imageUrl:\(ImgUrl)");
        if ImgUrl != "" 
        {
            if !ExistFile_HeaderImage() {
                let imgPath = wc.DownloadFile(url: ImgUrl,SavePath: SysConfig.HeaderDirPath_FileName);
                print(imgPath);
            }
            
        }
        
    }
    
    func ExistFile(FilePath:String) -> Bool {

        return  _FileManager.fileExists(atPath: FilePath);
    }
    
    func ExistFile_HeaderImage() -> Bool {
        
        
        return _FileManager.fileExists(atPath: OOFileManager.HeaderImageFullPath);
    }
    
   
    
    
}
