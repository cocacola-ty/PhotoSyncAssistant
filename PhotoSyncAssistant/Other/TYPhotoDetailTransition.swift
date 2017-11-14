//
//  TYPhotoDetailTransition.swift
//  PhotoSyncAssistant
//
//  Created by fengtianyu on 14/11/17.
//  Copyright © 2017年 fengtianyu. All rights reserved.
//

import UIKit

class TYPhotoDetailTransition: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVc:ViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ViewController
        let toVc:TYPhotoDetailViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! TYPhotoDetailViewController
        let containerView = transitionContext.containerView
        
        // 拿到fromVc的cell
        let cell = fromVc.collectionView.cellForItem(at: fromVc.indexPath!)
        // 转换cell的frame到containerView
        let rect = cell!.convert(cell!.frame, to: containerView)
        
        let imageView = UIImageView()
        imageView.frame = rect
        containerView.addSubview(imageView)
        
        containerView.addSubview(toVc.view)
        toVc.view.alpha = 1
        
        UIView.animate(withDuration: 0.25, animations: {
            
        }) { (complete) in
            
        }
    }
}
