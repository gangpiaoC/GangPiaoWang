//
//  GPWFoundViewController.swift
//  GangPiaoWang
//  发现
//  Created by gangpiaowang on 2017/8/9.
//  Copyright © 2017年 GC. All rights reserved.
//

import UIKit
import SwiftyJSON
class GPWFoundViewController: GPWBaseViewController,UITableViewDelegate,UITableViewDataSource {
    fileprivate var showTableView:UITableView!
    fileprivate var dataDic:JSON?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化界面
        initView()
    }
    
    func initView() {
        self.title = "发现"
        showTableView = UITableView(frame: self.bgView.bounds, style: .plain)
        showTableView.backgroundColor = UIColor.clear
        showTableView.showsVerticalScrollIndicator = false
        showTableView?.delegate = self
        showTableView?.dataSource = self
        showTableView.separatorStyle = .none
        showTableView.register(GPWFoundTopCell.self, forCellReuseIdentifier: "GPWFoundTopCell")
        showTableView.register(GPWFoundSecCell.self, forCellReuseIdentifier: "GPWFoundSecCell")
        showTableView.register(GPWFoundThreeCell.self, forCellReuseIdentifier: "GPWFoundThreeCell")
        showTableView.register(GPWFoundFourCell.self, forCellReuseIdentifier: "GPWFoundFourCell")
         showTableView.register(GPWFoundBottomCell.self, forCellReuseIdentifier: "GPWFoundBottomCell")
        
        self.bgView.addSubview(showTableView)
        requestNetData()
        showTableView.setUpHeaderRefresh { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.requestNetData()
        }
    }
    
    func requestNetData() {
        GPWNetwork.requetWithGet(url: Find, parameters: nil, responseJSON: {
            [weak self] (json, msg) in
            printLog(message: json)
            guard let strongSelf = self else { return }
            strongSelf.dataDic = json
            strongSelf.showTableView.reloadData()
            strongSelf.showTableView.endHeaderRefreshing()
        }) {[weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.showTableView.endHeaderRefreshing()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
extension GPWFoundViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataDic == nil {
            return 0
        }
        return 4 + (self.dataDic!["phone"].array?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return pixw(p: 138) + 32 + 10
        }else if indexPath.row == 1{
            return 89
        }else if indexPath.row < 2 + (self.dataDic!["phone"].array?.count ?? 0){
            return pixw(p: 122) + 10
        }else if indexPath.row == 2 + (self.dataDic!["phone"].array?.count ?? 0){
            return 106
        }else{
            return 18 + 15 + 18
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: GPWFoundTopCell = tableView.dequeueReusableCell(withIdentifier: "GPWFoundTopCell", for: indexPath) as! GPWFoundTopCell
            cell.showInfo(array: (self.dataDic?["banner"].array)!, control: self)
            return cell
        }else  if indexPath.row == 1{
            let cell: GPWFoundSecCell = tableView.dequeueReusableCell(withIdentifier: "GPWFoundSecCell", for: indexPath) as! GPWFoundSecCell
            cell.updata(weixin: (self.dataDic?["weixin"].stringValue)!, superControl: self)
            cell.superControl = self
            return cell
        }else if indexPath.row < 2 + (self.dataDic!["phone"].array?.count ?? 0){
            let cell: GPWFoundThreeCell = tableView.dequeueReusableCell(withIdentifier: "GPWFoundThreeCell", for: indexPath) as! GPWFoundThreeCell
            cell.updata(dic: (self.dataDic?["phone"][indexPath.row - 2])!, superControl: self)
            return cell
        }else if indexPath.row == 2 + (self.dataDic!["phone"].array?.count ?? 0) {
            let cell: GPWFoundFourCell = tableView.dequeueReusableCell(withIdentifier: "GPWFoundFourCell", for: indexPath) as! GPWFoundFourCell
            cell.superControl = self
            return cell
        }else{
            let cell: GPWFoundBottomCell = tableView.dequeueReusableCell(withIdentifier: "GPWFoundBottomCell", for: indexPath) as! GPWFoundBottomCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

