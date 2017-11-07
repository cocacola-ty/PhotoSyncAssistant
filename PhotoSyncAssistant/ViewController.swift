//
//  ViewController.swift
//  PhotoSyncAssistant
//
//  Created by fengtianyu on 26/10/17.
//  Copyright © 2017年 fengtianyu. All rights reserved.
//

import UIKit
import Foundation
import Photos
import SnapKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    let kCellMargin = 2
    let kLineMargin = 2
    let kCellCountInLine = 4
    let kPhotoCollectionViewCellId:String = "PhotoCollectionViewCellId"
    let kPhotoCollectionViewReuseHeaderId: String = "PhotoCollectionViewReuseHeaderId"
    
    var dataSource: Dictionary<String, Array<PHAsset>> = Dictionary<String, Array<PHAsset>>()
    var groups: Array<String> = Array()
    var assetArray: Array<PHAsset> = Array()
    
    
    //MARK: - Property
    lazy var collectionView:UICollectionView = {
        
        var itemSize = self.calculateItemSize()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.headerReferenceSize = CGSize.init(width: self.view.bounds.size.width, height: 44)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "照片"
        
        self.view.addSubview(self.collectionView)
        self.collectionView.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.delegate = self as UICollectionViewDelegate
        self.collectionView.dataSource = self as UICollectionViewDataSource
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPhotoCollectionViewCellId)
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kPhotoCollectionViewReuseHeaderId)
        
        self.fetchPhotos()
    }
    
    // MARK: - Private Method
    /** 计算Cell大小 */
    func calculateItemSize() -> Int {
        let screenWidth = UIScreen.main.bounds.size.width
        let itemWidth = (Int(screenWidth)-kCellMargin*(kCellCountInLine-1)) / kCellCountInLine
        
        return itemWidth
    }
    
    /* 获取图片资源 并进行分类 */
    func fetchPhotos() {
        // 日期格式设置
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        // 拿到'时刻'相册
        let collects = PHAssetCollection.fetchMoments(with: nil)
        
        for i in 0..<collects.count {
            
            // 拿到相册中的每一组照片资源
            let photoAssest = PHAsset.fetchAssets(in: collects[i], options: nil)
            
            // 遍历这一组资源，拿到每一个照片资源
            for i in 0..<photoAssest.count {
                
                let asset = photoAssest[i]
                
                let dateString = formatter.string(from: (asset.creationDate)!)
                
                if !self.groups.contains(dateString) {
                    self.groups.append(dateString)
                    
                    var assetArray = Array<PHAsset>()
                    assetArray.append(asset)
                    self.dataSource[dateString] = assetArray
                    
                }else {
                    // 已经有该日期的照片数组 更新该数组
                    var array = self.dataSource[dateString]
                    array!.append(asset)
                    self.dataSource[dateString] = array
                }
                self.assetArray.append(asset)
            }
            
        }
        
    }

    // MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionViewCellId, for: indexPath)
        
        let imageView:UIImageView = UIImageView()
        cell.contentView.addSubview(imageView)
        imageView.frame = cell.bounds
        
        // 获取资源
        let key = self.groups[indexPath.section]
        let array = self.dataSource[key]
        let asset = array![indexPath.row]
        
        let targetWidth = self.calculateItemSize()
        let targetSize = CGSize(width: targetWidth*2, height: targetWidth*2)
        
        // 设置获取图片时的配置
        let options = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        options.isSynchronous = false
        
        PHCachingImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFill, options: options) { (image, dict) in
            imageView.image = image
        }
        return cell
    }
    
    // 组头
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind.elementsEqual(UICollectionElementKindSectionHeader) {
            let key = self.groups[indexPath.section]
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoCollectionViewReuseHeaderId, for: indexPath)
            
            for view in headerView.subviews {
                view.removeFromSuperview()
            }
            
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15.0)
            titleLabel.text = key
            headerView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(headerView.snp.left).offset(8)
                make.centerY.equalTo(headerView.snp.centerY)
            })
            
            return headerView
        }else {
            let emptyView: UIView = UIView();
            return emptyView as! UICollectionReusableView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = self.groups[section]
        let array = self.dataSource[key]
        return array!.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc:TYPhotoDetailViewController = TYPhotoDetailViewController()
        detailVc.assetArray = self.assetArray
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

