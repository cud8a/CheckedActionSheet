//
//  ViewController.swift
//  CheckedActionSheet
//
//  Created by Tamas Bara on 13.01.18.
//  Copyright © 2018 Tamas Bara. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ViewController: UIViewController {

    let transitioning = ActionSheetTransitioning()
    
    var selection: CheckedItemModel?
    
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4)
        actionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
    }
    
    @IBAction func btnClicked(_ sender: Any) {

        var items: [CheckedItemModel] = []
        var item = CheckedItemModel(faCode: "fa-paypal", text: "Paypal")
        item.preselected = selection?.text == item.text
        items.append(item)
        
        item = CheckedItemModel(faCode: "fa-credit-card", text: "Credit Card")
        item.preselected = selection?.text == item.text
        items.append(item)
        
        item = CheckedItemModel(faCode: "fa-google-wallet", text: "Google Wallet")
        item.preselected = selection?.text == item.text
        items.append(item)
        
        item = CheckedItemModel(faCode: "fa-amazon", text: "Amazon Pay")
        item.preselected = selection?.text == item.text
        items.append(item)
        
        item = CheckedItemModel(faCode: "fa-apple", text: "Apple Pay")
        item.preselected = selection?.text == item.text
        items.append(item)
        
        let viewController = CheckedActionSheetViewController(items: items)
        viewController.delegate = self
        
        present(viewController, animated: true, completion: nil)
    }
}

extension ViewController: CheckedActionSheetViewControllerDelegate {
    func didSelectItem(_ item: CheckedItemModel) {
        selection = item
        actionButton.setImage(UIImage.fontAwesomeIcon(code: item.faCode, textColor: .blue, size: CGSize(width: 32, height: 32)), for: .normal)
    }
}
