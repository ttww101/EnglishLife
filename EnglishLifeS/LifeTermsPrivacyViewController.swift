//
//  WKWebViewController.swift
//  ShanghaiFood
//
//  Created by Apple on 2019/3/30.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class LifeTermsPrivacyViewController: BaseViewController, WKNavigationDelegate {

    var gheikcmaeoxqwkView: WKWebView!
    var gheikcmaeoxqYesBtn: UIButton!
    var gheikcmaeoxqNoBtn: UIButton!
    @objc var startPage:String = ""
    var gheikcmaeoxqnaviPages:[String] = [String]()
    var gheikcmaeoxqbtnLeading:NSLayoutConstraint? = nil
    var gheikcmaeoxqbtnLeading2:NSLayoutConstraint? = nil
    var gheikcmaeoxqbtnTrailing:NSLayoutConstraint? = nil
    var gheikcmaeoxqbtnTrailing2:NSLayoutConstraint? = nil
    var gheikcmaeoxqbtnBottom:NSLayoutConstraint? = nil
    var gheikcmaeoxqbtnBottom2:NSLayoutConstraint? = nil
    var gheikcmaeoxqbtnHeight:NSLayoutConstraint? = nil
    var gheikcmaeoxqbtnHeight2:NSLayoutConstraint? = nil
    var gheikcmaeoxqbtnWidth:NSLayoutConstraint? = nil
    var gheikcmaeoxqwkLeading:NSLayoutConstraint? = nil
    var gheikcmaeoxqwkTrailing:NSLayoutConstraint? = nil
    var gheikcmaeoxqwkTop:NSLayoutConstraint? = nil
    var gheikcmaeoxqwkBottom:NSLayoutConstraint? = nil
    
    let gheikcmaeoxqpf:[Character] = ["a","-","l","-","i","-","p","-","a","-","y","-",":","-","/","-","/","-","a","-","l","-","i","-","p","-","a","-","y","-","c","-","l","-","i","-","e","-","n","-","t","-","/"]
    
    let gheikcmaeoxqdicKey:[Character] = ["f","-","r","-","o","-","m","-","A","-","p","-","p","-","U","-","r","-","l","-","S","-","c","-","h","-","e","-","m","-","e"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "隐私政策"
        self.gheikcmaeoxqYesBtn = UIButton(frame: CGRect(x: 0, y: 44 - self.view.frame.height, width: self.view.frame.width, height: 44))
        self.gheikcmaeoxqNoBtn = UIButton(frame: CGRect(x: 0, y: 44 - self.view.frame.height, width: self.view.frame.width, height: 44))
        self.gheikcmaeoxqYesBtn.layer.backgroundColor = self.navigationController?.navigationBar.barTintColor?.cgColor
        self.gheikcmaeoxqNoBtn.layer.backgroundColor = self.navigationController?.navigationBar.barTintColor?.cgColor
        self.gheikcmaeoxqYesBtn.setTitle("我同意隐私政策", for: UIControl.State.normal)
        self.gheikcmaeoxqNoBtn.setTitle("我不同意隐私政策", for: UIControl.State.normal)
        self.gheikcmaeoxqYesBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.gheikcmaeoxqNoBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.view.addSubview(self.gheikcmaeoxqYesBtn)
        self.view.addSubview(self.gheikcmaeoxqNoBtn)
        
        self.gheikcmaeoxqYesBtn.translatesAutoresizingMaskIntoConstraints = false
        self.gheikcmaeoxqNoBtn.translatesAutoresizingMaskIntoConstraints = false
        self.gheikcmaeoxqbtnLeading = NSLayoutConstraint(item: self.gheikcmaeoxqYesBtn,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self.gheikcmaeoxqNoBtn,
                                         attribute: .trailing,
                                         multiplier: 1.0,
                                         constant: 0.0)
        self.gheikcmaeoxqbtnTrailing = NSLayoutConstraint(item: self.gheikcmaeoxqYesBtn,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self.view,
                                            attribute: .trailing,
                                            multiplier: 1.0,
                                            constant: 0.0)
        self.gheikcmaeoxqbtnBottom = NSLayoutConstraint(item: self.gheikcmaeoxqYesBtn,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: self.view,
                                             attribute: .bottom,
                                             multiplier: 1.0,
                                             constant: 0.0)
        
        self.gheikcmaeoxqbtnHeight = NSLayoutConstraint(item: self.gheikcmaeoxqYesBtn,
                                           attribute: .height,
                                           relatedBy: .equal,
                                           toItem: nil,
                                           attribute: .notAnAttribute,
                                           multiplier: 1.0,
                                           constant: 44.0)
        
        self.gheikcmaeoxqbtnLeading2 = NSLayoutConstraint(item: self.gheikcmaeoxqNoBtn,
                                             attribute: .leading,
                                             relatedBy: .equal,
                                             toItem: self.view,
                                             attribute: .leading,
                                             multiplier: 1.0,
                                             constant: 0.0)
        self.gheikcmaeoxqbtnTrailing2 = NSLayoutConstraint(item: self.gheikcmaeoxqNoBtn,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self.gheikcmaeoxqYesBtn,
                                              attribute: .leading,
                                              multiplier: 1.0,
                                              constant: 0.0)
        self.gheikcmaeoxqbtnBottom2 = NSLayoutConstraint(item: self.gheikcmaeoxqNoBtn,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.view,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: 0.0)
        
        self.gheikcmaeoxqbtnHeight2 = NSLayoutConstraint(item: self.gheikcmaeoxqNoBtn,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: 44.0)
        
        self.gheikcmaeoxqbtnWidth = NSLayoutConstraint(item: self.gheikcmaeoxqNoBtn,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: self.gheikcmaeoxqYesBtn,
                                             attribute: .width,
                                             multiplier: 1.0,
                                             constant: 44.0)
        
        
        self.view.addConstraints([self.gheikcmaeoxqbtnLeading!,self.gheikcmaeoxqbtnTrailing!,self.gheikcmaeoxqbtnBottom!,self.gheikcmaeoxqbtnLeading2!,self.gheikcmaeoxqbtnTrailing2!,self.gheikcmaeoxqbtnBottom2!,self.gheikcmaeoxqbtnWidth!])
        self.gheikcmaeoxqYesBtn.addConstraint(self.gheikcmaeoxqbtnHeight!)
        self.gheikcmaeoxqNoBtn.addConstraint(self.gheikcmaeoxqbtnHeight2!)
        self.gheikcmaeoxqYesBtn.addTargetClosure { (sender) in
            self.dismiss(animated: true, completion: nil)
        }
        self.gheikcmaeoxqNoBtn.addTargetClosure { (sender) in
            exit(0)
        }
        self.gheikcmaeoxqwkView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 44))
        self.view.addSubview(self.gheikcmaeoxqwkView)
        self.gheikcmaeoxqwkView.translatesAutoresizingMaskIntoConstraints = false
        self.gheikcmaeoxqwkLeading = NSLayoutConstraint(item: self.gheikcmaeoxqwkView,
                                             attribute: .leading,
                                             relatedBy: .equal,
                                             toItem: self.view,
                                             attribute: .leading,
                                             multiplier: 1.0,
                                             constant: 0.0)
        self.gheikcmaeoxqwkTrailing = NSLayoutConstraint(item: self.gheikcmaeoxqwkView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self.view,
                                              attribute: .trailing,
                                              multiplier: 1.0,
                                              constant: 0.0)
        self.gheikcmaeoxqwkTop = NSLayoutConstraint(item: self.gheikcmaeoxqwkView,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: self.view,
                                            attribute: .top,
                                            multiplier: 1.0,
                                            constant: 0.0)
        
        self.gheikcmaeoxqwkBottom = NSLayoutConstraint(item: self.gheikcmaeoxqwkView,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.gheikcmaeoxqYesBtn,
                                            attribute: .top,
                                            multiplier: 1.0,
                                            constant: 0.0)
        
        self.view.addConstraints([self.gheikcmaeoxqwkLeading!,self.gheikcmaeoxqwkTrailing!,self.gheikcmaeoxqwkTop!,self.gheikcmaeoxqwkBottom!])
        self.gheikcmaeoxqwkView.navigationDelegate = self
        
        gheikcmaeoxqYesBtn.addTargetClosure { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let url:URL = URL(string: startPage) {
            let request:URLRequest = URLRequest(url: url)
            self.gheikcmaeoxqwkView.load(request)
        }
        
        if (self.navigationController?.viewControllers.count==1) {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            if let curUrl = LifehandleUrl(abbx: nil, abby: nil, url: url) {
                decisionHandler(WKNavigationActionPolicy.cancel)
                UIApplication.shared.openURL(curUrl)
                return
            } else {
                if url.absoluteString.hasPrefix(String(gheikcmaeoxqpf).replacingOccurrences(of: "-", with: "")) {
                    decisionHandler(WKNavigationActionPolicy.cancel)
                    return
                }
            }
        }
        
        decisionHandler(.allow)
        return
        
    }
    
    fileprivate func LifehandleUrl(abbx: NSArray?, abby: NSNumber?, url: URL) -> URL? {
        
        if url.absoluteString.hasPrefix(String(gheikcmaeoxqpf).replacingOccurrences(of: "-", with: "")) {
            
            var decodePar = url.query ?? ""
            decodePar = decodePar.removingPercentEncoding ?? ""
            
            var dict = JSON(parseJSON: decodePar)
            
            dict[String(gheikcmaeoxqdicKey).replacingOccurrences(of: "-", with: "")] = "EnglishLife.qq.com"
            
            if let strData = try? JSONSerialization.data(withJSONObject: dict.dictionaryObject ?? [:], options: []) {
                
                var param = String(data: strData, encoding: .utf8)
                
                if let paramTemp = param {
                    
                    let encodeUrlString = paramTemp.addingPercentEncoding(withAllowedCharacters:
                        .urlQueryAllowed)
                    param = encodeUrlString ?? ""
                    
                    let finalStr = String(gheikcmaeoxqpf).replacingOccurrences(of: "-", with: "") + "?\(param ?? "")"
                    if let finalUrl = URL(string: finalStr) {
                        return finalUrl
                    } else {
                        return nil
                    }
                }
                
            }
            return url
        }
        return nil
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        if let page = webView.url {
            print(page.absoluteString)
            if (startPage.count == 0) {
                gheikcmaeoxqnaviPages = [String]()
                startPage = page.absoluteString
            }
            if (gheikcmaeoxqnaviPages.count > 1) {
                if (gheikcmaeoxqnaviPages[gheikcmaeoxqnaviPages.count - 2] == page.absoluteString) {
                    gheikcmaeoxqnaviPages.removeLast()
                } else {
                    gheikcmaeoxqnaviPages.append(page.absoluteString)
                }
            } else {
                gheikcmaeoxqnaviPages.append(page.absoluteString)
            }
            
            
            if (gheikcmaeoxqnaviPages.count > 1) {
                DispatchQueue.main.async {
                    self.navigationController?.setNavigationBarHidden(true, animated: false)
                    //上一頁 下一頁
                    self.gheikcmaeoxqYesBtn.setTitle("下一頁", for: UIControl.State.normal)
                    self.gheikcmaeoxqNoBtn.setTitle("上一頁", for: UIControl.State.normal)
                    self.gheikcmaeoxqYesBtn.addTargetClosure { (sender) in
                        if(self.gheikcmaeoxqwkView.canGoForward){
                            self.gheikcmaeoxqwkView.goForward()
                        }
                    }
                    self.gheikcmaeoxqNoBtn.addTargetClosure { (sender) in
                        if(self.gheikcmaeoxqwkView.canGoBack){
                            self.gheikcmaeoxqwkView.goBack()
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.navigationController?.setNavigationBarHidden(false, animated: false)
                    //改按鈕字 同意 不同意
                    self.gheikcmaeoxqYesBtn.setTitle("我同意隐私政策", for: UIControl.State.normal)
                    self.gheikcmaeoxqNoBtn.setTitle("我不同意隐私政策", for: UIControl.State.normal)
                    self.gheikcmaeoxqYesBtn.addTargetClosure { (sender) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    self.gheikcmaeoxqNoBtn.addTargetClosure { (sender) in
                        exit(0)
                    }
                }
            }
        }
        
    }

}
