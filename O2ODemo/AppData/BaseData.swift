//
//  appData.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/12.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class BaseData
{
    static let LoadingImg = UIImage(named: "Pic_Loading");
    
  
    typealias InvokerFunc = () -> Void
    
    public var AfterInitData:InvokerFunc?;
        
}
