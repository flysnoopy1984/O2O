//
//  EditHeaderImage.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/19.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class EditHeaderImageController: BaseUIViewController {

    //头像
    @IBOutlet var _ImgProfileHeader:OOImageView_UserHeader?;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    override func BackToPrevPage() {
        
        if _ImgProfileHeader?.PrevImage != nil {
             _ImgProfileHeader?.SetToPrev();
        }
       
        super.BackToPrevPage();
    }
    
    @IBAction func BtnPhotoClick(sender:OOButton_PicPhoto)
    {
        sender.OpenPhoto(mainView: self, AfterDevice: (_ImgProfileHeader?.PickedNewImage)!)
       // OpenPhoto();
    }
    
    @IBAction func BtnPictureClick(sender:OOButton_PicPhoto)
    {
        sender.OpenPicture(mainView: self, AfterDevice: (_ImgProfileHeader?.PickedNewImage)!)
    }
    
    @IBAction func Save(sender:AnyObject){
        
        if _ImgProfileHeader?.image != nil{
            
            _ImgProfileHeader?.PrevImage = nil;
            
            _ImgProfileHeader?.SaveAndUpload(vc: self);
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //没有之前的图片，说明不是抄稿
        if _ImgProfileHeader?.PrevImage == nil {
            //尝试从本地读取
            _ImgProfileHeader?.SetImageFromLocal();
        }
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
