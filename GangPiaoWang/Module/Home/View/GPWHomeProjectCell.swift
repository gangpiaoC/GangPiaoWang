//
//  GPWHomeProjectCell.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2017/3/21.
//  Copyright © 2017年 GC. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class GPWHomeProjectCell: UITableViewCell {
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hex("efefef")
        return view
    }()
    fileprivate let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = lineColor
        return view
    }()
    fileprivate let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "钢票盈-第13期"
        titleLabel.textColor = UIColor.hex("666666")
        titleLabel.font = UIFont.customFont(ofSize: 16.0)
        return titleLabel
    }()
    
    fileprivate let  typeLabel: UILabel = {
        let companyLabel = UILabel()
        companyLabel.text = "新手专享"
        companyLabel.textColor = UIColor.hex("f6390c")
        companyLabel.textAlignment = .center
        companyLabel.layer.masksToBounds = true
        companyLabel.layer.cornerRadius = 3
        companyLabel.layer.borderColor = UIColor.hex("ef785b").cgColor
        companyLabel.layer.borderWidth = 0.5
        companyLabel.font = UIFont.customFont(ofSize: 14.0)
        companyLabel.backgroundColor = UIColor.hex("fef6f1")
        return companyLabel
    }()

    
    //利率
    private let rateLabe: RTLabel = {
        let label = RTLabel()
        return label
    }()
    
    private let staticIncomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("9e9e9e")
        label.text = "年化利率"
        label.font = UIFont.customFont(ofSize: 14.0)
        return label
    }()
    
  
    private let staticDateLabel: UILabel = {
        let label = UILabel()
        label.text = "借款期限35天"
        label.textColor = subTitleColor
        label.font = UIFont.customFont(ofSize: 16.0)
        return label
    }()
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hex("999999")
        label.font = UIFont.customFont(ofSize: 14.0)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        commonInitialize()
    }
    
    private func commonInitialize() {
        contentView.addSubview(topView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(rateLabe)
        contentView.addSubview(staticIncomeLabel)
        contentView.addSubview(staticDateLabel)
        contentView.addSubview(companyLabel)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(16)
            maker.left.equalTo(contentView).offset(16)
        }
        
        typeLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(titleLabel.snp.right).offset(6)
            maker.height.equalTo(18)
            maker.centerY.equalTo(titleLabel)
        }
        
        rateLabe.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(16)
            maker.left.equalTo(contentView).offset(16)
            maker.width.equalTo(SCREEN_WIDTH / 2)
            maker.height.equalTo(47)
        }
        
        staticIncomeLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(rateLabe)
            maker.top.equalTo(rateLabe.snp.bottom).offset(4)
        }
        
        staticDateLabel.snp.makeConstraints { maker in
            maker.left.equalTo(SCREEN_WIDTH / 2 + 18)
            maker.centerY.equalTo(rateLabe)
        }
    
        companyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(staticIncomeLabel)
            make.left.equalTo(staticDateLabel)
        }
        
        let  line:UIView = {
            let line = UIView()
            line.backgroundColor = UIColor.hex("e6e6e6")
            return line
        }()
        contentView.addSubview(line)
        
        line.snp.makeConstraints { (maker) in
            maker.top.equalTo(staticDateLabel)
            maker.width.equalTo(0.5)
            maker.bottom.equalTo(companyLabel)
            maker.centerX.equalTo(SCREEN_WIDTH / 2)
        }
        
        topView.snp.makeConstraints { (maker) in
            maker.left.equalTo(contentView).offset(16)
            maker.height.equalTo(0.5)
            maker.right.equalTo(contentView)
            maker.top.equalTo(contentView.snp.bottom).offset(-0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell(dict: JSON,index:NSInteger) {
        staticDateLabel.text = dict["deadlinezi"].stringValue
        titleLabel.text = dict["title"].stringValue
        companyLabel.text = dict["acceptance_enterprise"].string ?? "0"
        rateLabe.text = "<font size=36 color='#f6390c'>\(dict["rate_loaner"])</font><font size=20 color='#f6390c'>%</font>"
        if dict["type"].string == "TIYAN" {
            typeLabel.text = "10点准时开抢"
             rateLabe.text = "<font size=22 color='#f6390c'>￥</font><font size=32 color='#f6390c'>\(dict["amount"])</font>"
        }else if dict["is_index"].intValue == 1 {
            if GPWUser.sharedInstance().staue == 0 {
                typeLabel.text = "新手专享"
                rateLabe.text = "<font size=36 color='#f6390c'>\(dict["rate_loaner"])</font><font size=20 color='#f6390c'>%</font>"
                if dict["rate_new"].doubleValue > 0 {
                   rateLabe.text = "<font size=36 color='#f6390c'>\(dict["rate_loaner"])</font><font size=20 color='#f6390c'>%</font><font size=24 color='#f6390c'>+</font><font size=24 color='#f6390c'>\(dict["rate_new"])</font><font size=20 color='#f6390c'>%</font>"
                }
            }else {
                typeLabel.text = "稳健收益"
            }
        }else{
            typeLabel.text = "稳健收益"
        }
        let typeLabelWidth = self.getWith(str: typeLabel.text ?? "", font: typeLabel.font)
        typeLabel.snp.remakeConstraints({ (maker) in
            maker.left.equalTo(titleLabel.snp.right).offset(6)
            maker.height.equalTo(18)
            maker.width.equalTo(typeLabelWidth + 10)
            maker.centerY.equalTo(titleLabel)
        })
    }
    func getWith(str:String,font:UIFont) -> CGFloat{
        let options:NSStringDrawingOptions = .usesLineFragmentOrigin
        let boundingRect = str.boundingRect(with:  CGSize(width: 300, height: 22), options: options, attributes:[NSFontAttributeName:font], context: nil)
        return boundingRect.width
    }
}
