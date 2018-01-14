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
    
    var selection: CheckedItemModel?
    
    @IBOutlet weak var actionButton: UIButton!
    
    var items: [CheckedItemModel] = {
        var items: [CheckedItemModel] = []
        items.append(CheckedItemModel(faCode: "fa-paypal", text: "Paypal"))
        items.append(CheckedItemModel(faCode: "fa-credit-card", text: "Credit Card"))
        items.append(CheckedItemModel(faCode: "fa-google-wallet", text: "Google Wallet"))
        items.append(CheckedItemModel(faCode: "fa-amazon", text: "Amazon Pay"))
        items.append(CheckedItemModel(faCode: "fa-apple", text: "Apple Pay"))
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4)
        actionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
        
        selection = items[Int(arc4random_uniform(UInt32(items.count)))]
        actionButton.setImage(UIImage.fontAwesomeIcon(code: selection!.faCode, textColor: .blue, size: CGSize(width: 32, height: 32)), for: .normal)
    }
    
    @IBAction func btnClicked(_ sender: Any) {
        guard let selectionIndex = items.index(where: {$0.text == selection?.text}) else {return}
        
        let viewController = CheckedActionSheetViewController(items: items, selected: selectionIndex)
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
