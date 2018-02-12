//
//  CircleRatio.swift
//  Mine
//
//  Created by coolerting on 2018/2/11.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

class CircleRatio: UIView {

    var ratio:CGFloat?{
        didSet {
            FirstView.layer.mask = self.createMaskLayerWithView(view: FirstView)
        }
    }
    var text:String?{
        didSet {
            FirstView.text = text
            LastView.text = text
        }
    }
    var font:UIFont?{
        didSet {
            FirstView.font = font
            LastView.font = font
        }
    }
    private var FirstView:UILabel!
    private var LastView:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.backgroundColor = UIColor.orange.cgColor
        self.layer.cornerRadius = frame.size.width / 2
        
        let LastView = UILabel.init()
        LastView.layer.backgroundColor = UIColor.white.cgColor
        LastView.textColor = UIColor.orange
        LastView.textAlignment = .center
        LastView.adjustsFontSizeToFitWidth = true
        LastView.minimumScaleFactor = 0.5
        LastView.layer.cornerRadius = frame.size.width / 2 - 1
        self.addSubview(LastView)
        self.LastView = LastView
        LastView.snp.makeConstraints { (make) in
            make.height.width.equalTo(frame.size.width - 2)
            make.center.equalToSuperview()
        }
        
        let FirstView = UILabel.init()
        FirstView.layer.backgroundColor = UIColor.orange.cgColor
        FirstView.textColor = UIColor.white
        FirstView.textAlignment = .center
        FirstView.adjustsFontSizeToFitWidth = true
        FirstView.minimumScaleFactor = 0.5
        FirstView.layer.cornerRadius = frame.size.width / 2 - 1
        self.addSubview(FirstView)
        self.FirstView = FirstView
        FirstView.snp.makeConstraints { (make) in
            make.height.width.equalTo(frame.size.width - 2)
            make.center.equalToSuperview()
        }
        FirstView.layoutIfNeeded()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMaskLayerWithView(view:UIView) -> CAShapeLayer {
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        
        let Ratio = 1 - ratio!
        
        let point1 = CGPoint.init(x: 0, y: viewHeight)
        let point2 = CGPoint.init(x: viewWidth, y: viewHeight)
        let point3 = CGPoint.init(x: viewWidth, y: viewHeight * Ratio)
        let point4 = CGPoint.init(x: 0, y: viewHeight * Ratio)
        
        let path = UIBezierPath.init()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        path.close()
        
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        
        return layer
    }
    
}
