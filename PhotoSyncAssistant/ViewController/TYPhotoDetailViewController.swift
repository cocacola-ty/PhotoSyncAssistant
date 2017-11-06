//
//  TYPhotoDetailViewController.swift
//  PhotoSyncAssistant
//
//  Created by fengtianyu on 6/11/17.
//  Copyright © 2017年 fengtianyu. All rights reserved.
//

import UIKit

class TYPhotoDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let kTYPhotoDetailViewCellReuseId = "TYPhotoDetailViewCellReuseId"
    
    let kScreenWidth = UIScreen.main.bounds.size.width
    let kScreenHeight = UIScreen.main.bounds.size.height
    
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
        
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self as UICollectionViewDelegate
        self.collectionView.dataSource = self as UICollectionViewDataSource
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kTYPhotoDetailViewCellReuseId)
    }

    override func updateViewConstraints() {
        self.collectionView.snp.remakeConstraints { (make) in
            make.left.equalTo(self.view.snp.left)
            make.top.equalTo(self.view.snp.top)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.snp.height)
        }
        super.updateViewConstraints()
    }
    // MARK: - Public Method
    
    // MARK: - Event Response
    
    // MARK: - Private Method
    
    // MARK: - Delegate & DataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTYPhotoDetailViewCellReuseId, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    // MARK: - Getter & Setter

}
