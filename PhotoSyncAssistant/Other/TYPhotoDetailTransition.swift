//
//  TYPhotoDetailTransition.swift
//  PhotoSyncAssistant
//
//  Created by fengtianyu on 14/11/17.
//  Copyright © 2017年 fengtianyu. All rights reserved.
//

import UIKit
import Photos

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
        let rect = cell!.convert(cell!.bounds, to: containerView)
        
        let imageView = UIImageView()
        imageView.frame = rect
        imageView.backgroundColor = UIColor.black
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        containerView.addSubview(imageView)

        let option = PHImageRequestOptions()
        option.isSynchronous = true
        PHCachingImageManager.default().requestImage(for: fromVc.selectAsset!, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFit, options: option) { (image, info) in
            imageView.image = image
        }
        
        containerView.addSubview(toVc.view)
        toVc.view.alpha = 0
        toVc.collectionView.isHidden = true
        
        UIView.animate(withDuration: 0.25, animations: {
            imageView.frame = UIScreen.main.bounds
            toVc.view.alpha = 1
        }) { (complete) in
            imageView.isHidden = true
            toVc.collectionView.isHidden = false
            transitionContext.completeTransition(true)
        }
    }
}
