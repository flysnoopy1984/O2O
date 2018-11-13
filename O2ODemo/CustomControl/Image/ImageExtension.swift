//
//  ImageExtension.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/12.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

//图片上传
extension UIImage{
    
    typealias SuccessUpload = (JSON) -> Void;
    typealias FailureUpload = (Error) -> Void;
    
    func Upload(FileName:String,
                SuccessUpload:@escaping SuccessUpload,
                FailureUpload:@escaping FailureUpload){
        let wc = WebCore();
        
        wc.Upload(FileName: FileName, UploadImg: self, SuccessUpload: SuccessUpload, FailureUpload: FailureUpload);
     
    }

}
