//
//  CustomExpandButtonCell.swift
//  NormalExample
//
//  Created by Jie Zhang on 2020/4/15.
//  Copyright © 2020 Green Dot. All rights reserved.
//

import UIKit

class CustomExpandButtonCellItem: ZJExpandTreeCellItem {
    var title: String?
    var buttonTapCallBack: ((CustomExpandButtonCellItem) -> ())?

    override init() {
        super.init()
        // 取消默认的点击展开处理
        self.selectionHandler = nil
        self.buttonTapCallBack = { callBackItem in
            callBackItem.toggleExpand()
        }
    }

    @discardableResult override func toggleExpand() -> Bool {
        let bool = super.toggleExpand()
        // 展开事件结束后修改cell上面的按钮的标题
        if let cell = cell as? CustomExpandButtonCell {
            // 理论上是要尽量避免直接修改cell上面的控件的值，我这里修改了btnExpand.isSelected属性，同时在cellWillAppear()里面设置btnExpand.isSelected = item.isExpand，确保是一致的。这样不会有复用的问题。
            cell.btnExpand.isSelected = bool
        }
        return bool
    }
}

class CustomExpandButtonCell: UITableViewCell, ZJCellProtocol {
    var item: CustomExpandButtonCellItem!
    typealias ZJCelltemClass = CustomExpandButtonCellItem
    @IBOutlet var btnExpand: UIButton!
    @IBOutlet var labelTitle: UILabel!
    func cellWillAppear() {
        btnExpand.isSelected = item.isExpand
        labelTitle.text = item.title
    }

    @IBAction func actionExpand(_ sender: Any) {
        item.buttonTapCallBack?(item)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
