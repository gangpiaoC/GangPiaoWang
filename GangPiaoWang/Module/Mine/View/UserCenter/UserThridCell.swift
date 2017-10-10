//
//  UserThridCell.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2017/6/8.
//  Copyright © 2017年 GC. All rights reserved.
//

import UIKit

class UserThridCell: UITableViewCell {
    fileprivate var superControl:UserController?
    fileprivate var dicArray:[[String:String]]?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        //横线
        let verLine = UIView(frame: CGRect(x: SCREEN_WIDTH / 2, y: 29, width: 0.5, height: 189 - 29 * 2))
        verLine.backgroundColor = lineColor
        contentView.addSubview(verLine)
        
        //竖线
        let horLine = UIView(frame: CGRect(x: 16, y: 189 / 2, width: SCREEN_WIDTH - 16 * 2, height: 0.5))
        horLine.backgroundColor = lineColor
        contentView.addSubview(horLine)
    }
    
    func updata(_ dicArray:[[String:String]],superControl:UserController) {
        self.superControl = superControl
        for subview in contentView.subviews {
            if subview.tag >= 1000 {
                subview.removeFromSuperview()
            }
        }
        
        for i in 0 ..< 2 {
            for j in 0 ..< 2 {
                let  btn = UIButton(type: .custom)
                btn.frame = CGRect(x: SCREEN_WIDTH / 2 * CGFloat(j), y: 189 / 2 * CGFloat(i), width: SCREEN_WIDTH / 2, height: 189 / 2)
                btn.tag = 1000 + i * 2 + j
                btn.setTitle(dicArray[i * 2 + j]["title"]!, for: .normal)
                btn.setTitleColor(UIColor.clear, for: .normal)
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                btn.backgroundColor = UIColor.clear
                contentView.addSubview(btn)
                
                let  tiImgView = UIImageView(frame: CGRect(x: 16, y: 24, width: 26, height: 26))
                tiImgView.image = UIImage(named: dicArray[i * 2 + j]["img"]!)
                btn.addSubview(tiImgView)
                
                let titleLabel = UILabel(frame: CGRect(x: tiImgView.maxX + 10, y: tiImgView.y + 3, width: btn.width - 16 - tiImgView.maxX - 10, height: 17))
                titleLabel.text = dicArray[i * 2 + j]["title"]!
                titleLabel.font = UIFont.systemFont(ofSize: 16)
                titleLabel.textColor = UIColor.hex("333333")
                btn.addSubview(titleLabel)
                
                let detailLabel = UILabel(frame: CGRect(x: titleLabel.x, y: titleLabel.maxY + 11, width: titleLabel.width , height: 15))
                detailLabel.text = dicArray[i * 2 + j]["detail"]!
                detailLabel.font = UIFont.systemFont(ofSize: 14)
                detailLabel.textColor = UIColor.hex("999999")
                btn.addSubview(detailLabel)
            }
        }
    }
    func btnClick(_ sender:UIButton) {
        switch sender.tag {
        case 1000:
            //投资记录
            MobClick.event("mine", label: "出借记录")
            self.superControl?.navigationController?.pushViewController(GPWOutRcordController(), animated: true)
             break
        case 1001:
            //优惠券
            MobClick.event("mine", label: "优惠券")
            self.superControl?.navigationController?.pushViewController(UserRewardViewController(), animated: true)
            break
        case 1002:
            //资金流水
            MobClick.event("mine", label: "资金流水")
            self.superControl?.navigationController?.pushViewController(GPWUserMoneyToViewController(), animated: true)
            break
        case 1003:
            
            if sender.title(for: .normal) == "风险测评" {
                //风险测评
                MobClick.event("mine", label: "分享测评")
                self.superControl?.navigationController?.pushViewController(GPWRiskAssessmentViewController(), animated: true)
            }else{
                //邀请奖励
                MobClick.event("mine", label: "邀请奖励")
                self.superControl?.navigationController?.pushViewController(GPWGetFriendRcordController(), animated: true)
            }
            break
        default:
            printLog(message: "不知道是啥")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}