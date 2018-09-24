//
//  TitleImageCell.swift
//  ResizinExample
//
//  Created by Jakub Olejník on 14/02/2018.
//  Copyright © 2018 Ackee. All rights reserved.
//

import UIKit

final class TitleImageCell: UITableViewCell {
    weak var titleLabel: UILabel!
    weak var imageView2: UIImageView! // stupid UITableViewCell
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview().inset(10)
        }
        self.titleLabel = titleLabel
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.imageSize)
        }
        self.imageView2 = imageView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
