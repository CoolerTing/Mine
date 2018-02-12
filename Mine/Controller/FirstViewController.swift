//
//  FirstViewController.swift
//  Mine
//
//  Created by coolerting on 2018/2/11.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {
    
    var label:UILabel!
    var path:UIBezierPath!
    var Shape:CAShapeLayer!
    var Image:UIImage!
    var imageview:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "FirstView"
        self.view.backgroundColor = UIColor.white
        
        let imageview = UIImageView.init()
        imageview.image = self.Image
        self.view.addSubview(imageview)
        self.imageview = imageview
        imageview.snp.makeConstraints { (make) in
            make.left.top.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(imageview.snp.width)
        }
        self.view.layoutIfNeeded()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
