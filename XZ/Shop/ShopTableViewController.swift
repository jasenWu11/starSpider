//
//  ShopTableViewController.swift
//  XZ
//
//  Created by wjz on 2019/1/9.
//  Copyright © 2019年 wjz. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class ShopTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    var titles:[String] = []
    var contents:[String] = []
<<<<<<< HEAD
    var images:[UIImage?] = []
    var pricem:[Double] = []
    var prices:[Double] = []
    var pricey:[Double] = []
    var pidss:[Int] = []
    var heights:[CGFloat] = []
=======
    var images:[String] = []
    var price:[Double] = []
    var pidss:[Int] = []
    var type:Int = 0
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    let screenWidth =  UIScreen.main.bounds.size.width
    let screenHeight =  UIScreen.main.bounds.size.height
    let TAG_CELL_LABEL = 1
    let TAG_CELL_BUTTON = 2
    var pids:Int = 0
    var tableView:UITableView?
    var root : ShoppagViewController?
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    var searchBars:UISearchBar?
    var searchtext:String = ""
    var dzView : UIView?
    var tv_dingzhi : UILabel?
    var bt_dz : UIButton?
<<<<<<< HEAD
    var widths:Int = 0
    // 底部加载
    let footer = MJRefreshAutoNormalFooter()
    var indexs:Int = 0
    var maxcount:Int = 10
    var chongzhi:Int = 0
    var issear:Int = 0
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        self.view.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        //关闭导航栏半透明效果
        self.navigationController?.navigationBar.isTranslucent = false
=======
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        //搜索框
        searchBars = UISearchBar(frame: CGRect(x:0, y: 0, width:screenWidth, height: 44))
        searchBars?.barStyle = .black
        searchBars?.showsCancelButton = true
        searchBars?.keyboardAppearance = .default
        searchBars?.delegate = self
        let bt_cancel = searchBars?.value(forKey: "cancelButton") as! UIButton
        bt_cancel.setTitle("Cancel", for: .normal)
        bt_cancel.setTitleColor(UIColor.white,for: .normal)
        let seartext = searchBars?.value(forKey: "searchField") as! UITextField
        seartext.textColor = UIColor.white
        searchBars?.tintColor = UIColor.blue
        //光标颜色
        searchBars?.subviews[0].subviews[1].tintColor = UIColor.white
        searchBars?.keyboardType = .default
//        searchBars?.addTarget(self, action: #selector(composeBtnClick), for: UIControl.Event.touchUpInside)
        view.addSubview(searchBars!)
        
        //定制视图
        dzView = UIView(frame: CGRect(x:0, y: 44, width:screenWidth, height: 40))
        dzView?.backgroundColor=UIColor.white
        dzView?.clipsToBounds=true
        dzView?.layer.shadowColor = UIColor.gray.cgColor
        dzView?.layer.shadowOpacity = 1.0
        dzView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        dzView?.layer.shadowRadius = 4
        dzView?.layer.masksToBounds = false
        view.addSubview(dzView!)
        //定制文字
        tv_dingzhi = UILabel(frame: CGRect(x:15, y:0, width: 200, height:40))
        tv_dingzhi?.font = UIFont.systemFont(ofSize: 16)
        tv_dingzhi?.textColor = UIColor.black
        tv_dingzhi?.numberOfLines = 0
        tv_dingzhi?.lineBreakMode = NSLineBreakMode.byWordWrapping
        dzView?.addSubview(tv_dingzhi!)
        tv_dingzhi?.text = "没找到您心仪的商品？"
        //定制按钮
        bt_dz = UIButton(frame: CGRect(x:screenWidth-80, y:0, width:80, height: 40))
        bt_dz?.setTitle("请您定制", for: UIControl.State.normal)
        bt_dz?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        bt_dz?.backgroundColor = UIColor.black
        bt_dz?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        bt_dz?.addTarget(self, action: #selector(cumaBtnClick), for: UIControl.Event.touchUpInside)
        //subButton!.tag = pid
        dzView?.addSubview(bt_dz!)
        //隐藏时间
        //下拉刷新
<<<<<<< HEAD
        header.lastUpdatedTimeLabel.isHidden = false
        header.stateLabel.isHidden = false
        //refreshItemData()
        let theheight = CGFloat((root?.quitheight)!)
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:84, width:self.screenWidth, height: screenHeight-50-44-40-theheight), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        tableView?.separatorStyle = .none
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        self.view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(Refresh))
        self.tableView!.mj_header = header
        //上刷新相关设置
        footer.setRefreshingTarget(self, refreshingAction: #selector(ShopTableViewController.footerLoad))
        //是否自动加载（默认为true，即表格滑到底部就自动加载）
        footer.isAutomaticallyRefresh = false
        self.tableView!.mj_footer = footer
        //手动调用刷新效果
        header.beginRefreshing()
//        titles = ["微博热搜版","爱奇艺点击率最高电影"]
//        contents = root?.content1 ?? ["获取微博热搜版，研究大众兴趣","获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片"]
//        images = root?.image1 ?? ["weibo","aiqiyi"]
//        pricem = root?.pricem1 ?? [81.04,130.5]
//        pidss = root?.pid1 ?? [2238241,2238245]
       //print("数据是\(titles)")

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("市场前台显示")
=======
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        //refreshItemData()
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x:0, y:84, width:self.screenWidth, height: self.screenHeight-207), style:.plain)
        //self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "ShopCell")
        self.view.addSubview(self.tableView!)
        header.setRefreshingTarget(self, refreshingAction: #selector(getAllProducts))
        self.tableView!.mj_header = header
        getAllProducts()
//        titles = ["微博热搜版","爱奇艺点击率最高电影"]
//        contents = root?.content1 ?? ["获取微博热搜版，研究大众兴趣","获取爱奇艺点击率最高电影,可以方便找到票房较高的电影，筛选避过烂片"]
//        images = root?.image1 ?? ["weibo","aiqiyi"]
//        price = root?.price1 ?? [81.04,130.5]
//        pidss = root?.pid1 ?? [2238241,2238245]
       print("数据是\(titles)")
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("市场前台显示")
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
        
        // The rest of your code.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
<<<<<<< HEAD
        let identifier = "ShopCell"
        let cell = ShopTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! ShopTableViewCell
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
        cell.root = self
        cell.titleLabel?.text = titles[indexPath.row]
        cell.iconImage?.image = images[indexPath.row]
        cell.subTitleLabel?.text = contents[indexPath.row]
            widths = Int((cell.subTitleLabel?.frame.size.width)!)
            var theheight = cell.heightForView(text: "\(cell.subTitleLabel?.text)", font: UIFont.systemFont(ofSize: 14), width:  CGFloat(widths))
            heights += [theheight]
            cell.subTitleLabel?.frame.size.height = heights[indexPath.row]
        cell.pirceLabel?.text = "¥\(pricem[indexPath.row])"
        cell.subButton!.tag = indexPath.row
        cell.shopcellView!.tag = indexPath.row
        cell.tag = pidss[indexPath.row]
        pids = pidss[indexPath.row]
           
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //print(indexPath.row)
=======
        
        
        let identifier = "ShopCell"
        let cell = ShopTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier) as! ShopTableViewCell
        cell.root = self
        cell.titleLabel?.text = titles[indexPath.row]
        let url = URL(string:images[indexPath.row])
        let data = try! Data(contentsOf: url!)
        let smallImage = UIImage(data: data)
        cell.iconImage?.image = smallImage
        cell.subTitleLabel?.text = contents[indexPath.row]
        cell.pirceLabel?.text = "¥\(price[indexPath.row])"
        cell.subButton!.tag = pidss[indexPath.row]
        cell.shopcellView!.tag = pidss[indexPath.row]
        cell.tag = pidss[indexPath.row]
        pids = pidss[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print(indexPath.row)
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    }
//    在这个方法中给新页面传递参数
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("接收")
//        if segue.identifier == "deatil"{
//            let controller = segue.destination as! APImessViewController
//            controller.pid = (sender as? Int)!
//        }
//    }
<<<<<<< HEAD
    @objc func Refresh(){
        self.titles.removeAll()
        self.pidss.removeAll()
        self.contents.removeAll()
        self.images.removeAll()
        self.pricem.removeAll()
        self.prices.removeAll()
        self.pricey.removeAll()
        self.heights.removeAll()
        getAllProducts(index: 0)
        if (chongzhi == 1) {
            self.tableView!.mj_footer.resetNoMoreData()
        }
    }
    func getAllProducts(index:Int)  {
        issear = 0
        searchBars?.text = ""
        let url = "https://www.xingzhu.club/XzTest/products/getAllProducts"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            //print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                //print("结果:\(json)")
                var code: Int = json["code"].int!
                //print("错误:\(code)")
                var message:String = json["message"].string!
                //print("提示:\(message)")
                let provinces = json["data"]
                var jndex = index+10
                self.maxcount = provinces.count
                if (jndex>=provinces.count){
                    jndex = provinces.count
                    self.tableView!.mj_footer.endRefreshingWithNoMoreData()
                }
                for i in index..<jndex{
=======
    @objc func getAllProducts()  {
        
        let url = "https://www.xingzhu.club/XzTest/products/getAllProducts"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                let provinces = json["data"]
                self.titles.removeAll()
                self.pidss.removeAll()
                self.contents.removeAll()
                self.images.removeAll()
                self.price.removeAll()
                for i in 0..<provinces.count{
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
                    let productId: Int = provinces[i]["productId"].int ?? 0
                    self.pidss += [productId]

                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    self.titles += [productTitle]

                    let productDes: String = provinces[i]["productDes"].string ?? ""
                    self.contents += [productDes]
<<<<<<< HEAD
                    
//                    var protitleheight = self.heightForView(text: productDes, font: UIFont.systemFont(ofSize: 14), width:  CGFloat(self.widths))
//                    self.heights += [Int(protitleheight)]
                    
                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    let url = URL(string:productPhoto)
                    let data = try! Data(contentsOf: url!)
                    let smallImage = UIImage(data: data)
                    
                    self.images += [smallImage]

                    let productpricemMonth: Double = provinces[i]["productPriceMonth"].double ?? 0
                    self.pricem += [productpricemMonth]
                    
                    let productPriceSeason: Double = provinces[i]["productPriceSeason"].double ?? 0
                    self.prices += [productPriceSeason]
                    
                    let productPriceYear: Double = provinces[i]["productPriceYear"].double ?? 0
                    self.pricey += [productPriceYear]
                }
                self.indexs = jndex
            }
            self.reloadData()
        }
    }
    func reloadData(){
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }

=======

                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    self.images += [productPhoto]

                    let productPriceMonth: Double = provinces[i]["productPriceMonth"].double ?? 0
                    self.price += [productPriceMonth]
                }
            }
            print("标题是\(self.titles)")
            print("图片是\(self.images)")
            //重现加载表格数据
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
        }
    }
    //初始化数据
    func refreshItemData() {
        titles.append("微博热搜版")
        contents.append("获取微博热搜版，研究大众兴趣")
        images.append("https://xz-1256883494.cos.ap-guangzhou.myqcloud.com/products_img/weibo.png")
        price.append(81.04)
        pidss.append(2238241)
    }
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(_ searchBars: UISearchBar) {
        searchBars.resignFirstResponder()
        let searchtext:String = searchBars.text!
<<<<<<< HEAD
        //print(searchtext)
=======
        print(searchtext)
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    }
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?) {
    
        searchBars?.resignFirstResponder()
    
    }
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText:String) {
        
        //searchBars?.resignFirstResponder()
        searchtext = searchBars?.text! ?? ""
<<<<<<< HEAD
        //print(searchtext)
        //print("searchtext")
        self.titles.removeAll()
        self.pidss.removeAll()
        self.contents.removeAll()
        self.images.removeAll()
        self.pricem.removeAll()
        self.prices.removeAll()
        self.pricey.removeAll()
        self.heights.removeAll()
        getProducts(index: 0)
        if (searchtext == "") {
            Refresh()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar:UISearchBar) {
        //print("cancel")
        searchBars?.text = ""
        Refresh()
    }
    @objc func getProducts(index:Int)  {
        issear = 1
        let url = "https://www.xingzhu.club/XzTest/products/getProductByContent"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["productTitle":self.searchtext]
        //print("搜索\(self.searchtext)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            //print("jsonRequest:\(response.result)")
           
            if let data = response.result.value {
                let json = JSON(data)
                //print("结果:\(json)")
                var code: Int = json["code"].int!
                //print("错误:\(code)")
                var message:String = json["message"].string!
                //print("提示:\(message)")
                let provinces = json["data"]
                var jndex = index+10
                self.maxcount = provinces.count
                if (jndex>=provinces.count){
                    jndex = provinces.count
                    self.tableView!.mj_footer.endRefreshingWithNoMoreData()
                }
                for i in index..<jndex{
=======
        print(searchtext)
        //print("searchtext")
        getProducts()
        if (searchtext == "") {
            getAllProducts()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar:UISearchBar) {
        print("cancel")
        getAllProducts()
    }
    @objc func getProducts()  {
        let url = "https://www.xingzhu.club/XzTest/products/getProductByContent"
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        let paras = ["productTitle":self.searchtext]
        print("搜索\(self.searchtext)")
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        Alamofire.request(url, method: .post, parameters: paras, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("jsonRequest:\(response.result)")
            self.titles = []
            self.pidss = []
            self.contents = []
            self.images = []
            self.price = []
            if let data = response.result.value {
                let json = JSON(data)
                print("结果:\(json)")
                var code: Int = json["code"].int!
                print("错误:\(code)")
                var message:String = json["message"].string!
                print("提示:\(message)")
                let provinces = json["data"]
                for i in 0..<provinces.count{
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
                    let productId: Int = provinces[i]["productId"].int ?? 0
                    self.pidss += [productId]
                    
                    let productTitle: String = provinces[i]["productTitle"].string ?? ""
                    self.titles += [productTitle]
                    
                    let productDes: String = provinces[i]["productDes"].string ?? ""
                    self.contents += [productDes]
                    
<<<<<<< HEAD
//                    var protitleheight = self.heightForView(text: productDes, font: UIFont.systemFont(ofSize: 14), width:  CGFloat(self.widths))
//                    self.heights += [Int(protitleheight)]
                    
                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    let url = URL(string:productPhoto)
                    let data = try! Data(contentsOf: url!)
                    let smallImage = UIImage(data: data)
                    
                    self.images += [smallImage]
                    
                    let productpricemMonth: Double = provinces[i]["productPriceMonth"].double ?? 0
                    self.pricem += [productpricemMonth]
                    
                    let productPriceSeason: Double = provinces[i]["productPriceSeason"].double ?? 0
                    self.prices += [productPriceSeason]
                    
                    let productPriceYear: Double = provinces[i]["productPriceYear"].double ?? 0
                    self.pricey += [productPriceYear]
                }
                self.indexs = jndex
            }
           self.reloadData()
        }
    }
    @objc func cumaBtnClick(Button: UIButton) {
        
       root?.custom()
    }
    //label自适应高度
//    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//        var widths = self.screenWidth-175
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: widths, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//        label.sizeToFit()
//        var heights = 0
//        if(label.frame.height>=50){
//            heights = 50
//        }
//        else{
//            heights = Int(label.frame.height)
//        }
//        return CGFloat(heights)
//    }
    //底部上拉加载
    @objc func footerLoad(){
        //print("上拉加载.")
        chongzhi = 1
        //生成并添加数据
        if(issear == 0){
            getProducts(index: indexs)
        }
        else{
            getAllProducts(index: indexs)
        }
        //        //重现加载表格数据
        //        self.tableView!.reloadData()
        //        //结束刷新
        //        self.tableView!.mj_footer.endRefreshing()
        
=======
                    let productPhoto: String = provinces[i]["productPhoto"].string ?? ""
                    self.images += [productPhoto]
                    
                    let productPriceMonth: Double = provinces[i]["productPriceMonth"].double ?? 0
                    self.price += [productPriceMonth]
                }
            }
            print("标题是\(self.titles)")
            print("图片是\(self.images)")
            //重现加载表格数据
            self.tableView!.reloadData()
            //结束刷新
            self.tableView!.mj_header.endRefreshing()
        }
    }
    @objc func cumaBtnClick(Button: UIButton) {
       root?.performSegue(withIdentifier: "custommade", sender: "")
>>>>>>> 4dc0df178de3d5404cd18f0b0f787b8ecee52413
    }
}
