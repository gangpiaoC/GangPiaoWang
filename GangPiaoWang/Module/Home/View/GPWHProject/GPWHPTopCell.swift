//
//  GPWHPTopCell.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2017/11/13.
//  Copyright © 2017年 GC. All rights reserved.
//

import UIKit
import SwiftyJSON
class GPWHPTopCell: UITableViewCell {

    fileprivate let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        //view.layer.masksToBounds = true
        view.layer.cornerRadius =  6
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        return view
    }()


    fileprivate let topImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named:"home_project_top")
        return imgView
    }()

    //新手标   体验标  钢融宝-第几期等
    fileprivate let topTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "钢票盈-第13期"
        titleLabel.textColor = redTitleColor
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.customFont(ofSize: 16.0)
        return titleLabel
    }()

    fileprivate let leftImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.blue
        //imgView.image = UIImage(named:"home_project_top")
        return imgView
    }()

    fileprivate let rightTtileLabel: UILabel = {
        let companyLabel = UILabel()
        companyLabel.text = "中建二局"
        companyLabel.textColor = UIColor.hex("f6390c")
        companyLabel.textAlignment = .center
        companyLabel.layer.masksToBounds = true
        companyLabel.layer.cornerRadius = 10
        companyLabel.layer.borderColor = UIColor.hex("ef785b").cgColor
        companyLabel.layer.borderWidth = 0.5
        companyLabel.font = UIFont.customFont(ofSize: 14.0)
        return companyLabel
    }()

    //利率
    private let rateLabel: RTLabel = {
        let label = RTLabel()
        label.text = "<font size=50 color='#f6390c'>7.0</font><font size=22 color='#f6390c'>%</font><font size=32 color='#f6390c'> + </font><font size=28 color='#f6390c'>3.0</font><font size=24 color='#f6390c'>%</font>"
        label.textAlignment = RTTextAlignmentCenter
        printLog(message: label.optimumSize.height)
        return label
    }()

    //剩余金额+ 项目期限
    private let bottomLabel: RTLabel = {
        let label = RTLabel()
        label.text = "<font size=14 color='#666666'>剩余 260,000元        项目期限30天</font>"
        label.textAlignment = RTTextAlignmentCenter
        printLog(message: label.optimumSize.height)
        return label
    }()

    //抢购
    fileprivate let bottomImgBtn: UIButton = {
        let tempBtn = UIButton()
        tempBtn.setImage(UIImage(named:"home_project_pay"), for: .normal)
        return tempBtn
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        commonInitialize()
    }

    private func commonInitialize() {

        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (maker) in
            maker.left.equalTo(contentView).offset(16)
            maker.top.equalTo(contentView).offset(6)
            maker.bottom.equalTo(contentView).offset(-6)
            maker.right.equalTo(contentView).offset(-16)
        }

        contentView.addSubview(topImgView)
        topImgView.snp.makeConstraints { (maker) in
            maker.top.equalTo(contentView).offset(4)
            maker.centerX.equalTo(contentView)
        }
        contentView.addSubview(topTitleLabel)
        topTitleLabel.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalTo(topImgView)
        }

        contentView.addSubview(leftImgView)
        leftImgView.snp.makeConstraints { (maker) in
            maker.top.equalTo(bgView).offset(44)
            maker.width.equalTo(84)
            maker.height.equalTo(20)
            maker.right.equalTo(contentView).offset(-SCREEN_WIDTH / 2 - 5)
        }

        contentView.addSubview(rightTtileLabel)
        rightTtileLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(bgView).offset(44)
            maker.width.equalTo(84)
            maker.height.equalTo(20)
            maker.left.equalTo(contentView).offset(SCREEN_WIDTH / 2 + 5)
        }
        contentView.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(bgView)
            maker.top.equalTo(rightTtileLabel.snp.bottom).offset(20)
            maker.height.equalTo(61)
        }

        contentView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(bgView)
            maker.top.equalTo(rateLabel.snp.bottom).offset(13)
            maker.height.equalTo(20)
        }

        contentView.addSubview(bottomImgBtn)
        bottomImgBtn.snp.makeConstraints { (maker) in
            maker.left.equalTo(bgView).offset(44)
            maker.right.equalTo(bgView).offset(-44)
            maker.height.equalTo(40)
            maker.bottom.equalTo(bgView).offset(-25)
        }
    }
    func setupCell(dict: JSON,index:NSInteger) {
    }
    func getWith(str:String,font:UIFont) -> CGFloat{
        let options:NSStringDrawingOptions = .usesLineFragmentOrigin
        let boundingRect = str.boundingRect(with:  CGSize(width: 300, height: 22), options: options, attributes:[NSFontAttributeName:font], context: nil)
        return boundingRect.width
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
