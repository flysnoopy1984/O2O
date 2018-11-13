//
//  OOBannerView.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/5.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class OOBannerView:UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource
{
    let cellIdentifier = "BannerCell"
    var index = 1;
    let flowLayout =  UICollectionViewFlowLayout()
    var _PagerControl:UIPageControl?;
    var _CurIndexPath: IndexPath?;
    var _oldPosX:CGFloat = 0;
    var _timer:DispatchSourceTimer? = nil;
    var _scrollAuto:Bool = false;
    
    var _Data:BannerData;
    
    init(frame: CGRect) {
        
        _Data = BannerData();
       
        
        super.init(frame: frame,collectionViewLayout: flowLayout);
        
        _Data.AfterInitData = ResetView;

        InitLayout();
        
        SetupView();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func InitLayout(){
        flowLayout.itemSize = self.frame.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
    }
    
    private func SetupView()
    {
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true;
    
        self.register(OOBannerCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        _CurIndexPath = IndexPath(item: _Data.GetCount(), section: 0)
        self.scrollToItem(at: _CurIndexPath!, at: .centeredHorizontally, animated: true);
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        guard _PagerControl != nil else
        {
            SetupPageControl(self);
            return;
        }
      
    }
    
   
    
    //外部安装使用
    func SetupPageControl(_ parent:UIView)
    {
        
        let h:CGFloat = 20;
        let frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: h)
        
        _PagerControl = UIPageControl();
        
        _PagerControl?.frame = frame;
        _PagerControl?.numberOfPages = _Data.GetCount();
        _PagerControl?.isUserInteractionEnabled = false;
        _PagerControl?.currentPage = 0;
        _PagerControl?.currentPageIndicatorTintColor = UIColor.orange
        _PagerControl?.pageIndicatorTintColor = UIColor.white
        
        superview?.addSubview(_PagerControl!);
      //  parent.addSubview(_PagerControl!);
        
        startTimer();
     
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _Data.GetCount() * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OOBannerCell
        
        let c = _Data.GetCount();
        
        let i = (indexPath.item) % (c); //0--2

        if let banner = _Data.Banner[i+1]
        {
            cell.BannerImage.image = banner.Image;
            cell.Position = banner.Pos;
        }
        
        return cell
    }
    
    func ReAdjustImage(){
        
        if _CurIndexPath?.item == 0 {
            _CurIndexPath = IndexPath(item: _Data.GetCount(), section: 0)
            self.scrollToItem(at: _CurIndexPath!, at: .centeredHorizontally, animated: false);
            
        }
        else if _CurIndexPath?.item == _Data.GetCount() * 2 - 1{
            _CurIndexPath = IndexPath(item: _Data.GetCount()-1 , section: 0)
           self.scrollToItem(at: _CurIndexPath!, at: .centeredHorizontally, animated: false);
         //  print("ReAdjustImage  \(_CurIndexPath?.item)");
        }

    }
    
    func PrevBanner(){
        
        if self._PagerControl?.currentPage == 0{
            self._PagerControl?.currentPage = _Data.GetCount() - 1
        }
        else{
            self._PagerControl?.currentPage -= 1
        }
        
        _CurIndexPath?.item -= 1;
        ReAdjustImage();
 
    }
    
    func NextBanner(){
        
        if self._PagerControl?.currentPage == _Data.GetCount() - 1 {
            
            self._PagerControl?.currentPage = 0;
        }
        else{
            
            self._PagerControl?.currentPage += 1
  
        }
        
        _CurIndexPath?.item += 1;
        
        ReAdjustImage()
        
        if _scrollAuto == true {
         //   print("Animate To \(_CurIndexPath?.item)");
            self.scrollToItem(at: _CurIndexPath!, at: .centeredHorizontally, animated: true);
        }
        
    }
    
    func startTimer(){
        if _timer == nil || (_timer?.isCancelled)! {
            
             _scrollAuto = true;
            
            _timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main);
            
            _timer?.schedule(deadline: DispatchTime.now(),repeating:DispatchTimeInterval.seconds(2))
            
            _timer?.setEventHandler(handler: {
                self.NextBanner();
            })
            
            _timer?.resume()
        }
        else
        {
            _timer?.resume();
            
        }
       
 
    }
    
    func SuspendTimer(){
        if _timer != nil {
            _timer?.suspend();
        }
        _scrollAuto = false;
      
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        _oldPosX = self.contentOffset.x;
     //   SuspendTimer();
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
     //   startTimer();
    }
    
  
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if _scrollAuto {
          //  ReAdjustImage(
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

       
        guard _oldPosX == scrollView.contentOffset.x else {
            
            if _oldPosX > scrollView.contentOffset.x {
                PrevBanner();
            }
            else{
                NextBanner();
            }
            return;
        }
      
    }
    
    func ResetView()
    {
        self.reloadData();
    }
    
    
    
   
    
//    func downLoadImage(imageView:UIImageView)
//    {
//        var SysConfigMO = CoreDataHelper.shared().GetSysConfigMO()
//        let url = URL(string:(SysConfigMO.mainHost?.absoluteString)! + "/Content/Images/AppBanner/Banner1.png");
//        let data = NSData(contentsOf: url!);
//        let image = UIImage(data: data! as Data);
//        imageView.image = image;
//        imageView.kf.setImage(with: url)
//
//
//        //打开该url地址的图片
//      //  imageView.kf_setImageWithURL(url)
//
//    }
    
  
   
    
    
}
