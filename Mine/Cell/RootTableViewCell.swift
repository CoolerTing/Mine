//
//  RootTableViewCell.swift
//  Mine
//
//  Created by coolerting on 2018/2/11.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

class RootTableViewCell: UITableViewCell {

    var imageview:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected == true {
            self.accessoryType = .checkmark
        }
        else
        {
            self.accessoryType = .none
        }
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let imageview = UIImageView.init()
        self.addSubview(imageview)
        self.textLabel?.text = "-"
        self.imageview = imageview
        imageview.snp.makeConstraints { (make) in
            make.left.equalTo((self.textLabel?.snp.left)!)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(imageview.snp.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func CellWithTableView(tableview:UITableView) -> RootTableViewCell {
        var Root = tableview.dequeueReusableCell(withIdentifier: "RootCell")
        if Root == nil {
            Root = RootTableViewCell.init(style: .default, reuseIdentifier: "RootCell")
        }
        Root?.selectionStyle = .none
        return Root as! RootTableViewCell
    }

}

