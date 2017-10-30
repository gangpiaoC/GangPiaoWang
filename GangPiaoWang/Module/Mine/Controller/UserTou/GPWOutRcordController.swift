//
//  GPWOutRcordController.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2016/12/23.
//  Copyright © 2016年 GC. All rights reserved.
//

import UIKit
class GPWOutRcordController: GPWSecBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var page = 1
    var dataArray:[Any]!
    var showTableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        page = 1
        dataArray = Array()
        self.title = "出借记录"
        
        showTableView = UITableView(frame: self.bgView.bounds, style: .plain)
        showTableView.separatorStyle = .none
        showTableView.backgroundColor = UIColor.clear
        showTableView.setUpFooterRefresh {
            [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.getNetData()
        }
        showTableView.setUpHeaderRefresh {
            [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.page = 1
            strongSelf.getNetData()
        }
        showTableView.delegate = self
        showTableView.dataSource = self
        showTableView.backgroundColor = UIColor.clear
        self.bgView.addSubview(showTableView)
        
        //设置顶部信息
        self.initTopView()
        
        self.getNetData()
    }
    //顶部视图
    func initTopView()  {
        //设置背景
        let  bgLayer = CALayer()
        bgLayer.contents = UIImage(named: "user_record_topView")?.cgImage
        bgLayer.anchorPoint = CGPoint(x: 0, y: 0)
        bgLayer.bounds = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 168)
        bgLayer.zPosition = -1
        showTableView.layer.addSublayer(bgLayer)
    }
    
    func getNetData() {
        GPWNetwork.requetWithGet(url: Invest_record, parameters: ["page":"\(page)"], responseJSON:  {
            [weak self] (json,msg) in
            printLog(message: json)
            guard let strongSelf = self else { return }
            strongSelf.showTableView.endFooterRefreshing()
            strongSelf.showTableView.endHeaderRefreshing()
            if strongSelf.page == 1 {
                strongSelf.dataArray = json.arrayObject
                if strongSelf.dataArray.count == 0 {
                     strongSelf.showTableView.setFooterNoMoreData()
                    strongSelf.noDataImgView.isHidden = false
                }else{
                    strongSelf.noDataImgView.isHidden = true
                    strongSelf.showTableView.footerRefresh.isHidden = false
                    strongSelf.page += 1
                }
            }else{
                strongSelf.showTableView.footerRefresh.isHidden = false
                if (json.arrayObject?.count)! > 0 {
                    strongSelf.page += 1
                    strongSelf.dataArray = strongSelf.dataArray + json.arrayObject!
                }else{
                     strongSelf.showTableView.endFooterRefreshingWithNoMoreData()
                }
            }
            printLog(message: strongSelf.dataArray)
            strongSelf.showTableView.reloadData()
            }, failure: { [weak self] error in
                guard let strongSelf = self else { return }
                strongSelf.showTableView.endFooterRefreshing()
                strongSelf.showTableView.endHeaderRefreshing()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dataArray.count as Int + 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 115
        }
        return 146 + 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "recordtopCell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "recordtopCell")
                cell?.backgroundColor = UIColor.clear
                let  array = [
                    ["title":"待收本金(元)","money": GPWUser.sharedInstance().capital],
                    ["title":"待收利息(元)","money": GPWUser.sharedInstance().wait_accrual]
                ]
                for i in  0 ..< array.count {
                    let titleLabel = UILabel(frame: CGRect(x:  SCREEN_WIDTH / 2  *  CGFloat(i), y: 38, width: SCREEN_WIDTH / 2, height: 22))
                    titleLabel.text = array[i]["title"] ?? ""
                    titleLabel.textAlignment = .center
                    titleLabel.font = UIFont.customFont(ofSize: 16)
                    titleLabel.textColor = UIColor.white
                    cell?.contentView.addSubview(titleLabel)
                    
                    let moneyLabel = UILabel(frame: CGRect(x:  titleLabel.x, y: titleLabel.maxY + 1, width: SCREEN_WIDTH / 2, height: 22))
                    moneyLabel.text = array[i]["money"] ?? ""
                    moneyLabel.textAlignment = .center
                    moneyLabel.font = UIFont.customFont(ofSize: 20)
                    moneyLabel.textColor = UIColor.white
                     cell?.contentView.addSubview(moneyLabel)
                    if i == 0 {
                        let line = UIView(frame: CGRect(x: SCREEN_WIDTH / 2 - 0.5, y: 48, width: 1, height: 25))
                        line.backgroundColor = UIColor.white
                         cell?.contentView.addSubview(line)
                    }
                }
                cell?.selectionStyle = .none
            }
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "GPWOutRcordCell") as? GPWOutRcordCell
            if cell == nil {
                cell = GPWOutRcordCell(style: .default, reuseIdentifier: "GPWOutRcordCell")
            }
            cell?.updata(dic: self.dataArray[indexPath.row - 1] as! [String:Any])
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        let dic = self.dataArray![indexPath.row - 1] as! [String:Any]
        let rcorID = dic["newauto_id"] as! Int
        let detailVC = GPWOutRcordDetailController()
        detailVC.rcordID =  "\(rcorID)"
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}
