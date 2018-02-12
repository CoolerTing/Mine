//
//  FirstTransition.swift
//  Mine
//
//  Created by coolerting on 2018/2/11.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

class FirstTransition: NSObject ,UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController:RootViewController = transitionContext.viewController(forKey: .from) as! RootViewController
        let toViewController:FirstViewController = transitionContext.viewController(forKey: .to) as! FirstViewController
        
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        
        let cell:RootTableViewCell = fromViewController.MainTableView?.cellForRow(at: (fromViewController.MainTableView?.indexPathForSelectedRow)!) as! RootTableViewCell
        let cellImageSnapshot = cell.imageview?.snapshotView(afterScreenUpdates: false)
        cellImageSnapshot?.frame = containerView.convert((cell.imageview?.frame)!, from: cell.imageview?.superview)
        cell.imageview?.isHidden = true
        
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        toViewController.view.alpha = 0
        toViewController.imageview?.isHidden = true
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(cellImageSnapshot!)
        
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
            fromViewController.HeaderView?.alpha = 0
            let frame = containerView.convert((toViewController.imageview?.frame)!, from: toViewController.view)
            cellImageSnapshot?.frame = frame
            
        }) { (finished) in
            toViewController.imageview?.isHidden = false
            fromViewController.HeaderView?.alpha = 1
            cell.imageview?.isHidden = false
            cellImageSnapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    

}
