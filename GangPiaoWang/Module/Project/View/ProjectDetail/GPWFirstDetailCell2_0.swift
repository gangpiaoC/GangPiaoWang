//
//  GPWFirstDetailCell2_0.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2017/7/5.
//  Copyright © 2017年 GC. All rights reserved.
//

import UIKit
import SnapKit
class GPWFirstDetailCell2_0: UITableViewCell {
    
    //开始加入时间
    private let joinTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(ofSize: 12)
        label.textColor = subTitleColor
        label.text = ""
        return label
    }()
    
    //开始计息
    private let lvTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(ofSize: 12)
        label.textColor = subTitleColor
        label.text = ""
        return label
    }()
    
    //开始计息时间
    private let dayTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(ofSize: 12)
        label.textColor = subTitleColor
        label.text = ""
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initView(){
        contentView.addSubview(joinTimeLabel)
        contentView.addSubview(lvTimeLabel)
        contentView.addSubview(dayTimeLabel)
       
        //开始加入
        let temp1Label: UILabel = {
            let label = UILabel()
            label.font = UIFont.customFont(ofSize: 14)
            label.textColor = subTitleColor
            label.text = "开始加入"
            return label
        }()
        contentView.addSubview(temp1Label)
        temp1Label.snp.makeConstraints { (maker) in
            maker.top.equalTo(16)
            maker.left.equalTo(25)
        }
        
        let dian1ImgView:UIImageView = {
           let  tempImgView = UIImageView()
            tempImgView.image = UIImage(named: "project_detail_dian")
            return tempImgView
        }()
        contentView.addSubview(dian1ImgView)
        dian1ImgView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(temp1Label)
            maker.top.equalTo(temp1Label.snp.bottom).offset(4)
        }
        
        joinTimeLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(dian1ImgView.snp.bottom).offset(10)
            maker.centerX.equalTo(dian1ImgView.snp.centerX)
        }
        
        //开始计息
        let temp2Label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.customFont(ofSize: 14)
            label.textColor = subTitleColor
            label.text = "开始计息"
            return label
        }()
        contentView.addSubview(temp2Label)
        temp2Label.snp.makeConstraints { (maker) in
            maker.top.equalTo(temp1Label)
            maker.centerX.equalTo(contentView)
        }
        let dian2ImgView:UIImageView = {
            let  tempImgView = UIImageView()
            tempImgView.image = UIImage(named: "project_detail_dian")
            return tempImgView
        }()
        contentView.addSubview(dian2ImgView)
        dian2ImgView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(temp2Label)
            maker.top.equalTo(dian1ImgView)
        }
        
        //线
        let line1View: UIView = {
            let label = UIView()
            label.backgroundColor = UIColor.hex("feeaa4")
            return label
        }()
        contentView.addSubview(line1View)
        line1View.snp.makeConstraints { (maker) in
            maker.left.equalTo(dian1ImgView.snp.right)
            maker.centerY.equalTo(dian1ImgView)
            maker.right.equalTo(dian2ImgView.snp.left)
            maker.height.equalTo(2)
        }
        
        //利息补贴
        let zhangLvLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.customFont(ofSize: 12)
            label.textColor = UIColor.hex("ffb700")
            label.text = "利息补贴"
            return label
        }()
        contentView.addSubview(zhangLvLabel)
        zhangLvLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(temp1Label)
            maker.centerX.equalTo(line1View)
        }
        
        lvTimeLabel.snp.makeConstraints { (maker) in
            maker.top.centerY.bottom.equalTo(joinTimeLabel)
            maker.centerX.equalTo(dian2ImgView)
        }
        
        
        //到期退出
        let temp3Label: UILabel = {
            let label = UILabel()
            label.textAlignment = .right
            label.font = UIFont.customFont(ofSize: 14)
            label.textColor = subTitleColor
            label.text = "到期退出"
            return label
        }()
        contentView.addSubview(temp3Label)
        temp3Label.snp.makeConstraints { (maker) in
            maker.top.equalTo(temp1Label)
            maker.right.equalTo(contentView).offset(-25)
        }

        let dian3ImgView:UIImageView = {
            let  tempImgView = UIImageView()
            tempImgView.image = UIImage(named: "project_detail_dian")
            return tempImgView
        }()
        contentView.addSubview(dian3ImgView)
        dian3ImgView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(temp3Label)
            maker.top.equalTo(dian2ImgView)
        }
        
        //线
        let line2View: UIView = {
            let label = UIView()
            label.backgroundColor = UIColor.hex("feeaa4")
            return label
        }()
        contentView.addSubview(line2View)
        line2View.snp.makeConstraints { (maker) in
            maker.left.equalTo(dian2ImgView.snp.right)
            maker.centerY.equalTo(dian1ImgView)
            maker.right.equalTo(dian3ImgView.snp.left)
            maker.height.equalTo(2)
        }
        
        dayTimeLabel.snp.makeConstraints { (maker) in
            maker.top.centerY.bottom.equalTo(joinTimeLabel)
            maker.centerX.equalTo(dian3ImgView)
        }
        
        let placeholderView = UIView()
        placeholderView.backgroundColor = bgColor
        contentView.addSubview(placeholderView)
        placeholderView.snp.makeConstraints { (maker) in
            maker.top.equalTo(dayTimeLabel.snp.bottom).offset(21)
            maker.left.right.equalTo(contentView)
            maker.height.equalTo(8)
            maker.bottom.equalTo(contentView)
        }
    }
    func updata( _ jointime:String, _ rateModel:String,_ dayNum:String)  {
        joinTimeLabel.text = jointime
        lvTimeLabel.text = rateModel
        dayTimeLabel.text = dayNum
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
