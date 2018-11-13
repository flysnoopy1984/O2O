//
//  OOLoadingView.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/17.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

class OOLoadingView {
    
    
    private var _LodingView:UIView? = nil;
    private var _MainVC:UIViewController;
    private var _CurrentView:UIView;
    
    init(_ MainVC:UIViewController) {
        
        _MainVC = MainVC;
        _CurrentView = _MainVC.view;
    }
    
    func ShowLoading(_ loadText:String = ""){
        if _LodingView == nil{
            
            _LodingView = CreateLoadingView(loadText);
            _CurrentView.addSubview(_LodingView!);
            
            if _MainVC.navigationController != nil {
                _MainVC.navigationController?.isNavigationBarHidden = true;
            }
           
        }
        else{
            _LodingView?.isHidden = false;
        }
        _CurrentView.superview?.isUserInteractionEnabled = false;
    }
    
    func CloseLoading(){
        //隐藏Loading View
        _LodingView?.isHidden = true;
        //主界面操控
        _CurrentView.superview?.isUserInteractionEnabled = true;
        
        if _MainVC.navigationController != nil {
            _MainVC.navigationController?.isNavigationBarHidden = false;
        }
        
    }
    
    func CreateLoadingView(_ text:String) ->UIView
    {
        var txt = text;
        
        if txt == "" {
            txt = "数据加载中...";
        }
        

        let loadview =  UIView(frame: UIScreen.main.bounds);
        loadview.backgroundColor = UIColor.white;
        loadview.alpha = 0.6;
       
        
        let bkVW = CGFloat(150.0);
        let bkVH = CGFloat(150.0);
        let bkView = UIView(frame: CGRect(x:(UIScreen.main.bounds.width - bkVW)/2,
                                          y: (UIScreen.main.bounds.height-bkVH)/2,
                                          width: bkVW,
                                          height: bkVH))
        
        //背景黑色
        bkView.backgroundColor = UIColor.black;
        //添加圆角
        bkView.layer.cornerRadius = 10;
        bkView.clipsToBounds = true;
        
        let w = CGFloat(20);
        let h = CGFloat(20);
        
        //Loading的图片
        let imgLoad = UIActivityIndicatorView(frame: CGRect(x: (bkVW - w)/2, y: bkVH/4, width: w, height: h));
        imgLoad.style = .white;
        imgLoad.hidesWhenStopped = true;
        imgLoad.startAnimating();
        
        //Loading的文字
        let loadText = UITextField(frame:CGRect(x: 0, y: 0, width: bkVW, height: 20))
        loadText.textAlignment = .center;
        loadText.center = CGPoint(x: bkVW/2, y: bkVH/4*3);
        loadText.text = txt;
        loadText.textColor = UIColor.white;
        
        
        bkView.addSubview(imgLoad);
        bkView.addSubview(loadText);
        
        loadview.addSubview(bkView);
        
      
        
        return loadview;
        
    }
}
