//
//  Define.swift
//  Mine
//
//  Created by coolerting on 2018/2/9.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

let IPHONE_WIDTH = UIScreen.main.bounds.size.width
let IPHONE_HEIGHT = UIScreen.main.bounds.size.height
let IS_IPHONE_X = (IPHONE_WIDTH == 375 && IPHONE_HEIGHT == 812) ? true : false
let IPHONE_NAVIGATIONBAR_HEIGHT = (IS_IPHONE_X ? 88 : 64)
let IPHONE_STATUSBAR_HEIGHT = (IS_IPHONE_X ? 44 : 20)
let IPHONE_SAFEBOTTOMAREA_HEIGHT = (IS_IPHONE_X ? 34 : 0)
let IPHONE_TOPSENSOR_HEIGHT = (IS_IPHONE_X ? 32 : 0)


extension UIColor{
    
    class func CustomColor(Red:CGFloat, Green:CGFloat, Blue:CGFloat, Alpha:CGFloat) -> UIColor {
        let color:UIColor = UIColor.init(red: Red / 255.0, green: Green / 255.0, blue: Blue / 255.0, alpha: Alpha)
        return color
    }
    
}

