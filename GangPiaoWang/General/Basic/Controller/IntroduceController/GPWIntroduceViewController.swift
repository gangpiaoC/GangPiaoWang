//
//  GPWIntroduceViewController.swift
//  GangPiaoWang
//  引导界面
//  Created by GC on 16/12/5.
//  Copyright © 2016年 GC. All rights reserved.
//

import UIKit

class GPWIntroduceView: UIView, UIScrollViewDelegate {
    fileprivate let pageCount = 4
    fileprivate var isRemoved = false
    fileprivate var scrollView: UIScrollView!
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.alpha = 1.0
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: CGFloat(pageCount) * SCREEN_WIDTH, height: self.bounds.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        
        for index in 0..<pageCount {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * self.bounds.width, y: 0, width: self.bounds.width, height: self.bounds.height))
            printLog(message: SCREEN_HEIGHT)
            if SCREEN_HEIGHT < 568 {
                imageView.image = UIImage(named: "introduce\(index)")
            }else{
                imageView.image = UIImage(named: "introduce\(index)_\(index)")
            }
            
            scrollView.addSubview(imageView)
            imageView.backgroundColor = UIColor.gray
            
            if index == pageCount - 1 {
                let button = UIButton(type: .custom)
                button.frame = CGRect(x: 0, y: self.bounds.height / 10 * 8.5, width: 216, height: 56)
                button.center.x = self.bounds.width / 2
                button.setBackgroundImage(UIImage(named: "induct_btn"), for: .normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                imageView.isUserInteractionEnabled = true
                imageView.addSubview(button)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        if offsetX > (SCREEN_WIDTH * CGFloat(pageCount - 1) + 100) {
            if !isRemoved {
                remove()
            }
        }
    }
    
    func buttonAction() {
        UserDefaults.standard.set(true, forKey: "isInstalled")
        remove()
    }
    
    func remove() {
        isRemoved = true
        if let dic = GPWGlobal.sharedInstance().initJson{
            if dic["app_info"]["advert_picture"].stringValue.characters.count > 5  && dic["app_info"]["is_vaild"].intValue == 1 {
                self.window!.addSubview(GPWADView(imgStr: dic["app_info"]["advert_picture"].stringValue,toUrl:dic["app_info"]["advert_url"].stringValue))
            }
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
        }) { (isFinished) in
            self.removeFromSuperview()
        }
    }
}
