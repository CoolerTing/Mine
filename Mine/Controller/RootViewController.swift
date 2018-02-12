//
//  RootViewController.swift
//  Mine
//
//  Created by coolerting on 2018/2/9.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

class RootViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UITextFieldDelegate,DQPickerViewDelegate{

    private var DatePicker:UIDatePicker!
    private var text:UITextField!
    private var SubTestLabel:UILabel?
    private var TestLabel:UILabel?
    private lazy var Picker:DQPickerView = {
        var picker = DQPickerView.init(frame: UIScreen.main.bounds)
        picker.delegate = self
        return picker
    }()
    
    var HeaderView:UIView?
    var TestButton:UIButton?
    var MainTableView:UITableView!
    
    let HeaderViewHeight:CGFloat = 130
    let StatusBarHeight:CGFloat = 20
    var WholeHeight:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WholeHeight = HeaderViewHeight + StatusBarHeight
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        let MainTableView = UITableView.init(frame: .zero, style: .plain)
        MainTableView.keyboardDismissMode = .onDrag
        MainTableView.delegate = self
        MainTableView.dataSource = self
        MainTableView.rowHeight = 80
        MainTableView.contentInset = UIEdgeInsetsMake(WholeHeight!, 0, 40, 0)
        MainTableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
        self.view.addSubview(MainTableView)
        self.MainTableView = MainTableView
        MainTableView.snp.makeConstraints { (make) in
            make.top.equalTo(-StatusBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        if (UIDevice.current.systemVersion as NSString).floatValue >= 11.0 {
            MainTableView.contentInsetAdjustmentBehavior = .never
        }
        
        let HeaderView = UIView.init()
        HeaderView.backgroundColor = UIColor.CustomColor(Red: 0, Green: 134, Blue: 255, Alpha: 1)
        self.view.addSubview(HeaderView)
        self.HeaderView = HeaderView
        HeaderView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(HeaderViewHeight)
        }
        
        let SubTestLabel = UILabel.init()
        SubTestLabel.textColor = UIColor.white
        SubTestLabel.font = UIFont.systemFont(ofSize: 14)
        SubTestLabel.text = "好吃的  难吃的  喝的  咽的  含的  口服的"
        HeaderView.addSubview(SubTestLabel)
        self.SubTestLabel = SubTestLabel
        SubTestLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(30)
            make.bottom.equalTo(0)
        }
        
        let TestButton = UIButton.init(type: .custom)
        TestButton.backgroundColor = UIColor.white
        TestButton.setTitle("请输入商家、商品名称", for: .normal)
        TestButton.setTitleColor(UIColor.lightGray, for: .normal)
        TestButton.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
        TestButton.setImage(UIImage.init(named: "home_search"), for: .normal)
        TestButton.addTarget(self, action: #selector(TestOrder), for: .touchUpInside)
        TestButton.layer.cornerRadius = 2
        HeaderView.addSubview(TestButton)
        self.TestButton = TestButton
        TestButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(30)
            make.bottom.equalTo(-35)
        }
        
        let TestLabel = UILabel.init()
        TestLabel.textColor = UIColor.white
        TestLabel.font = UIFont.systemFont(ofSize: 20)
        TestLabel.text = "山寨饿了么"
        HeaderView.addSubview(TestLabel)
        self.TestLabel = TestLabel
        TestLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.bottom.equalTo(TestButton.snp.top)
        }
        
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = false
        view.snp.makeConstraints { (make) in
            make.width.equalTo(IPHONE_WIDTH)
        }
        
        let Button = UIButton.init(type: .custom)
        Button.backgroundColor = UIColor.white
        Button.setTitle("确定", for: .normal)
        Button.addTarget(self, action: #selector(Confirm), for: .touchUpInside)
        Button.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(Button)
        Button.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(30)
        }
        
        let picker = UIDatePicker.init()
        picker.backgroundColor = UIColor.white
        picker.datePickerMode = .date
        view.addSubview(picker)
        self.DatePicker = picker
        picker.snp.makeConstraints { (make) in
            make.top.equalTo(Button.snp.bottom)
        }
        
        let text = UITextField.init()
        text.placeholder = "请选择时间"
        text.inputView = view
        text.inputView?.isUserInteractionEnabled = true
        text.borderStyle = .roundedRect
        text.delegate = self
        text.contentHorizontalAlignment = .center
        self.view.addSubview(text)
        self.text = text
        text.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let model = PickerModel.init(Dic: ["Words":"i'm just a string"])
        print(model.CabinType)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.delegate = nil
    }
    @objc func TestOrder() {
        if arc4random_uniform(2) == 1 {
            Picker.type = .Person
        }
        else {
            Picker.type = .Cabin
        }
        Picker.HideBlock = { (BlockString:String) -> Void in
            print(BlockString)
        }
        Picker.show()
    }
    @objc func Confirm() {
        let date = self.DatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        var string = String()
        string = dateFormatter.string(from: date)
        
        text.text = string
        text.resignFirstResponder()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RootTableViewCell.CellWithTableView(tableview: tableView)
        cell.imageview.image = UIImage.init(named: String(format:"thing0%ld",indexPath.row / 5 + 1))
        cell.layoutIfNeeded()
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let view = FirstViewController()
            let cell:RootTableViewCell = tableView.cellForRow(at: indexPath) as! RootTableViewCell
            view.Image = cell.imageview.image
            self.navigationController?.pushViewController(view, animated: true)
        }
        else if indexPath.row == 1
        {
            self.navigationController?.pushViewController(SecondViewController(), animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= -WholeHeight! {
            TestLabel?.alpha = 1
            SubTestLabel?.alpha = 1
            HeaderView?.transform = CGAffineTransform.init(translationX: 0, y: -(scrollView.contentOffset.y + WholeHeight!))
            HeaderView?.snp.updateConstraints({ (make) in
                make.height.equalTo(HeaderViewHeight)
            })
            TestButton?.snp.updateConstraints({ (make) in
                make.bottom.equalTo(-35)
            })
        }
        else if scrollView.contentOffset.y > -WholeHeight! && scrollView.contentOffset.y <= -(WholeHeight! - 35)
        {
            HeaderView?.transform = CGAffineTransform.identity
            HeaderView?.snp.updateConstraints({ (make) in
                make.height.equalTo(-scrollView.contentOffset.y - 20)
            })
            let alpha = (35 - (WholeHeight! + scrollView.contentOffset.y)) / 35
            TestLabel?.alpha = alpha
        }
        else  if scrollView.contentOffset.y > -(WholeHeight! - 35) && scrollView.contentOffset.y <= -(WholeHeight! - 35 - 30)
        {
            HeaderView?.transform = CGAffineTransform.identity
            HeaderView?.snp.updateConstraints({ (make) in
                make.height.equalTo(-scrollView.contentOffset.y - 20)
            })
            let alpha = (30 - (WholeHeight! + (scrollView.contentOffset.y - 35))) / 30
            SubTestLabel?.alpha = alpha
            TestButton?.snp.updateConstraints({ (make) in
                make.bottom.equalTo(-alpha * 30 - 5)
            })
            
        }
        else
        {
            TestLabel?.alpha = 0
            SubTestLabel?.alpha = 0
            HeaderView?.transform = CGAffineTransform.identity
            HeaderView?.snp.updateConstraints({ (make) in
                make.height.equalTo(65)
            })
            TestButton?.snp.updateConstraints({ (make) in
                make.bottom.equalTo(-5)
            })
        }
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC == self && toVC is FirstViewController {
            return FirstTransition();
        }
        return nil
    }
    
    func PickerViewWithPicker(PickerView: DQPickerView, AdultNum: Int, ChildNum: Int, CabinType: String) {
        if Picker.type == .Cabin {
            print(CabinType)
        }
        else {
            print("adult:\(AdultNum),child:\(ChildNum)")
        }
    }
}
