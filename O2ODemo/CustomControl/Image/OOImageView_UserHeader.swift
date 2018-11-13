//
//  ImageView_UserHeader.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/21.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class OOImageView_UserHeader: UIImageView {

    var PrevImage:UIImage?;
    let _OOFileManager = OOFileManager();
    var _MainVC:UIViewController?;
    var _LoadingView:OOLoadingView?;
    
    
    var _CornerWidth:CGFloat = 0    ;
    @IBInspectable
    var CornerWidth:CGFloat = 0 {
        didSet{
            _CornerWidth = CornerWidth;
            if _CornerWidth>0 {
                self.SetImgCorner(_CornerWidth);
            }
        }
    }
    
    func SetImageFromLocal()
    {
        if _OOFileManager.ExistFile_HeaderImage() {
            self.image = UIImage(contentsOfFile: OOFileManager.HeaderImageFullPath);
        }
        
    }
    
    //将当前Image上传
    func PickedNewImage(NewImage:UIImage){
        
        PrevImage = self.image;
        self.image = NewImage;
        
    }
    
    func SetToPrev(){
        self.image = PrevImage;
    }
    
    func SaveToLocation() -> Bool{
        
        let data:Data = self.image!.jpegData(compressionQuality: 0.5)! //UIImageJPEGRepresentation(self.image!, 0.5) as! Data;
       
        if (try? data.write(to: URL(fileURLWithPath:  OOFileManager.HeaderImageFullPath))) == nil
        {
            return false;
        }
        return true;
  
    }
    
    func SaveAndUpload(vc:UIViewController){
        _MainVC = vc;
        //遮罩
        _LoadingView = OOLoadingView(_MainVC!);
        _LoadingView?.ShowLoading("图片上传中...");
        
        //保存
        if self.SaveToLocation() == false
        {
            if _MainVC != nil{
                SysHelper.AlertAndClose(alertVC: _MainVC!, title: "保存图片", msg: "失败");
            }
            if _LoadingView != nil{
                _LoadingView?.CloseLoading();
            }
            return;
        }
        
        //上传
        let fn = UserData.GetPhone()+".jpg";
        
        self.image?.Upload(FileName: fn, SuccessUpload: SuccessUpload, FailureUpload: FailureUpload);

    }
    
   
    func AfterPopEvent(newVC:UIViewController){
        SysHelper.AlertMessage(vc: newVC, title: "上传图片", msg:"成功");
    }
    
    func SuccessUpload(result:JSON){
        
        if _LoadingView != nil{
            _LoadingView?.CloseLoading();
            
            let IsSucces = result["IsSuccess"].boolValue;
            let msg = result["ErrorMsg"].stringValue;
            if IsSucces == false {
                SysHelper.AlertMessage(vc: _MainVC!, title: "错误", msg: msg);
                return;
            }
           else
            {
                 ControllerManager.Single.PopPersonEdit(self._MainVC!,AfterPopEvent: AfterPopEvent);
            }
            
      
        }
    }

    func FailureUpload(error:Error)
    {
        if _LoadingView != nil{
            _LoadingView?.CloseLoading();
        }
        if _MainVC != nil{
            let msg = "失败：\(error)";
            SysHelper.AlertAndClose(alertVC: _MainVC!, title: "上传图片", msg: msg);
        }
    }
    
    
   
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
