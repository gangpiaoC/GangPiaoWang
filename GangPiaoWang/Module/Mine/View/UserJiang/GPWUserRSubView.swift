//
//  GPWUserRSubView.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2016/12/21.
//  Copyright © 2016年 GC. All rights reserved.
//

import UIKit
import SwiftyJSON
class GPWUserRSubView: LazyScrollSubView,UITableViewDelegate,UITableViewDataSource {
    var showTableView:UITableView!
    var type:String!
    var dataArr = [JSON]()
    var page = 1
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        showTableView = UITableView(frame: self.bounds, style: .plain)
        showTableView.backgroundColor = UIColor.clear
        showTableView.separatorStyle = .none
        showTableView.height -= 40
        showTableView.setUpHeaderRefresh {
            [weak self] in
            guard let self1 = self else {return}
            self1.page = 1
            self1.getNetData()
        }
        
        showTableView.setUpFooterRefresh {
            [weak self] in
            guard let self1 = self else {return}
            self1.getNetData()
        }
        showTableView?.delegate = self
        showTableView?.dataSource = self
        self.addSubview(showTableView)
    }
    
    func getNetData() {
        GPWNetwork.requetWithPost(url: type, parameters: ["page":self.page], responseJSON:  {
            [weak self] (json, msg) in
            printLog(message: json)
            guard let strongSelf = self else { return }
            strongSelf.showTableView.endFooterRefreshing()
            strongSelf.showTableView.endHeaderRefreshing()
            if strongSelf.page == 1 {
                strongSelf.dataArr = json.array!
                if (json.arrayObject?.count)! > 0 {
                    strongSelf.showTableView.footerRefresh.isHidden = false
                    strongSelf.page += 1
                    (self?.inCtl as! GPWSecBaseViewController).noDataImgView.isHidden = true
                }else{
                   (self?.inCtl as! GPWSecBaseViewController).noDataImgView.isHidden = false
                    strongSelf.showTableView.setFooterNoMoreData()
                }
            }else{
                if (json.arrayObject?.count)! > 0 {
                    strongSelf.page += 1
                    strongSelf.dataArr = strongSelf.dataArr + json.array!
                }else{
                    strongSelf.showTableView.endFooterRefreshingWithNoMoreData()
                }
            }
            strongSelf.showTableView.reloadData()
            }, failure: { [weak self] error in
                guard let strongSelf = self else { return }
                  printLog(message: error)
                strongSelf.showTableView.endFooterRefreshing()
                strongSelf.showTableView.endHeaderRefreshing()
        })
    }

    
    override func reloadData(withDict dict: [AnyHashable : Any]!) {
        
        if type == nil {
            type = dict["type"] as! String
           self.getNetData()
            showTableView.reloadData()
        }
        MobClick.event("mine_reward", label: dict["title"] as! String)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        printLog(message: type)
         if type == nil {
            return 0
        }else{
            return self.dataArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == Useraccounts_myred || type == User_experient{
            return 120 + 16
        }
        return 116
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == Useraccounts_myred {
            var cell = tableView.dequeueReusableCell(withIdentifier: "GPWUserRBCell") as? GPWUserRBCell
            if cell == nil {
                cell = GPWUserRBCell(style: .default, reuseIdentifier: "GPWUserRBCell")
            }
            cell?.setInfo(dic: self.dataArr[indexPath.row],superC:self.inCtl)
            return cell!
        }else if type == User_experient {
            var cell = tableView.dequeueReusableCell(withIdentifier: "GPWUserExpCell") as? GPWUserExpCell
            if cell == nil {
                cell = GPWUserExpCell(style: .default, reuseIdentifier: "GPWUserExpCell")
            }
            cell?.setInfo(dic: self.dataArr[indexPath.row],superC:self.inCtl)
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "GPWUserRCell") as? GPWUserRCell
            if cell == nil {
                cell = GPWUserRCell(style: .default, reuseIdentifier: "GPWUserRCell")
            }
            cell?.setInfo(dic: self.dataArr[indexPath.row],superC:self.inCtl)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}