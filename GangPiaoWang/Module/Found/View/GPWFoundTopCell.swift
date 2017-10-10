//
//  GPWFoundTopCell.swift
//  GangPiaoWang
//
//  Created by gangpiaowang on 2017/8/9.
//  Copyright © 2017年 GC. All rights reserved.
//
//NewPagedFlowViewDelegate,NewPagedFlowViewDataSource
import UIKit
import SwiftyJSON
class GPWFoundTopCell: UITableViewCell,EScrollerViewDelegate {
    //fileprivate var pageFlowView:NewPagedFlowView!
     var linshiImgUrl = "https://picture.gangpiaowang.com/cc733371e4299852eaad62bd90eab419.jpg"
    var _scrollView:EScrollerView?
    var _data:[JSON]?
    var _indexControl:UIViewController?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.reloadData()
    }
    
    func showInfo(array:[JSON],control:UIViewController) {
        _indexControl = control
        _data = array
        self.reloadData()
    }
    
    func reloadData() {
        if  _data?.count == 0 || _data == nil {
            return
        }
        _scrollView?.removeFromSuperview()
        _scrollView = EScrollerView(frame: CGRect(x: 16, y: 16, width: SCREEN_WIDTH - 32, height: pixw(p: 138)), pageCount: (_data?.count)!, delegate: self)
        self.contentView.addSubview(_scrollView!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GPWFoundTopCell {
    func eScrollerInitView(for index: UInt) -> UIView! {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: pixw(p: 138)))
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 6
        if (_data?.count)! > 0 {
            let dic = self._data![Int(index)]
            imgView.downLoadImg(imgUrl: dic["img_url"].stringValue)
        }else{
            imgView.downLoadImg(imgUrl: linshiImgUrl)
        }
        return imgView
    }
    func eScrollerViewDidClicked(_ index: UInt) {
        printLog(message: "滑动中,点击去哪里？")
        let dic = self._data![Int(index)]
        MobClick.event("found", label:  "banner-第\(index)个")
        let url = dic["link"].string ?? ""
        if (url.range(of: "https")) != nil{
            if(url.characters.count) > 6 {
                _indexControl?.navigationController?.pushViewController(GPWWebViewController(dic: dic), animated: true)
            }
        }else{
            _ = GPWHelper.selectedNavController()?.pushViewController(GPWProjectDetailViewController(projectID: url), animated: true)
        }
    }
//    func sizeForPage(in flowView: NewPagedFlowView!) -> CGSize {
//        return CGSize(width: SCREEN_WIDTH - 32, height: flowView.height)
//    }
//    
//    func didSelectCell(_ subView: UIView!, withSubViewIndex subIndex: Int) {
//        printLog(message: "点击了第\(subIndex + 1)张图")
//    }
//    
//    func numberOfPages(in flowView: NewPagedFlowView!) -> Int {
//        return self.imgArray.count
//    }
//    
//    func flowView(_ flowView: NewPagedFlowView!, cellForPageAt index: Int) -> UIView! {
//        var bannerView = flowView.dequeueReusableCell() as? PGIndexBannerSubiew
//        if bannerView == nil {
//            bannerView = PGIndexBannerSubiew(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 32, height: flowView.height))
//            bannerView?.tag = index
//            bannerView?.layer.cornerRadius = 6
//            bannerView?.layer.masksToBounds = true
//            bannerView?.mainImageView.downLoadImg(imgUrl: self.imgArray[index], placeImg: "")
//        }
//        return bannerView
//    }
}
