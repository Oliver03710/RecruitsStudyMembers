//
//  BackgroundCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/15.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class BackgroundCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .bottom
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
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindData()
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [backgroundImageView, titleLabel, descriptionLabel, purchaseButton].forEach { contentView.addSubview($0) }
        
        backgroundImageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.height.equalTo(164)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.centerY.equalTo(backgroundImageView).dividedBy(1.4)
            $0.width.equalTo(56)
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(purchaseButton)
            $0.leading.equalTo(backgroundImageView.snp.trailing).offset(12)
            $0.trailing.equalTo(purchaseButton.snp.leading)
            $0.height.equalTo(purchaseButton.snp.height).multipliedBy(1.05)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(purchaseButton.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview()
        }
        
    }
    
    private func bindData() {
        purchaseButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self, let products = SKManager.shared.products else { return }
                SKManager.shared.purchase(productParam: products[self.purchaseButton.tag - 1])
            }
            .disposed(by: disposeBag)
    }
    
    func ConfigureCells(item: BackgroundImages) {
        backgroundImageView.image = item.images
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        purchaseButton.tag = item.rawValue
        
        if NetworkManager.shared.shopState.backgroundCollection.contains(item.rawValue) {
            purchaseButton.configuration = purchaseButton.buttonConfiguration(text: "보유", config: .plain(), foregroundColor: SSColors.gray7.color, font: SSFonts.title5M12.fonts, size: SSFonts.title5M12.size, lineHeight: SSFonts.title5M12.lineHeight)
            purchaseButton.backgroundColor = SSColors.gray2.color
            purchaseButton.isUserInteractionEnabled = false
            
        } else {
            purchaseButton.configuration = purchaseButton.buttonConfiguration(text: SKManager.shared.prices[item.rawValue - 1], config: .plain(), foregroundColor: SSColors.white.color, font: SSFonts.title5M12.fonts, size: SSFonts.title5M12.size, lineHeight: SSFonts.title5M12.lineHeight)
            purchaseButton.backgroundColor = SSColors.green.color
            purchaseButton.isUserInteractionEnabled = true
        }
    }
}
