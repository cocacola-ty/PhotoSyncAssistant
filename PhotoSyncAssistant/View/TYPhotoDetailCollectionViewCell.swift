//
//  TYPhotoDetailCollectionViewCell.swift
//  PhotoSyncAssistant
//
//  Created by fengtianyu on 7/11/17.
//  Copyright © 2017年 fengtianyu. All rights reserved.
//

import UIKit

class TYPhotoDetailCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.width.equalTo(self.contentView.snp.width)
            make.height.equalTo(self.contentView.snp.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
