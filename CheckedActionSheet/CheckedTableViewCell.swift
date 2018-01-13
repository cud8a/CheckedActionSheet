//
//  CheckedTableViewCell.swift
//  CheckedActionSheet
//
//  Created by Tamas Bara on 13.01.18.
//  Copyright © 2018 Tamas Bara. All rights reserved.
//

import UIKit

protocol CheckedTableViewCellDelegate: class {
    func didSelectItemBegan(_ item: CheckedTableViewCell)
    func didSelectItemEnded(_ item: CheckedTableViewCell)
}

class CheckedTableViewCell: UITableViewCell {

    @IBOutlet weak var labelIcon: UILabel!
    @IBOutlet weak var labelTexxt: UILabel!
    @IBOutlet weak var labelChecked: UILabel!
    
    weak var delegate: CheckedTableViewCellDelegate?
    
    var index = 0
    
    var checked = false {
        didSet {
            labelChecked.text = checked ? String.fontAwesomeIcon(code: "fa-check") : ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelIcon.font = UIFont.fontAwesome(ofSize: 20)
        labelChecked.font = UIFont.fontAwesome(ofSize: 20)
        
        let recog = UILongPressGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        recog.minimumPressDuration = 0
        addGestureRecognizer(recog)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    }
    
    @objc func handleGesture(_ sender: UIGestureRecognizer) {
        if sender.state == .began {
            checked = true
            delegate?.didSelectItemBegan(self)
        } else {
            delegate?.didSelectItemEnded(self)
        }
    }
}
