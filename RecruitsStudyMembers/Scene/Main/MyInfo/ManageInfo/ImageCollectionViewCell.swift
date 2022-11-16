//
//  ManageInfoCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import SnapKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let foreImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
    private func setConstraints() {
        [foreImageView, nameLabel].forEach { contentView.addSubview($0) }
        
        foreImageView.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY).multipliedBy(1.2)
            $0.width.equalTo(self.snp.width).dividedBy(2)
            $0.height.equalTo(foreImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges)
        }
    }
    
}
