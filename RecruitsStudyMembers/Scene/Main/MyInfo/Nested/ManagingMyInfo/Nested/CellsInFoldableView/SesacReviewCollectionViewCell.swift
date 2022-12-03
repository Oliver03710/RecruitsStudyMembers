//
//  SesacReviewCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/22.
//

import UIKit

import SnapKit

final class SesacReviewCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size)
        label.textColor = SSColors.gray6.color
        return label
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(8)
        }
    }
    
    func setComponents(text: String?) {
        titleLabel.text = text
    }
}
