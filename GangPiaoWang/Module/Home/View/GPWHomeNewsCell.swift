//
//  GPWHomeNewsCell.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2017/3/21.
//  Copyright © 2017年 GC. All rights reserved.
//

import UIKit
import SwiftyJSON
class GPWHomeNewsCell: UITableViewCell {
    weak var surperController:UIViewController?
    fileprivate var bankurl:String?
    fileprivate var scrollview:InvestScrollView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        let rightImgView = UIImageView(frame: CGRect(x: 16, y: 30, width: 42, height: 40))
        rightImgView.image = UIImage(named:"home_bottom_right")
        contentView.addSubview(rightImgView)

        let shuLine = UIView(frame: CGRect(x: rightImgView.maxX + 16, y: 24, width: 0.5, height: 54))
        shuLine.backgroundColor = UIColor.hex("d8d8d8")
        contentView.addSubview(shuLine)

        scrollview = InvestScrollView(frame: CGRect(x: shuLine.maxX + 6, y: 20, width: SCREEN_WIDTH - shuLine.maxX - 6 - 16, height: 62))
        let  gradientLayer = CAGradientLayer()
        gradientLayer.frame = scrollview.bounds
        //设置渐变的主颜色
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.hex("ffffff", alpha: 0.0).cgColor,UIColor.white.cgColor]
        //将gradientLayer作为子layer添加到主layer上
        scrollview.layer.addSublayer(gradientLayer)
        
        let  titileArray = [
            "<font size=14 color='#333333'>138****41212    钢融宝-第132期  </font><font size=14 color='#f6390c'>2000元</font>",
            "<font size=14 color='#333333'>138****43213    钢融宝-第142期  </font><font size=14 color='#f6390c'>2000元</font>",
            "<font size=14 color='#333333'>138****43411    钢融宝-第135期  </font><font size=14 color='#f6390c'>2002元</font>",
            "<font size=14 color='#333333'>138****43213    钢融宝-第122期  </font><font size=14 color='#f6390c'>2004元</font>",
            "<font size=14 color='#333333'>138****43413    钢融宝-第142期  </font><font size=14 color='#f6390c'>2030元</font>",
            "<font size=14 color='#333333'>138****43113    钢融宝-第112期  </font><font size=14 color='#f6390c'>2040元</font>",
            "<font size=14 color='#333333'>138****43243    钢融宝-第135期  </font><font size=14 color='#f6390c'>2010元</font>",
            "<font size=14 color='#333333'>138****43214    钢融宝-第136期  </font><font size=14 color='#f6390c'>2000元</font>",
            "<font size=14 color='#333333'>138****43213    钢融宝-第131期  </font><font size=14 color='#f6390c'>200元</font>",
            "<font size=14 color='#333333'>138****43212    钢融宝-第132期  </font><font size=14 color='#f6390c'>200元</font>",
            "<font size=14 color='#333333'>138****43214    钢融宝-第132期  </font><font size=14 color='#f6390c'>200元</font>",
            "<font size=14 color='#333333'>138****43213    钢融宝-第132期  </font><font size=14 color='#f6390c'>200元</font>",
            "<font size=14 color='#333333'>138****41212    钢融宝-第132期  </font><font size=14 color='#f6390c'>2000元</font>",
            "<font size=14 color='#333333'>138****43213    钢融宝-第142期  </font><font size=14 color='#f6390c'>2000元</font>",
            "<font size=14 color='#333333'>138****43411    钢融宝-第135期  </font><font size=14 color='#f6390c'>2002元</font>",
            "<font size=14 color='#333333'>138****43213    钢融宝-第122期  </font><font size=14 color='#f6390c'>2004元</font>",
            "<font size=14 color='#333333'>138****43413    钢融宝-第142期  </font><font size=14 color='#f6390c'>2030元</font>",
            "<font size=14 color='#333333'>138****43113    钢融宝-第112期  </font><font size=14 color='#f6390c'>2040元</font>",
            "<font size=14 color='#333333'>138****43243    钢融宝-第135期  </font><font size=14 color='#f6390c'>2010元</font>",
            "<font size=14 color='#333333'>138****43214    钢融宝-第136期  </font><font size=14 color='#f6390c'>2000元</font>",
            "<font size=14 color='#333333'>138****43213    钢融宝-第131期  </font><font size=14 color='#f6390c'>200元</font>",
            "<font size=14 color='#333333'>138****43212    钢融宝-第132期  </font><font size=14 color='#f6390c'>200元</font>",
            "<font size=14 color='#333333'>138****43214    钢融宝-第132期  </font><font size=14 color='#f6390c'>200元</font>",
            "<font size=14 color='#333333'>138****43213    钢融宝-第132期  </font><font size=14 color='#f6390c'>200元</font>"
        ]
        scrollview.investArray = titileArray
        contentView.addSubview(scrollview)

    }
    
    func updata(_ bankUrl:String)  {
        bankurl = bankUrl
    }
    
    func btnClick( _ sender:UITapGestureRecognizer) {
        if sender.view?.tag == 1001 {
            MobClick.event("home", label:"银行存管")
            surperController?.navigationController?.pushViewController(GPWHomeNewListController(), animated: true)
        }else{
            MobClick.event("home", label:"媒体列表")
            surperController?.navigationController?.pushViewController(GPWWebViewController(subtitle: "", url: self.bankurl!), animated: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
