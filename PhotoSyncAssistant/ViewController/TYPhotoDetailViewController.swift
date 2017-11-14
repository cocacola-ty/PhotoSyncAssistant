//
//  TYPhotoDetailViewController.swift
//  PhotoSyncAssistant
//
//  Created by fengtianyu on 6/11/17.
//  Copyright © 2017年 fengtianyu. All rights reserved.
//

import UIKit
import Photos

class TYPhotoDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let kTYPhotoDetailViewCellReuseId = "TYPhotoDetailViewCellReuseId"
    
    let kScreenWidth = UIScreen.main.bounds.size.width
    let kScreenHeight = UIScreen.main.bounds.size.height
    
    var assetArray:Array<PHAsset>?
    var index:NSInteger?
    
    
    lazy var collectionView:UICollectionView = {
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.addSubview(self.collectionView)
        self.collectionView.frame = self.view.bounds
        self.collectionView.delegate = self as UICollectionViewDelegate
        self.collectionView.dataSource = self as UICollectionViewDataSource
        self.collectionView.register(TYPhotoDetailCollectionViewCell.self, forCellWithReuseIdentifier: kTYPhotoDetailViewCellReuseId)

        self.collectionView.scrollToItem(at: IndexPath(item: self.index!, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func updateViewConstraints() {

        super.updateViewConstraints()
    }
    // MARK: - Public Method
    
    // MARK: - Event Response
    
    // MARK: - Private Method
    
    // MARK: - Delegate & DataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TYPhotoDetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kTYPhotoDetailViewCellReuseId, for: indexPath) as! TYPhotoDetailCollectionViewCell
        
        PHCachingImageManager.default().requestImage(for: self.assetArray![indexPath.row], targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFit, options: nil) { (image, info) in
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetArray!.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    // MARK: - Getter & Setter

}
