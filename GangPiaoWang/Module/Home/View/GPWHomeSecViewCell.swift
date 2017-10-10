//
//  GPWHomeSecTableViewCell.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2016/12/19.
//  Copyright © 2016年 GC. All rights reserved.
//

import UIKit
import SwiftyJSON
class GPWHomeSecViewCell: UITableViewCell {
    
    var superControl:UIViewController?
    var dataDic:JSON?
    let array = [
                  ["img":"home_zhiyin","title":"平台介绍"],
                  ["img":"home_safe","title":"安全保障"],
                  ["img":"home_yaoqing","title":"热门活动"],
                  ["img":"home_getredbag","title":"拼手气"]
                ]
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let btnWith = SCREEN_WIDTH / 4
        for i in 0..<array.count {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: btnWith * CGFloat(i), y: 0, width: btnWith, height: 120)
            btn.tag = 100 + i
            btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
            self.contentView.addSubview(btn)
            
            let imgView = UIImageView(frame: CGRect(x: 36, y: 18, width: 44, height: 44))
            imgView.image = UIImage(named: array[i]["img"]!)
            imgView.centerX = btn.width / 2
            btn.addSubview(imgView)
            
            let titleLabel = UILabel(frame: CGRect(x: 0, y: imgView.maxY + 12, width: btn.width, height: 16))
            titleLabel.text = array[i]["title"]
            titleLabel.font = UIFont.customFont(ofSize: 15)
            titleLabel.textAlignment = .center
            titleLabel.textColor = UIColor.hex("666666")
            btn.addSubview(titleLabel)
        }
        
        let block = UIView(frame: CGRect(x: 0, y: 110, width: SCREEN_WIDTH, height: 10))
        block.backgroundColor = bgColor
        self.contentView.addSubview(block)
    }
    
    func updata(dic:JSON,superControl:UIViewController) {
        self.dataDic = dic
        self.superControl = superControl
    }
    
    func btnClick(sender:UIButton) {
        if sender.tag == 100 {
            MobClick.event("home", label: "菜单栏-新手指引")
           self.superControl?.navigationController?.pushViewController(GPWWebViewController(subtitle: "", url: HTML_SERVER +  (self.dataDic?["new_head"].string)!), animated: true)
        }else if sender.tag == 101 {
            MobClick.event("home", label: "菜单栏-安全保障")
            self.superControl?.navigationController?.pushViewController(GPWWebViewController(subtitle: "", url:  HTML_SERVER +  (self.dataDic?["insurance"].string)!), animated: true)
        }else if sender.tag == 102 {
            MobClick.event("home", label: "菜单栏-平台列表")
            let con = GPWUserQSetPWViewController()
           self.superControl?.navigationController?.pushViewController(con, animated: true)
        }else if sender.tag == 103 {
            MobClick.event("home", label: "菜单栏-拼手气")
            if GPWUser.sharedInstance().isLogin {
                self.superControl?.navigationController?.pushViewController(GPWHomeGetBageController(), animated: true)
            }else{
                self.superControl?.navigationController?.pushViewController(GPWLoginViewController(), animated: true)
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
