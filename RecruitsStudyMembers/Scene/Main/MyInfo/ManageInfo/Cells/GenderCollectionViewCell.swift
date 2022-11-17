//
//  GenderCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/17.
//

import UIKit

import SnapKit

final class GenderCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let genderLabel: CustomLabel = {
        let label = CustomLabel(text: "내 성별")
        return label
    }()
    
    private let maleButton: CustomButton = {
        let btn = CustomButton(text: "남자", borderColor: SSColors.green.color, backgroundColor: SSColors.green.color)
        return btn
    }()
    
    private let femaleButton: CustomButton = {
        let btn = CustomButton(text: "여자", borderColor: SSColors.gray3.color)
        return btn
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        layoutIfNeeded()
        return layoutAttributes
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [genderLabel, maleButton, femaleButton].forEach { contentView.addSubview($0) }
        
        femaleButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(48)
            $0.width.equalTo(femaleButton.snp.height).multipliedBy(1.16)
        }
        
        maleButton.snp.makeConstraints {
            $0.trailing.equalTo(femaleButton.snp.leading).offset(-12)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(48)
            $0.width.equalTo(maleButton.snp.height).multipliedBy(1.16)
        }
        
        genderLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(16)
//            $0.leading.equalTo(safeAreaLayoutGuide)
//            $0.centerY.equalTo(safeAreaLayoutGuide)
//            $0.height.equalTo(maleButton).inset(12)
//            $0.width.equalTo(genderLabel.snp.height).multipliedBy(3)
        }
    }
    
}
