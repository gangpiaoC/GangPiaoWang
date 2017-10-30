//
//  GPWADView.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2017/4/5.
//  Copyright © 2017年 GC. All rights reserved.
//

import UIKit

class GPWADView: UIView {
    fileprivate var isRemoved = false
    fileprivate var btn:UIButton!
    fileprivate var imgStr = ""
    fileprivate var urlStr = ""
    fileprivate var  timer:Timer!
    init(imgStr:String,toUrl:String) {
        super.init(frame: UIScreen.main.bounds)
        MobClick.beginLogPageView("广告界面")
        self.imgStr = imgStr
        self.urlStr = toUrl
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.alpha = 1.0
        self.backgroundColor = UIColor.white
        let imgView = UIImageView(frame: self.bounds)
        imgView.downLoadImg(imgUrl: self.imgStr,placeImg: "meiyou")
        imgView.isUserInteractionEnabled = true
        self.addSubview(imgView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imgClick))
        imgView.addGestureRecognizer(tapGesture)
        
        //按钮
        btn = UIButton(type: .custom)
        btn.frame = CGRect(x: SCREEN_WIDTH - 16 - 70, y: 32, width: 70, height: 25)
        btn.backgroundColor = UIColor.hex("000000", alpha: 0.4)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 12.5
        btn.setTitle("跳过3s", for: .normal)
        btn.addTarget(self, action: #selector(self.remove), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(btn)
        
        let timer:Timer = Timer(timeInterval: 1.0,
                                target: self,
                                selector: #selector(self.updateTimer(timer:)),
                                userInfo: nil,
                                repeats: true)
        
        // 将定时器添加到运行循环
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func updateTimer(timer:Timer) {
        let title = btn.title(for: .normal)
        if  title == "跳过3s"{
            btn.setTitle("跳过2s", for: .normal)
        }else if title == "跳过2s"{
            btn.setTitle("跳过1s", for: .normal)
        }else if title == "跳过1s"{
            btn.setTitle("跳过0s", for: .normal)
        }else if title == "跳过0s"{
            timer.invalidate()
            CFRunLoopStop(CFRunLoopGetCurrent())
            self.remove()
            if GYCircleConst.getGestureWithKey(gestureFinalSaveKey) == nil {
                if GPWGlobal.sharedInstance().initJson?["app_popup"]["img_url"].stringValue.characters.count ?? 0 > 7 {
                    if  GPWHelper.getDay()[3] == "0" {
                        GPWHelper.showHomeAD(url: (GPWGlobal.sharedInstance().initJson?["app_popup"]["img_url"].stringValue)!)
                        GPWGlobal.sharedInstance().homeADtoUrl = GPWGlobal.sharedInstance().initJson?["app_popup"]["link"].stringValue
                    }
                }
            }
        }
    }
    
    func buttonAction() {
        remove()
    }
    
    func imgClick() {
        MobClick.endLogPageView("广告界面")
        printLog(message: "图片点击")
         self.removeFromSuperview()
        if GYCircleConst.getGestureWithKey(gestureFinalSaveKey) != nil {
            GPWGlobal.sharedInstance().gotoUrl = self.urlStr
            let gestureVC = GestureViewController()
            gestureVC.type = GestureViewControllerType.login
            gestureVC.flag = true
            _ = GPWHelper.selectedNavController()?.pushViewController(gestureVC, animated: false)
        }else{
            gotoController()
        }
    }
    
    //去往web或者标的
    func gotoController() {
        if self.urlStr.characters.count < 5 {

        }else if (self.urlStr.range(of: "https")) != nil{
            if self.urlStr.characters.count > 6 {
                GPWHelper.selectedNavController()?.pushViewController(GPWWebViewController(subtitle: "", url: self.urlStr), animated: true)
            }
        }else{
            GPWHelper.selectedNavController()?.pushViewController(GPWProjectDetailViewController(projectID: self.urlStr), animated: true)
        }
    }
    
    func remove() {
        isRemoved = true
        UIView.animate(withDuration: 1, delay: 0, options: .beginFromCurrentState,
                       animations: {
                        self.alpha = 0.0
                        self.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
        }) { (finished) in
            MobClick.endLogPageView("广告界面")
            self.removeFromSuperview()
        }
    }
}

