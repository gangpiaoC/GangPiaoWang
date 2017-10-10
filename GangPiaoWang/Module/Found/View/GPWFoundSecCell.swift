//
//  GPWHomeSecTableViewCell.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2016/12/19.
//  Copyright © 2016年 GC. All rights reserved.
//

import UIKit
class GPWFoundSecCell: UITableViewCell {
    
    var superControl:UIViewController?
    fileprivate var weixin:String?
    let array = [
                  ["img":"found_weixin","title":"关注微信"],
                  ["img":"found_action","title":"热门活动"],
                  ["img":"found_kefu","title":"我的客服"]
                ]
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        let btnWith = SCREEN_WIDTH / 3
        for i in 0..<array.count {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: btnWith * CGFloat(i), y: 0, width: btnWith, height: 79)
            btn.tag = 100 + i
            btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
            self.contentView.addSubview(btn)
            
            let imgView = UIImageView(frame: CGRect(x: 36, y: 0, width: 38, height: 38))
            imgView.image = UIImage(named: array[i]["img"]!)
            imgView.centerX = btn.width / 2
            btn.addSubview(imgView)
            
            let titleLabel = UILabel(frame: CGRect(x: 0, y: imgView.maxY + 3, width: btn.width, height: 16))
            titleLabel.text = array[i]["title"]
            titleLabel.font = UIFont.customFont(ofSize: 16)
            titleLabel.textAlignment = .center
            titleLabel.textColor = UIColor.hex("666666")
            btn.addSubview(titleLabel)
        }
        
        let block = UIView(frame: CGRect(x: 0, y: 79, width: SCREEN_WIDTH, height: 10))
        block.backgroundColor = bgColor
        self.contentView.addSubview(block)
    }
    
    func updata(weixin:String,superControl:UIViewController) {
        self.weixin = weixin
        self.superControl = superControl
    }
    
    func btnClick(sender:UIButton) {
        if sender.tag == 100 {
            MobClick.event("found", label: "菜单-微信")
            self.superControl?.navigationController?.pushViewController(GPWWebViewController(subtitle: "", url: self.weixin ?? ""), animated: true)
        }else if sender.tag == 101 {
            MobClick.event("found", label: "菜单-活动")
            self.superControl?.navigationController?.pushViewController(GPWActiveViewController(), animated: true)
        }else if sender.tag == 102 {
            MobClick.event("found", label: "菜单-客服")
            self.myCustem()
        }
    }
    
    //我的客服
    func  myCustem(){
        printLog(message: "客服")
        MobClick.event("mine_chat", label: "客服")
        let initInfo = ZCLibInitInfo()
        initInfo.appKey = "0c7bf5fc11374541be663008ec7d4b8d"
        initInfo.nickName = GPWUser.sharedInstance().user_name ?? "未登录"
        initInfo.phone = GPWUser.sharedInstance().telephone ?? "未填写"
        let uiInfo = ZCKitInfo()
        // self.customer(kitInfo: uiInfo)
        uiInfo.info = initInfo
        
        //启动
        ZCSobot.startZCChatView(uiInfo, with: self.superControl?.navigationController, pageBlock: { (object, type) in
            
        }) { (msg) in
            
        }
    }
    func customer(kitInfo:ZCKitInfo)  {
        //点击返回是否出发满意度评价
        kitInfo.isOpenEvaluation = true
        //是否显示语音按钮
        kitInfo.isOpenRecord = true
        kitInfo.isShowTansfer = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
