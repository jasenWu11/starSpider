//
//  LoginViewController.swift
//  XZ
//
//  Created by wjz on 2018/12/27.
//  Copyright © 2018年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {
    @IBOutlet weak var tv_Res: UILabel!
    @IBOutlet weak var tv_pwd: UITextField!
    @IBOutlet weak var tv_phone: UITextField!
    @IBOutlet weak var bt_log: UIButton!
    @IBOutlet weak var tv_yanzh: UITextField!
    @IBOutlet weak var bu_yanzhen: UIButton!
    var user: String = ""
    var phone: String = ""
    var pass: String = ""
    var yanzhen: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("", forKey: "user")
        let resclick = UITapGestureRecognizer(target: self, action: #selector(resAction))
        let logclick = UITapGestureRecognizer(target: self, action: #selector(logAction))
        tv_Res.addGestureRecognizer(resclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        tv_Res.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        bt_log.addGestureRecognizer(logclick)
        //开启 isUserInteractionEnabled 手势否则点击事件会没有反应
        bt_log.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    @objc func resAction() -> Void {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: RegisterViewController())))
            as! RegisterViewController
        self.present(controller, animated: true, completion: nil)
    }
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func logAction() -> Void {
        phone = tv_phone.text!
        pass = tv_pwd.text!
        user=tv_phone.text!
        yanzhen=tv_yanzh.text!
        
        if (phone == ""){
            showMsgbox(_message: "请输入帐号")
            return
            
        }
        if (isTelNumber(num: phone as NSString) == false) {
            showMsgbox(_message: "请输入正确的手机号")
            return
        }
        if (pass == ""){
            showMsgbox(_message: "请输入密码")
            return
        }
        if (pass.count > 16 || pass.count < 6){
            showMsgbox(_message: "请输入6到16位密码")
            return
        }
        if (yanzhen == ""){
            showMsgbox(_message: "请输入验证码")
            return
        }
        else {
            LoginRequest()
//            let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MainViewController())))
//                as! MainViewController
//            self.present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func Yanzheng(_ sender: Any) {
        CodeRequest()
    }
    
    func isTelNumber(num:NSString)->Bool
    {
        var mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        var  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        var  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        var  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        var regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        var regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        var regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        var regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func CodeRequest()  {
        phone = tv_phone.text!
        pass = tv_pwd.text!
        user=tv_phone.text!
        yanzhen=tv_yanzh.text!
        let url = "http://47.106.217.3:8360/app/user/code"
        let paras = ["phone":phone]
        print("手机号"+phone)
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            let data = response.result.value
            print("结果:\(data)")
            }
        self.countDown(timeOut: 60)
        }
    
    //验证码倒计时
    //验证码倒计时
    func countDown(timeOut:Int){
        
        //倒计时时间
        var timeout = timeOut
        let queue:DispatchQueue = DispatchQueue.global(qos: .default)
        
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:queue)
        
        
        codeTimer.scheduleRepeating(deadline: .now(), interval:.seconds(1))
        
        //每秒执行
        codeTimer.setEventHandler(handler: { () -> Void in
            if(timeout<=0){ //倒计时结束，关闭
                
                
                codeTimer.cancel()
                
                DispatchQueue.main.sync(execute: { () -> Void in
                    //设置界面的按钮显示 根据自己需求设置
                    self.bu_yanzhen.setTitle("重新发送", for: UIControl.State.normal)
                    
                    self.bu_yanzhen.isUserInteractionEnabled = true
                    
                    
                })
            }else{//正在倒计时
                
                let seconds = timeout
                let strTime = NSString.localizedStringWithFormat("%.d", seconds)
                
                DispatchQueue.main.sync(execute: { () -> Void in
                    //                    NSLog("----%@", NSString.localizedStringWithFormat("%@S", strTime) as String)
                    
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDuration(1)
                    //设置界面的按钮显示 根据自己需求设置
                    self.bu_yanzhen.setTitle(NSString.localizedStringWithFormat("%@S", strTime) as String, for: UIControl.State.normal)
                    UIView.commitAnimations()
                    self.bu_yanzhen.isUserInteractionEnabled = false
                })
                timeout -= 1;
            }
            
        })
        codeTimer.resume()
    }
    
    func LoginRequest()  {
        phone = tv_phone.text!
        pass = tv_pwd.text!
        user=tv_phone.text!
        yanzhen=tv_yanzh.text!
        let url = "http://47.106.217.3:8360/app/user/login"
        let paras = ["phone":phone,"password":pass,"code":yanzhen]
        print("手机号"+phone)
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var erro: Int = json["errno"].int!
                print("错误:\(erro)")
                if(erro == 0){
                    let alertController = UIAlertController(title: "登录成功!",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                    let time: TimeInterval = 1
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                        //code
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: MainViewController())))
                            as! MainViewController
                        self.present(controller, animated: true, completion: nil)
                        UserDefaults.standard.set(self.phone, forKey: "user")
                    }
                    
                }
                if(erro == 10){
                    let alertController = UIAlertController(title: "验证码错误!",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
                if(erro == 16){
                    let alertController = UIAlertController(title: "密码错误!",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
                if(erro == 14){
                    let alertController = UIAlertController(title: "用户不存在!",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
            }
            
        }
    }
}