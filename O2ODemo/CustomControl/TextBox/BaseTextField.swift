//
//  BaseTextField.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/8/30.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {

    typealias InputDoneEvent = () -> Void;
    
    let _DoneToolbar = UIToolbar();
    var _AfterInputDone:InputDoneEvent?;
   
    func SetupTopBar(InputDone:@escaping InputDoneEvent = {}){
        _AfterInputDone = InputDone;
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        
        let done = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(DoneButtonAction));
        
        var items:[UIBarButtonItem] = [];
        items.append(flexSpace);
        items.append(done);
        
        _DoneToolbar.items = items;
        _DoneToolbar.sizeToFit();
        
        self.inputAccessoryView  = _DoneToolbar;
        
    }
    
   
    
    func CheckFieldIsEmpty(checkEmpty:Bool = true) -> Bool
    {
        if checkEmpty{
            return (self.text?.trimmingCharacters(in: .whitespaces) != "")
        }
        
        return true;
    }
    
    //完成输入后的事件
    func SetDoneEvent(InputDoneEvent:@escaping InputDoneEvent){
        _AfterInputDone = InputDoneEvent;
    }

    @objc func DoneButtonAction(){
        
        self.resignFirstResponder();
        
        if _AfterInputDone != nil{
            _AfterInputDone!();
        }
    }

  
    

}
