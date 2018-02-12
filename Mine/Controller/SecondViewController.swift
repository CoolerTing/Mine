//
//  SecondViewController.swift
//  Mine
//
//  Created by coolerting on 2018/2/11.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit


class SecondViewController: BaseViewController,UIGestureRecognizerDelegate {

    var SearchView:UIView!
    
    private var text:UITextField!
    private var LoginButton:UIButton!
    private var CircleView:UIView!
    private var ViewControllersCount:Int?
    private var timer:Timer? = nil
    
    var count = 1
    var radio:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        let CancelButton = UIButton.init(type: .custom)
        CancelButton.setTitleColor(UIColor.black, for: .normal)
        CancelButton.setTitle("取消", for: .normal)
        CancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        CancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(CancelButton)
        CancelButton.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.height.equalTo(30)
            make.width.equalTo(70)
        }
        
        let SearchView = UIView.init()
        SearchView.layer.cornerRadius = 2
        self.view.addSubview(SearchView)
        self.SearchView = SearchView
        SearchView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.height.top.equalTo(30)
            make.right.equalTo(CancelButton.snp.left)
        }
        
        let text = UITextField.init()
        text.placeholder = "请输入商家、商品名称"
        text.borderStyle = .roundedRect
        text.contentVerticalAlignment = .center
        text.autocapitalizationType = .none
        let image = UIImageView.init(image: UIImage.init(named: "home_search"))
        text.leftView = image
        text.leftViewMode = .always
        text.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
        SearchView.addSubview(text)
        self.text = text
        text.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let LoginButton = UIButton.init(type: .custom)
        LoginButton.backgroundColor = UIColor.CustomColor(Red: 0, Green: 134, Blue: 255, Alpha: 1)
        LoginButton.setTitle("登录", for: .normal)
        LoginButton.setTitleColor(UIColor.white, for: .normal)
        LoginButton.setTitle("帐号或密码错误", for: .selected)
        LoginButton.setTitleColor(UIColor.white, for: .selected)
        LoginButton.setTitle("登录成功", for: .disabled)
        LoginButton.setTitleColor(UIColor.white, for: .disabled)
        LoginButton.addTarget(self, action: #selector(Login), for: .touchUpInside)
        LoginButton.layer.cornerRadius = 20
        self.view.addSubview(LoginButton)
        self.LoginButton = LoginButton
        LoginButton.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(40)
            make.bottom.equalTo(-40)
        }
        
        let CircleView = UIView.init()
        CircleView.isHidden = true
        self.view.addSubview(CircleView)
        self.CircleView = CircleView
        CircleView.snp.makeConstraints { (make) in
            make.left.equalTo(IPHONE_WIDTH / 2 - 15)
            make.right.equalTo(-(IPHONE_WIDTH / 2 - 15))
            make.height.equalTo(30)
            make.centerY.equalTo(LoginButton.snp.centerY)
        }
        CircleView.layoutIfNeeded()
        
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.frame = CircleView.bounds
        shapeLayer.strokeEnd = 0.7
        shapeLayer.strokeStart = 0.1
        shapeLayer.lineCap = "round"
        let path = UIBezierPath.init(ovalIn: CircleView.bounds)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = UIColor.white.cgColor
        CircleView.layer.addSublayer(shapeLayer)
        
        
        let circle = CircleRatio.init(frame: CGRect.init(x: 100, y: 100, width: 60, height: 60))
        circle.font = UIFont.systemFont(ofSize: 20)
        circle.ratio = 0
        circle.text = "开始"
        self.view.addSubview(circle)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (time) in
            self.radio += 1
            circle.ratio = self.radio / 100
            circle.text = "\(self.radio)%"
            if self.radio == 100 {
                circle.text = "完成"
                time.invalidate()
            }
        }
        RunLoop.current.add(timer!, forMode: .commonModes)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ViewControllersCount = self.navigationController!.viewControllers.count
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.navigationController == nil {
            timer?.invalidate()
        }

    }

    @objc func cancel() {
        if LoginButton.isEnabled {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            LoginButton.isEnabled = true
        }
    }
    
    @objc func Login() {
        count += 1
        LoginButton.isSelected = false
        UIView.animate(withDuration: 0.2, animations: {
            self.LoginButton.titleLabel?.alpha = 0
            self.LoginButton.snp.updateConstraints({ (make) in
                make.left.equalTo(IPHONE_WIDTH / 2 - 20)
                make.right.equalTo(-(IPHONE_WIDTH / 2 - 20))
            })
            self.LoginButton.layoutIfNeeded()
        }) { (finished) in
            self.CircleView.isHidden = false
            self.RotateAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.CircleView.isHidden = true
                self.CircleView.layer.removeAllAnimations()
                if self.count == 3
                {
                    self.LoginButton.isEnabled = false
                    UIView.animate(withDuration: 0.2, animations: {
                        self.LoginButton.titleLabel?.alpha = 1
                        self.LoginButton.snp.updateConstraints({ (make) in
                            make.left.equalTo(50)
                            make.right.equalTo(-50)
                        })
                        self.LoginButton.layoutIfNeeded()
                    }, completion: { (finished) in
                        let alertController = UIAlertController.init(title: "登录成功", message: "登录成功了耶~你开不开心，哈不哈皮，是不是想上天。。。", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction.init(title: "我高兴得一匹^_^", style: .default, handler: { (action) in
                            UIApplication.shared.open(URL.init(string: String(format:"tel://%@","1234567890"))!, options: Dictionary(), completionHandler: nil)
                        }))
                        alertController.addAction(UIAlertAction.init(title: "我不想登录了-_-\"", style: .cancel, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    })
                    self.count = 0
                }
                else
                {
                    self.LoginButton.isSelected = true
                    self.LoginButton.titleLabel?.alpha = 1
                    self.LoginButton.snp.updateConstraints({ (make) in
                        make.left.equalTo(50)
                        make.right.equalTo(-50)
                    })
                    self.LoginButton.layoutIfNeeded()
                    self.ShakeAnimation()
                }
            })
        }
    }
    
    func RotateAnimation() {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        animation.fromValue = 0
        animation.toValue = 2 * CGFloat.pi
        CircleView.layer.add(animation, forKey: "rotate-layer")
    }
    
    func ShakeAnimation() {
        let animation = CAKeyframeAnimation.init(keyPath: "transform.rotation")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.values = [ANGLE_TO_RADIAN(angle: -3),ANGLE_TO_RADIAN(angle: 3),ANGLE_TO_RADIAN(angle: -3),ANGLE_TO_RADIAN(angle: 0)]
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        LoginButton.layer.add(animation, forKey: "shake")
    }
    
    func ANGLE_TO_RADIAN(angle:CGFloat) -> CGFloat {
        return angle / 180 * CGFloat.pi
    }
    
    deinit {
        print("it's over")
    }
    
}
