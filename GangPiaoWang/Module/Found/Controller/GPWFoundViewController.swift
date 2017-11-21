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

        self.addkefuButton()
        showTableView = UITableView(frame: self.bgView.bounds, style: .plain)
        showTableView.backgroundColor = UIColor.clear
        showTableView.showsVerticalScrollIndicator = false
        showTableView?.delegate = self
        showTableView?.dataSource = self
        showTableView.separatorStyle = .none
        showTableView.register(GPWFoundTopCell.self, forCellReuseIdentifier: "GPWFoundTopCell")
        showTableView.register(GPWFoundSecCell.self, forCellReuseIdentifier: "GPWFoundSecCell")
        showTableView.register(GPWFNewsTopCell.self, forCellReuseIdentifier: "GPWFNewsTopCell")
        showTableView.register(GPWHomeNewListCell.self, forCellReuseIdentifier: "GPWHomeNewListCell")
        self.bgView.addSubview(showTableView)
        requestNetData()
        showTableView.setUpHeaderRefresh { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.requestNetData()
        }
    }
    private func addkefuButton() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: SCREEN_WIDTH  - 40 - 6, y: 23, width: 40, height: 40)
        button.setImage(UIImage(named: "found_top_kefu"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(kefuClick), for: .touchUpInside)
        navigationBar.addSubview(button)
    }

    @objc private func kefuClick() {
            self.myCustem()
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
        ZCSobot.startZCChatView(uiInfo, with: self.navigationController, pageBlock: { (object, type) in

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
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return pixw(p: 138) + 12 + 10
        }else if indexPath.row == 1{
            return 93 + 10
        }else if indexPath.row == 2{
            return  44
        }else{
            return 120
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
        }else if indexPath.row == 2{
            let cell: GPWFNewsTopCell = tableView.dequeueReusableCell(withIdentifier: "GPWFNewsTopCell", for: indexPath) as! GPWFNewsTopCell
            return cell
        }else{
            let cell: GPWHomeNewListCell = tableView.dequeueReusableCell(withIdentifier: "GPWHomeNewListCell", for: indexPath) as! GPWHomeNewListCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

