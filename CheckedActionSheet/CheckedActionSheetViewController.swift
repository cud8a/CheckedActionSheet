//
//  CheckedActionSheetViewController.swift
//  CheckedActionSheet
//
//  Created by Tamas Bara on 13.01.18.
//  Copyright © 2018 Tamas Bara. All rights reserved.
//

import UIKit

protocol CheckedActionSheetViewControllerDelegate: class {
    func didSelectItem(_ item: CheckedItemModel)
}

class CheckedActionSheetViewController: UIViewController {
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentPostion: NSLayoutConstraint!
    
    weak var delegate: CheckedActionSheetViewControllerDelegate?
    
    var items: [CheckedItemModel]?
    
    var selected = 0
    
    init(items: [CheckedItemModel], selected: Int) {
        self.items = items
        self.selected = selected
        super.init(nibName: "CheckedActionSheetViewController", bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCancel.layer.cornerRadius = 14
        tableView.layer.cornerRadius = 14

        tableView.register(UINib(nibName: "CheckedTableViewCell", bundle: nil), forCellReuseIdentifier: "checkedCell")
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension CheckedActionSheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = items?[safeIndex: indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: "checkedCell") as? CheckedTableViewCell else { return UITableViewCell() }
        
        cell.labelIcon.text = item.faIcon
        cell.labelTexxt.text = item.text
        cell.checked = selected == indexPath.row
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension CheckedActionSheetViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ActionSheetTransitioning()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ActionSheetTransitioning()
    }
}

// MARK: - CheckedTableViewCellDelegate
extension CheckedActionSheetViewController: CheckedTableViewCellDelegate {
    func didSelectItemBegan(_ item: CheckedTableViewCell) {
        guard selected != item.index else {return}
        if let cell = tableView.cellForRow(at: IndexPath(row: selected, section: 0)) as? CheckedTableViewCell {
            cell.checked = false
        }
    }
    
    func didSelectItemEnded(_ item: CheckedTableViewCell) {
        if selected != item.index, let item = items?[safeIndex: item.index] {
            delegate?.didSelectItem(item)
        }
        dismiss(animated: true, completion: nil)
    }
}
