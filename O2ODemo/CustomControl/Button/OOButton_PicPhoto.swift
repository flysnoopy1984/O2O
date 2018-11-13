//
//  OOButton_PicPhoto.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/19.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

//带照相图片功能按钮
class OOButton_PicPhoto: OOButton,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    typealias AfterDevice = (UIImage) -> Void;
    
    var _ImagePicker:UIImagePickerController?;
    var _MainVC:UIViewController?;
    var _AfterDevice:AfterDevice?;
    
    func OpenPhoto(mainView:UIViewController,AfterDevice:@escaping AfterDevice){
        _MainVC = mainView;
        _AfterDevice = AfterDevice;
        OpenDevice(.camera);
    }
    
    func OpenPicture(mainView:UIViewController,AfterDevice:@escaping AfterDevice){
        
        _MainVC = mainView;
        _AfterDevice = AfterDevice;
        
        OpenDevice(.photoLibrary);
    }
    
    private func OpenDevice(_ sourceType:UIImagePickerController.SourceType){
        
        if self._ImagePicker == nil{
            self._ImagePicker = UIImagePickerController();
        }
        
        let isavaliable = UIImagePickerController.isSourceTypeAvailable(sourceType);
        
        if isavaliable{
            self._ImagePicker?.sourceType = sourceType;
        }
        else{
           
            SysHelper.AlertMessage(vc: _MainVC!, title: "错误", msg: "设备不可用");
            return ;
        }
        
        self._ImagePicker?.delegate = self;
        
        _MainVC?.present(self._ImagePicker!, animated: true, completion: nil);
        
        // return true;
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let photoedImg = info[UIImagePickerController.InfoKey.originalImage] as! UIImage;
         _AfterDevice!(photoedImg);
        _MainVC?.dismiss(animated: true, completion: nil);
    }

    //图片选择后需要做的事情。
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
//
//        let photoedImg = info[UIImagePickerControllerOriginalImage] as! UIImage;
//
//        _AfterDevice!(photoedImg);
//
//        _MainVC?.dismiss(animated: true, completion: nil);
//
//
//    }
    

}
