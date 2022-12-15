//
//  FaceCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/15.
//

import UIKit

import SnapKit

final class FaceCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let faceImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFit
        iv.layer.borderColor = SSColors.gray2.color.cgColor
        iv.layer.borderWidth = 1
        return iv
    }()
    
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(text: "", font: SSFonts.title2R16.fonts, size: SSFonts.title2R16.size)
        return label
    }()
    
    private let descriptionLabel: CustomLabel = {
        let label = CustomLabel(text: "", font: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size)
        label.numberOfLines = 0
        return label
    }()
    
    private let purchaseButton: CircleButton = {
        let btn = CircleButton(text: "", font: SSFonts.title5M12.fonts, size: SSFonts.title5M12.size, lineHeight: SSFonts.title5M12.lineHeight, config: .plain(), foregroundColor: SSColors.white.color, backgroundColor: SSColors.green.color)
        return btn
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [faceImageView, titleLabel, descriptionLabel, purchaseButton].forEach { contentView.addSubview($0) }
        
        faceImageView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(faceImageView.snp.width)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.top.equalTo(faceImageView.snp.bottom).offset(12)
            $0.width.equalTo(56)
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(purchaseButton)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(purchaseButton.snp.leading)
            $0.height.equalTo(purchaseButton.snp.height).multipliedBy(1.05)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(purchaseButton.snp.bottom).offset(12)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
    }
    
    func ConfigureCells(image: UIImage?, title: String?, description: String?, price: String) {
        faceImageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
        
        if price == "보유" {
            purchaseButton.configuration = purchaseButton.buttonConfiguration(text: price, config: .plain(), foregroundColor: SSColors.gray7.color, font: SSFonts.title5M12.fonts, size: SSFonts.title5M12.size, lineHeight: SSFonts.title5M12.lineHeight)
            purchaseButton.backgroundColor = SSColors.gray2.color
        } else {
            purchaseButton.configuration = purchaseButton.buttonConfiguration(text: price, config: .plain(), foregroundColor: SSColors.white.color, font: SSFonts.title5M12.fonts, size: SSFonts.title5M12.size, lineHeight: SSFonts.title5M12.lineHeight)
            purchaseButton.backgroundColor = SSColors.green.color
        }
    }
}
