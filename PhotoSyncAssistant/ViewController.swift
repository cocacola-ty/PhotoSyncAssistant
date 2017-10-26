//
//  ViewController.swift
//  PhotoSyncAssistant
//
//  Created by fengtianyu on 26/10/17.
//  Copyright © 2017年 fengtianyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    let kCellMargin = 2
    let kLineMargin = 2
    let kCellCountInLine = 4
    let kPhotoCollectionViewCellId:String = "PhotoCollectionViewCellId"
    
    //MARK: Property
    lazy var collectionView:UICollectionView = {
        
        var itemSize = self.calculateItemSize()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "照片"
        
        self.view.addSubview(self.collectionView)
        self.collectionView.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.delegate = self as UICollectionViewDelegate
        self.collectionView.dataSource = self as UICollectionViewDataSource
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPhotoCollectionViewCellId)
    }
    
    // MARK: Private Method
    func calculateItemSize() -> Int {
        let screenWidth = UIScreen.main.bounds.size.width
        let itemWidth = (Int(screenWidth)-kCellMargin*(kCellCountInLine-1)) / kCellCountInLine
        
        return itemWidth
    }

    // MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionViewCellId, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

