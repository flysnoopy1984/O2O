//
//  UITextFieldExtension.swift
//  YJOO
//
//  Created by jackyPC on 2018/11/16.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    func isTelNumber(num:String)->Bool
    {
        
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        
        if (regextestmobile.evaluate(with: num) == true)
        {
            return true
        }
        else
        {
            return false
        }
        
    }
}
