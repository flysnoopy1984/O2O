//
//  OOBannerCell.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/6.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit

class OOBannerCell:UICollectionViewCell
{
    var BannerImage:UIImageView!
    var IsLoading:Bool!;
    var Position:Int!;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        IsLoading = true;
        Position = 0;
        
        BannerImage = UIImageView();
        BannerImage.contentMode = .scaleAspectFill
        
        self.addSubview(BannerImage);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        BannerImage.frame = self.bounds
    }
    
}
