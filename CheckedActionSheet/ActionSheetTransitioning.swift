//
//  ActionSheetTransitioning.swift
//  CheckedActionSheet
//
//  Created by Tamas Bara on 13.01.18.
//  Copyright © 2018 Tamas Bara. All rights reserved.
//

import UIKit

class ActionSheetTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let targetViewController = transitionContext.viewController(forKey: .to) else {return}
        if targetViewController.isBeingPresented {
            if let actionSheetVC = targetViewController as? CheckedActionSheetViewController {
                actionSheetVC.backgroundView.alpha = 0
                actionSheetVC.contentPostion.constant = -400
                
                actionSheetVC.view.translatesAutoresizingMaskIntoConstraints = false
                transitionContext.containerView.addSubview(actionSheetVC.view)
                actionSheetVC.view.leadingAnchor.constraint(equalTo: transitionContext.containerView.leadingAnchor).isActive = true
                actionSheetVC.view.trailingAnchor.constraint(equalTo: transitionContext.containerView.trailingAnchor).isActive = true
                actionSheetVC.view.topAnchor.constraint(equalTo: transitionContext.containerView.topAnchor).isActive = true
                actionSheetVC.view.bottomAnchor.constraint(equalTo: transitionContext.containerView.bottomAnchor).isActive = true
                
                actionSheetVC.view.layoutIfNeeded()
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    actionSheetVC.backgroundView.alpha = 0.4
                    actionSheetVC.contentPostion.constant = 10
                    actionSheetVC.view.layoutIfNeeded()
                }, completion: { _ in
                    transitionContext.completeTransition(true)
                })
            }
        } else if let actionSheetVC = transitionContext.viewController(forKey: .from) as? CheckedActionSheetViewController {
            transitionContext.containerView.addSubview(actionSheetVC.view)
            actionSheetVC.view.layoutIfNeeded()
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                actionSheetVC.backgroundView.alpha = 0
                actionSheetVC.contentPostion.constant = -400
                actionSheetVC.view.layoutIfNeeded()
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        }
    }
}
