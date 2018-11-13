//
//  OOScrollView.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/9/3.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit

//给登录和注册用
/*
 永远多出一块View可上移
 */
class OOScrollView: UIScrollView {

    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        self.SetupScrollView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
        self.SetupScrollView();
    }
    
  
    
    func SetupScrollView()
    {
        //允许弹性
        self.alwaysBounceVertical = true;
        //垂直滚动条是否可见
        self.showsHorizontalScrollIndicator = true;
        
      
          //新增一个新的View(大小为当前页面一半),接在当前页面后面
        let frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height/2);
      
        let view = UIView(frame: frame);
        view.backgroundColor = self.backgroundColor;
        
        self.addSubview(view);
        
        //设置滚动的区域
        self.contentSize =  CGSize(width: self.frame.width, height: self.frame.height+view.frame.height);

    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
