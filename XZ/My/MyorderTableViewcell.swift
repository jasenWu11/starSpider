//
//  ShopTableViewCell.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
class MyorderTableViewcell: UITableViewCell {
    //视图
    var v_order:UIView?
    var tableView:UITableView?
    //类型
    var tv_oid: UILabel?
    //标题
    var tv_title: UILabel?
    //创建时间
    var tv_ctime: UILabel?
    //结束时间
    var tv_etime: UILabel?
    //统计量
    var tv_pstate: UILabel?
    //产品单价标签
    var l_price: UILabel?
    //单价
    var tv_price:UILabel?
    //支付时间标签
    var l_ptime:UILabel?
    //支付时间
    var tv_ptime:UILabel?
    
    var bt_oper : UIButton?
    var bt_dele : UIButton?
    var tv_oids: UILabel?
    var tv_ctimes: UILabel?
    var tv_etimes: UILabel?
    var tv_pstates: UILabel?
    var yuer : Double = 0.0;
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    var root : MyorderTableViewController?
    var pid:Int = 5
    var pids:Int = 5
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    @objc func Operactions(subButton: UIButton) {
        print(subButton.tag)
        var oids : Int = (root?.oidss[subButton.tag])!
        var pids : Int = (root?.pidss[subButton.tag])!
        var price : Double = (root?.prices[subButton.tag])!
        var isapy : String = (root?.pstatus[subButton.tag])!
        print("支付状态\(isapy)")
        if(isapy == "已支付"){
            let alertController = UIAlertController(title: "订单成功已支付，无需重复支付！",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.root?.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
        else{
            let alertController = UIAlertController(title: "提示", message: "是否支付该订单？共\(price)元每月",preferredStyle: .alert)
            let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
                action in
                self.payok(orderids: oids, productids: pids, prices: price)
            })
            let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(cancelAction1)
            alertController.addAction(cancelAction2)
            root?.present(alertController, animated: true, completion: nil)
        }
    }
    func payok(orderids:Int,productids:Int,prices:Double){
        var userid:Int = UserDefaults.standard.object(forKey: "userId") as! Int
        let url = "https://www.xingzhu.club/XzTest/orders/payOrder"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["userId":userid,"orderId":orderids,"productId":productids,"productPriceMonth":prices,"payType":0] as [String : Any]
        print("订单ID\(orderids)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            var request : String = "\(response.result)"
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                let code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("message\(message)")
                let alertController = UIAlertController(title: "\(message)",
                    message: nil, preferredStyle: .alert)
                //显示提示框
                self.root?.present(alertController, animated: true, completion: nil)
                //两秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                if(message == "订单支付成功！"){
                    if UserDefaults.standard.object(forKey: "userBalance") != nil {
                        self.yuer = UserDefaults.standard.object(forKey: "userBalance") as! Double
                    }
                    UserDefaults.standard.set(self.yuer-prices, forKey: "userBalance")
                }
            }
                self.root?.getAllProducts()
            
        }
    }
    @objc func Deleactions(subButton: UIButton) {
        print(subButton.tag)
        let alertController = UIAlertController(title: "提示", message: "是否关闭该订单？",preferredStyle: .alert)
        let cancelAction1 = UIAlertAction(title: "确定", style: .destructive, handler: {
            action in
            self.deleteok(orderids: subButton.tag)
        })
        let cancelAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction1)
        alertController.addAction(cancelAction2)
        root?.present(alertController, animated: true, completion: nil)
    }
    func deleteok(orderids:Int){
        let url = "https://www.xingzhu.club/XzTest/orders/closeOrder"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["orderId":orderids]
        print("订单ID\(orderids)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            var request : String = "\(response.result)"
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                let code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("message\(message)")
                if (message == "关闭订单成功！"){
                    let alertController = UIAlertController(title: "关闭订单成功！",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.root?.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }else{
                    let alertController = UIAlertController(title: "关闭订单失败！",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.root?.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
                 self.root?.getAllProducts()
            }
        }
    }
    @objc func BuyClick(subButton: UIButton) {
        let optionMenuController = UIAlertController(title: nil, message: "选择支付方式", preferredStyle: .actionSheet)
        
        let AlipayAction = UIAlertAction(title: "支付宝", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.pid = subButton.tag
            let alertController = UIAlertController(title: "使用支付宝支付购买商品\(self.pid)",
                message: nil, preferredStyle: .alert)
            //显示提示框
            self.root?.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        })
        
        let WechatAction = UIAlertAction(title: "微信", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.pid = subButton.tag
            let alertController = UIAlertController(title: "使用微信支付购买商品\(self.pid)",
                message: nil, preferredStyle: .alert)
            //显示提示框
            self.root?.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                self.root?.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenuController.addAction(AlipayAction)
        optionMenuController.addAction(WechatAction)
        optionMenuController.addAction(cancelAction)
        
        root?.present(optionMenuController, animated: true, completion: nil)
    }
    func setUpUI(){
        //视图
        v_order = UIView(frame: CGRect(x:5, y: 5, width:screenWidth-10, height: 200))
        v_order?.backgroundColor=UIColor.white
        v_order?.clipsToBounds=true
        v_order?.layer.cornerRadius = 8
        v_order?.layer.shadowColor = UIColor.gray.cgColor
        v_order?.layer.shadowOpacity = 1.0
        v_order?.layer.shadowOffset = CGSize(width: 0, height: 0)
        v_order?.layer.shadowRadius = 4
        v_order?.layer.masksToBounds = false
        self.addSubview(v_order!)
        // 大标题
        tv_title = UILabel(frame: CGRect(x:10, y: 10, width:screenWidth-10, height: 20))
        tv_title?.font = UIFont.systemFont(ofSize: 17)
        tv_title?.textColor = UIColor.black
        v_order?.addSubview(tv_title!)
        //标号标签
        tv_oids = UILabel(frame: CGRect(x:10, y:35, width: 80, height:20))
        tv_oids?.font = UIFont.systemFont(ofSize: 14)
        tv_oids?.textColor = UIColor.black
        tv_oids?.text = "订单编号："
        v_order?.addSubview(tv_oids!)
        // 编号
        tv_oid = UILabel(frame: CGRect(x:85, y:35, width: 100, height:20))
        tv_oid?.font = UIFont.systemFont(ofSize: 14)
        tv_oid?.textColor = UIColor.black
        v_order?.addSubview(tv_oid!)
        //单价标签
        l_price = UILabel(frame: CGRect(x:150, y:35, width: 120, height:20))
        l_price?.font = UIFont.systemFont(ofSize: 14)
        l_price?.textColor = UIColor.black
        l_price?.text = "产品单价(元/月)："
        v_order?.addSubview(l_price!)
        // 单价
        tv_price = UILabel(frame: CGRect(x:265, y:35, width: 100, height:20))
        tv_price?.font = UIFont.systemFont(ofSize: 14)
        tv_price?.textColor = UIColor.red
        v_order?.addSubview(tv_price!)
        // 统计
        tv_pstates = UILabel(frame: CGRect(x:10, y:60, width:100, height: 20))
        tv_pstates?.font = UIFont.systemFont(ofSize: 14)
        tv_pstates?.textColor = UIColor.black
        tv_pstates?.text = "支付状态："
        v_order?.addSubview(tv_pstates!)
        
        tv_pstate = UILabel(frame: CGRect(x:85, y:60, width:100, height: 20))
        tv_pstate?.font = UIFont.systemFont(ofSize: 14)
        tv_pstate?.textColor = UIColor.black
        v_order?.addSubview(tv_pstate!)
        //支付时间标签
        l_ptime = UILabel(frame: CGRect(x:10, y:85, width: 100, height:20))
        l_ptime?.font = UIFont.systemFont(ofSize: 14)
        l_ptime?.textColor = UIColor.black
        l_ptime?.text = "支付时间："
        v_order?.addSubview(l_ptime!)
        // 支付时间
        tv_ptime = UILabel(frame: CGRect(x:85, y:85, width: 200, height:20))
        tv_ptime?.font = UIFont.systemFont(ofSize: 14)
        tv_ptime?.textColor = UIColor.black
        v_order?.addSubview(tv_ptime!)
        // 创建时间
        tv_ctimes = UILabel(frame: CGRect(x:10, y:110, width:100, height: 20))
        tv_ctimes?.font = UIFont.systemFont(ofSize: 14)
        tv_ctimes?.textColor = UIColor.black
        tv_ctimes?.text = "创建时间："
        v_order?.addSubview(tv_ctimes!)
        
        tv_ctime = UILabel(frame: CGRect(x:85, y:110, width:200, height: 20))
        tv_ctime?.font = UIFont.systemFont(ofSize: 14)
        tv_ctime?.textColor = UIColor.black
        v_order?.addSubview(tv_ctime!)
        // 状态
        tv_etimes = UILabel(frame: CGRect(x:10, y:135, width:100, height: 20))
        tv_etimes?.font = UIFont.systemFont(ofSize: 14)
        tv_etimes?.textColor = UIColor.black
        tv_etimes?.text = "结束时间："
        v_order?.addSubview(tv_etimes!)
        
        tv_etime = UILabel(frame: CGRect(x:85, y:135, width:200, height: 20))
        tv_etime?.font = UIFont.systemFont(ofSize: 14)
        tv_etime?.textColor = UIColor.black
        v_order?.addSubview(tv_etime!)
        
        // 操作按钮
        bt_oper = UIButton(frame: CGRect(x:0, y:160, width:(screenWidth-10)/2, height: 40))
        bt_oper?.setTitle("支付", for: UIControl.State.normal)
        bt_oper?.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        bt_oper?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bt_oper?.backgroundColor = UIColor.white
        bt_oper?.layer.cornerRadius = 8.0
        bt_oper?.layer.borderWidth = 0.1
        bt_oper?.layer.maskedCorners = [CACornerMask.layerMinXMaxYCorner]
        bt_oper?.layer.masksToBounds = true
        bt_oper?.addTarget(self, action: #selector(Operactions), for: UIControl.Event.touchUpInside)
        v_order?.addSubview(bt_oper!)
        // 删除按钮
        bt_dele = UIButton(frame: CGRect(x:(screenWidth-10)/2, y:160, width:(screenWidth-10)/2, height: 40))
        bt_dele?.setTitle("关闭", for: UIControl.State.normal)
        bt_dele?.setTitleColor(UIColor.red, for: UIControl.State.normal)
        bt_dele?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        bt_dele?.backgroundColor = UIColor.white
        bt_dele?.layer.cornerRadius = 8.0
        bt_dele?.layer.borderWidth = 0.1
        bt_dele?.layer.maskedCorners = [CACornerMask.layerMaxXMaxYCorner]
        bt_dele?.layer.masksToBounds = true
        bt_dele?.addTarget(self, action: #selector(Deleactions), for: UIControl.Event.touchUpInside)
        v_order?.addSubview(bt_dele!)
        
    }
    
    // 给cell赋值，项目中一般使用model，我这里直接写死了
    //    func setValueForCell(){
    //
    //        rows = rows+1
    //        iconImage?.image = UIImage(named:"weibo")
    //        titleLabel?.text = "大大大大的标题"
    //        subTitleLabel?.text = "副副副副的标题"
    //    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
