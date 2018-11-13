//
//  OOTabBarController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/7/17.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit

class OOTabBarController:UITabBarController
{
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        let items = self.tabBar.items;
        
        items?.forEach({ (item) in
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal);
            item.image = item.image?.withRenderingMode(.alwaysOriginal);
        })
        
    }
}
