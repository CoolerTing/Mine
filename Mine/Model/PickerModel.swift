//
//  PickerModel.swift
//  Mine
//
//  Created by coolerting on 2018/2/12.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

class PickerModel: NSObject {
    var CabinType:String!
    
    convenience init(Dic:Dictionary<String, String>) {
        self.init()
        CabinType = Dic["Words"] ?? ""
    }
}
