//
//  DataProtocol.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/27.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation

protocol DataFunc{
    
  
    
   typealias InvokerFunc = () -> Void
    
    associatedtype T
    
    
    func GetData()->[T]

    func GetCount()->Int;

    func InitData();

}
