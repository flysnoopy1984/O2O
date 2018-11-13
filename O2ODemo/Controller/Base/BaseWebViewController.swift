//
//  BaseWebViewController.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/10/8.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit
import WebKit
/*
 WKNavigationDelegate 处理跳转，加载等
 
 WKUIDelegate 处理JS脚本，确认框，警告框。
 */
class BaseWebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {
    
    @IBOutlet var _WebView:WKWebView?;
    
    let _KeyPathProgress = "estimatedProgress";
    
    lazy var _Progress:UIProgressView = {
        self._Progress = UIProgressView.init(frame: CGRect(x: 0, y: 65, width: UIScreen.main.bounds.width, height: 2));
        self._Progress.tintColor = UIColor.orange;
        self._Progress.trackTintColor = UIColor.white;
        self._Progress.progressViewStyle = .bar;
      
       return self._Progress;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // Do any additional setup after loading the view.
        
        InitProgress();
        
        InitWebView();
        
       
    }
    
    func LoadUrlString(_ urlString:String){
        
        if let url = URL(string: urlString){
            let req = URLRequest(url: url);
            _WebView?.load(req);
        }
    }
    
    func InitWebView(){
   
        _WebView?.navigationDelegate = self;
        _WebView?.uiDelegate = self;
     
        _WebView?.addObserver(self, forKeyPath: _KeyPathProgress, options: .new, context: nil)
    }
    
    func InitProgress(){
        
      
        self.view.addSubview(_Progress)
        
    }
    

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         print("开始请求网页")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("开始获取网页内容")
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print("加载完成")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         print("加载失败")
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        SysHelper.AlertAndClose(alertVC: self, title: "信息", msg: message);
        
        completionHandler();
    }
    

    //监听网页加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == _KeyPathProgress{
            
            _Progress.alpha = 1.0;
            _Progress.setProgress(Float((_WebView?.estimatedProgress)!), animated: true);
            
            if (_WebView?.estimatedProgress)! >= 1.0{
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut,
                animations: {
                    self._Progress.alpha = 0;
                },
                completion: {(finish) in
                    self._Progress.setProgress(0.0, animated: false);
                
                })
            }
        }
    }
    
    deinit {
        _WebView?.removeObserver(self, forKeyPath: _KeyPathProgress);
        _WebView?.uiDelegate = nil;
        _WebView?.navigationDelegate = nil;
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
