//
//  GPWUserRegisterViewController.swift
//  GangPiaoWang
//  注册
//  Created by gangpiaowang on 2016/12/19.
//  Copyright © 2016年 GC. All rights reserved.
//

import UIKit

class GPWUserRegisterViewController: GPWSecBaseViewController,RTLabelDelegate {

    //获取验证码
    var numRtlabel:RTLabel!
    var num:Int?
    //下一步
    var nextBtn:UIButton!
    //手机号是否注册过
    var flag = false
    //是否已经阅读过协议
    var readFlag = true
    //短信验证码
    var duanCode:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        self.bgView.backgroundColor = UIColor.white
        let array = [
            ["img":"user_login_phone","place":"请输入手机号"],    ["img":"user_login_pw","place":"请输入验证码"]
        ]
        var maxheight:CGFloat = 0
        for i in 0 ..< array.count {
            
            let imgView = UIImageView(frame: CGRect(x: 16, y: maxheight + 21, width: 18, height: 21))
            imgView.image = UIImage(named: array[i]["img"]!)
            self.bgView.addSubview(imgView)
            
            let  textField = UITextField(frame: CGRect(x: imgView.maxX + 14, y: imgView.y, width: 200, height: imgView.height))
            textField.placeholder = array[i]["place"]
            textField.tag = 100 + i
            textField.keyboardType = .numberPad
            textField.font = UIFont.customFont(ofSize: 16)
            self.bgView.addSubview(textField)
            
            if i == 1 {
                textField.width = SCREEN_WIDTH / 2
                numRtlabel = RTLabel(frame: CGRect(x: SCREEN_WIDTH - 100 - 16, y: 0, width: 100, height: 0))
                numRtlabel.text = "<a href='huoquyanzheng'><font size=16 color='#f6390d'>获取验证码</font></a>"
                numRtlabel.delegate = self
                numRtlabel.textAlignment = RTTextAlignmentRight
                numRtlabel.height = numRtlabel.optimumSize.height
                numRtlabel.centerY = textField.centerY
                self.bgView.addSubview(numRtlabel)
                
                let line = UIView(frame: CGRect(x: numRtlabel.x, y: maxheight + 22, width: 1, height: 20))
                line.backgroundColor = lineColor
                self.bgView.addSubview(line)
                
            }
            maxheight = textField.maxY + 10
            
            let line = UIView(frame: CGRect(x: imgView.x, y: maxheight, width: SCREEN_WIDTH - imgView.x * 2, height: 0.5))
            line.backgroundColor = lineColor
            self.bgView.addSubview(line)
            maxheight = line.maxY
        }
        
        maxheight += 45
        
        let selectBtn = UIButton(type: .custom)
        selectBtn.frame = CGRect(x: 81, y: maxheight, width: 25, height: 25)
        selectBtn.tag = 1000
        selectBtn.addTarget(self, action: #selector(self.btnSelectedClick(sender:)), for: .touchUpInside)
        selectBtn.setImage(UIImage(named: "user_regiter_selected"), for: .normal)
        self.bgView.addSubview(selectBtn)
        
        let label = RTLabel(frame: CGRect(x: selectBtn.maxX + 10 , y: selectBtn.y, width: 300, height: 12))
        label.text = "<font size=14 color='#999999'>我已阅读并同意</font><a href='gotoxieyi'><font size=14 color='#00affe'>《钢票网用户注册协议》</font></a>"
        label.delegate = self
        label.size = label.optimumSize
        label.centerY = selectBtn.centerY
        label.centerX = SCREEN_WIDTH / 2 - 10
        selectBtn.x = label.x - 5 - 20
        self.bgView.addSubview(label)
        
        maxheight = label.maxY + 16
        
        nextBtn = UIButton(type: .custom)
        nextBtn.frame = CGRect(x: 10, y: maxheight, width: SCREEN_WIDTH - 10 * 2, height: 64)
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
        nextBtn.setBackgroundImage(UIImage(named: "btn_bg"), for: .normal)
        self.bgView.addSubview(nextBtn)
        maxheight = nextBtn.maxY + 24
        
        //登录
        let loginBtn = UIButton(frame: CGRect(x: 0, y:  nextBtn.maxY + 8, width:  SCREEN_WIDTH, height: 20))
        loginBtn.tag = 100
        loginBtn.addTarget(self, action: #selector(self.loginClick), for: .touchUpInside)
        self.bgView.addSubview(loginBtn)
        
        let titleLabel = UILabel(frame: loginBtn.bounds)
        titleLabel.attributedText = NSAttributedString.attributedString( "已有帐号？", mainColor: UIColor.hex("666666"), mainFont: 16, second: "请登录", secondColor: redTitleColor, secondFont: 16)
        titleLabel.textAlignment = .center
        loginBtn.addSubview(titleLabel)
        
        let  bottomLabel = RTLabel(frame: CGRect(x: 0, y: loginBtn.maxY + 80, width: SCREEN_WIDTH, height: 22))
        bottomLabel.text = "<font size=16 color='#999999'>注册就送 </font><font size=20 color='#f6390d'>\(GPWGlobal.sharedInstance().app_exper_amount)</font><font size=16 color='#999999'> 元体验金+ </font><font size=20 color='#f6390d'>\(GPWGlobal.sharedInstance().app_accountsred)</font><font size=16 color='#999999'> 元红包</font>"
        bottomLabel.textAlignment = RTTextAlignmentCenter
        bottomLabel.height = bottomLabel.optimumSize.height
        self.bgView.addSubview(bottomLabel)
        
        let  bottomImgView = UIImageView(frame: CGRect(x: 0, y: bottomLabel.maxY + 20, width: 90, height: 54))
        bottomImgView.centerX = SCREEN_WIDTH / 2
        bottomImgView.image = UIImage(named: "user_zhuce_bottom")
        self.bgView.addSubview(bottomImgView)
        
    }
    
    func loginClick() {
        let vc = GPWLoginViewController()
        vc.flag = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func startTime() {
        
        let timer:Timer = Timer(timeInterval: 1.0,
                                    target: self,
                                    selector: #selector(self.updateTimer(timer:)),
                                    userInfo: nil,
                                    repeats: true)

        // 将定时器添加到运行循环
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func updateTimer(timer:Timer) {
        
        num  = num! - 1
        
        if (num == 0) {
            timer.invalidate()
            CFRunLoopStop(CFRunLoopGetCurrent())
            numRtlabel.text = "<a href='huoquyanzheng'><font size=16 color='#f6390d'>获取验证码</font></a>"
        }else{
            numRtlabel.text = "<a href='eeee'><font size=14 color='#f6390d'>"+String(describing: num!)+"s</font><font size=14 color='#333333'>后重新发送</font></a>"
        }
    }
    
    func btnSelectedClick(sender:UIButton) {
        if sender.tag == 1000{
            //选中，需改为未选中
            sender.tag = 1001
             sender.setImage(UIImage(named: "user_regiter_selected_no"), for: .normal)
            readFlag = false
        }else{
            sender.setImage(UIImage(named: "user_regiter_selected"), for: .normal)
            sender.tag = 1000
            readFlag = true
        }
    }
    
    func btnClick() {
        let phoneNum = (self.bgView.viewWithTag(100) as! UITextField).text!
        let code = (self.bgView.viewWithTag(101) as! UITextField).text!
        if  phoneNum.characters.count == 0 {
            self.bgView.makeToast("请输入手机号")
        }else if self.flag == false {
            self.bgView.makeToast("手机已注册过")
        }else if(self.readFlag == false){
            self.bgView.makeToast("您还未同意注册协议")
        }else if GPWHelper.judgePhoneNum(phoneNum){
            if code.characters.count > 0{
                GPWNetwork.requetWithPost(url: Register_next, parameters: ["mobile":phoneNum,"news_captcha":code], responseJSON: { [weak self]  (json, msg) in
                    guard let strongSelf = self else { return }
                    printLog(message: json)
                    let setLoginpwControl = GPWUserSetLoginPwViewController()
                    setLoginpwControl.acountPhone = phoneNum
                    strongSelf.navigationController?.pushViewController(setLoginpwControl, animated: true)
                }) { (error) in
                    
                }
            }else{
                self.bgView.makeToast("请输入验证码")
            }
        }else{
            self.bgView.makeToast("请输入正确手机号")
        }
    }
    

    func rtLabel(_ rtLabel: Any!, didSelectLinkWithURL url: String!) {
        if url == "gotoxieyi" {
            let urlstr = "https://www.gangpiaowang.com/Web/user_agreement.html"
            self.navigationController?.pushViewController(GPWWebViewController(subtitle:"",url:urlstr), animated: true)
        }else if url == "huoquyanzheng"{
              let phoneNum = (self.bgView.viewWithTag(100) as! UITextField).text!
            if  GPWHelper.judgePhoneNum(phoneNum) {
                GPWNetwork.requetWithPost(url: Num_phone, parameters: ["phone":phoneNum], responseJSON: {
                    [weak self] (json, msg) in
                    guard let strongSelf = self else { return }
                    printLog(message: json)
                      strongSelf.duanCode = json["check_captcha"].stringValue
                    if json["phmo"].intValue == 1{
                        strongSelf.bgView.makeToast(msg)
                        strongSelf.flag = false
                    }else{
                         strongSelf.flag = true
                        strongSelf.getVerificationCode()
                        strongSelf.num = 60
                        strongSelf.numRtlabel.text = "<a href='eeee'><font size=14 color='#f6390d'>"+String(describing: strongSelf.num!)+"s</font><font size=14 color='#333333'>后重新发送</font></a>"
                        strongSelf.startTime()
                    }
                    }, failure: { (error) in
                })
            }else{
                self.bgView.makeToast("请输入正确手机号")
            }
        }
    }
    //获取验证码
    func getVerificationCode()  {
        let phoneNum = (self.bgView.viewWithTag(100) as! UITextField).text!
        GPWNetwork.requetWithPost(url: Get_news_captcha_app, parameters: ["mobile":phoneNum,"check_captcha":self.duanCode ?? "0"], responseJSON: { [weak self]  (json, msg) in
            guard let strongSelf = self else { return }
            strongSelf.bgView.makeToast(msg)
        }) { (error) in
            
        }
    }
}
