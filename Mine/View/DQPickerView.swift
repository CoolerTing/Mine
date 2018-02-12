//
//  DQPickerView.swift
//  Mine
//
//  Created by coolerting on 2018/2/11.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

enum PickerType:Int {
    case Person, Cabin
}
protocol DQPickerViewDelegate {
    func PickerViewWithPicker(PickerView:DQPickerView, AdultNum:Int, ChildNum:Int, CabinType:String)
}

class DQPickerView: UIView, UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate {

    var type:PickerType? {
        didSet {
            if type == .Cabin {
                TitleLabel?.text = "选择舱位"
                ChildNumLabel.isHidden = true
                AdultNumLabel.isHidden = true
                PickerView.snp.remakeConstraints({ (make) in
                    make.top.equalTo(40)
                    make.bottom.right.left.equalToSuperview()
                })
            }
            else {
                TitleLabel?.text = "选择人数"
                ChildNumLabel.isHidden = false
                AdultNumLabel.isHidden = false
                PickerView.snp.remakeConstraints({ (make) in
                    make.top.equalTo(80)
                    make.bottom.right.left.equalToSuperview()
                })
            }
        }
    }
    var delegate:DQPickerViewDelegate?
    private var BackView:UIView!
    private var MaskView:UIView!
    private var AdultNum:Int = 1
    private var ChildNum:Int = 0
    private var CancelButton:UIButton!
    private var ConfirmButton:UIButton!
    private var TitleLabel:UILabel?
    private var AdultNumLabel:UILabel!
    private var ChildNumLabel:UILabel!
    private var PickerView:UIPickerView!
    private var Canbin = ["舱位不限","经济舱","公务舱","头等舱"]
    private var CabinRow:Int = 0
    private var AdultSeletedRow:Int = 1
    
    var HideBlock:((_ BlockString:String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        UIApplication.shared.keyWindow?.addSubview(self)
        
        let MaskView = UIView.init(frame: self.bounds)
        MaskView.backgroundColor = UIColor.black
        MaskView.alpha = 0
        self.addSubview(MaskView)
        self.MaskView = MaskView
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hide))
        tap.delegate = self
        MaskView.addGestureRecognizer(tap)
        
        let BackView = UIView.init()
        BackView.backgroundColor = UIColor.white
        self.addSubview(BackView)
        self.BackView = BackView
        BackView.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(IPHONE_HEIGHT)
            make.height.equalTo(260)
        }
        BackView.layoutIfNeeded()
        
        let CancelButton = UIButton.init(type: .custom)
        CancelButton.setTitleColor(UIColor.black, for: .normal)
        CancelButton.setTitle("取消", for: .normal)
        CancelButton.contentHorizontalAlignment = .left
        CancelButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        CancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        BackView.addSubview(CancelButton)
        self.CancelButton = CancelButton
        
        CancelButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(30)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        let ConfirmButton = UIButton.init(type: .custom)
        ConfirmButton.setTitleColor(UIColor.black, for: .normal)
        ConfirmButton.setTitle("确定", for: .normal)
        ConfirmButton.contentHorizontalAlignment = .right
        ConfirmButton.addTarget(self, action: #selector(ConfirmClick), for: .touchUpInside)
        ConfirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        BackView.addSubview(ConfirmButton)
        self.ConfirmButton = ConfirmButton
        
        ConfirmButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalTo(-30)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        let Line = UIView.init()
        Line.backgroundColor = UIColor.CustomColor(Red: 240, Green: 240, Blue: 240, Alpha: 1)
        BackView.addSubview(Line)
        Line.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview()
            make.top.equalTo(ConfirmButton.snp.bottom)
            make.height.equalTo(1)
        }
        
        let TitleLabel = UILabel.init()
        TitleLabel.textColor = UIColor.CustomColor(Red: 153, Green: 153, Blue: 153, Alpha: 1)
        TitleLabel.font = UIFont.systemFont(ofSize: 16)
        TitleLabel.textAlignment = .center
        TitleLabel.text = "选择人数"
        BackView.addSubview(TitleLabel)
        self.TitleLabel = TitleLabel
        TitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(CancelButton.snp.centerY)
            make.height.equalTo(90)
            make.width.equalTo(120)
        }
        
        let AdultNumLabel = UILabel.init()
        AdultNumLabel.text = "成人"
        AdultNumLabel.textAlignment = .center
        AdultNumLabel.textColor = UIColor.CustomColor(Red: 102, Green: 102, Blue: 102, Alpha: 1)
        AdultNumLabel.font = UIFont.systemFont(ofSize: 14)
        AdultNumLabel.backgroundColor = UIColor.CustomColor(Red: 240, Green: 240, Blue: 240, Alpha: 1)
        BackView.addSubview(AdultNumLabel)
        self.AdultNumLabel = AdultNumLabel
        AdultNumLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(CancelButton.snp.bottom)
            make.height.equalTo(40)
            make.width.equalTo(IPHONE_WIDTH / 2)
        }
        
        let ChildNumLabel = UILabel.init()
        ChildNumLabel.text = "儿童(2-12岁)"
        ChildNumLabel.textAlignment = .center
        ChildNumLabel.textColor = UIColor.CustomColor(Red: 102, Green: 102, Blue: 102, Alpha: 1)
        ChildNumLabel.font = UIFont.systemFont(ofSize: 14)
        ChildNumLabel.backgroundColor = UIColor.CustomColor(Red: 240, Green: 240, Blue: 240, Alpha: 1)
        BackView.addSubview(ChildNumLabel)
        self.ChildNumLabel = ChildNumLabel
        ChildNumLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(CancelButton.snp.bottom)
            make.height.equalTo(40)
            make.width.equalTo(IPHONE_WIDTH / 2)
        }
        
        let PickerView = UIPickerView.init()
        PickerView.delegate = self
        PickerView.dataSource = self
        PickerView.showsSelectionIndicator = true
        BackView.addSubview(PickerView)
        self.PickerView = PickerView
        PickerView.snp.remakeConstraints({ (make) in
            make.top.equalTo(80)
            make.bottom.right.left.equalToSuperview()
        })
        
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func AnimateZoom() {
        self.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.MaskView.alpha = 0.3
            self.BackView.transform = CGAffineTransform.init(translationX: 0, y: -self.BackView.frame.size.height)
        }
    }
    
    @objc func ConfirmClick() {
        if type == .Cabin {
            CabinRow = PickerView.selectedRow(inComponent: 0)
        }
        else {
            AdultNum = PickerView.selectedRow(inComponent: 0) + 1
            ChildNum = PickerView.selectedRow(inComponent: 1)
        }
        if delegate != nil {
            delegate?.PickerViewWithPicker(PickerView: self, AdultNum: AdultNum, ChildNum: ChildNum, CabinType: Canbin[CabinRow])
        }
        self.hide()
    }
    
    @objc func show() {
        self.AnimateZoom()
        PickerView.reloadAllComponents()
        if type == .Cabin {
            PickerView.selectRow(CabinRow, inComponent: 0, animated: false)
        }
        else {
            PickerView.selectRow(AdultNum - 1, inComponent: 0, animated: false)
            PickerView.selectRow(ChildNum, inComponent: 1, animated: false)
        }
    }

    @objc func hide() {
        AdultSeletedRow = AdultNum
        UIView.animate(withDuration: 0.3, animations: {
            self.MaskView.alpha = 0
            self.BackView.transform = CGAffineTransform.identity
        }) { (finished) in
            self.isHidden = true
        }
        if HideBlock != nil {
            HideBlock!("i'm already hide")
        }
        else {
            print("The Block is nil")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if type == .Cabin {
            return 1
        }
        else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if type == .Cabin {
            return Canbin.count
        }
        else {
            if component == 0 {
                return 9
            }
            else {
                if AdultSeletedRow <= 3 {
                    return AdultSeletedRow * 2 + 1
                }
                else {
                    return 10 - AdultSeletedRow
                }
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        for SingleLine:UIView in pickerView.subviews {
            if SingleLine.frame.size.height < 1 {
                SingleLine.backgroundColor = UIColor.lightGray
            }
        }
        
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.textAlignment = .center
        if type == .Cabin {
            label.text = Canbin[row]
        }
        else {
            label.text = String(format:"%ld",component == 0 ? row + 1 : row)
        }
        return label
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if type == .Cabin {
            
        }
        else {
            if component == 0 {
                AdultSeletedRow = row + 1
                pickerView.reloadComponent(1)
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == MaskView {
            return true
        }
        else {
            return false
        }
    }
}
