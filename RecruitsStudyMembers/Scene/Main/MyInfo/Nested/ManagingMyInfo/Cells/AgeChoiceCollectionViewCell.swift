//
//  AgeChoiceCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/18.
//

import UIKit

import SnapKit

final class AgeChoiceCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let ageLabel: CustomLabel = {
        let label = CustomLabel(text: "상대방 연령대", font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size)
        return label
    }()
    
    private let ageRangeLabel: CustomLabel = {
        let label = CustomLabel(text: "\(NetworkManager.shared.userData.ageMin) - \(NetworkManager.shared.userData.ageMax)", font: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size)
        label.textColor = SSColors.green.color
        label.font = UIFont(name: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size)
        return label
    }()
    
    lazy var slider: CustomSlider = {
        let slider = CustomSlider()
        slider.minValue = 18
        slider.maxValue = 65
        slider.lower = Double(NetworkManager.shared.userData.ageMin)
        slider.upper = Double(NetworkManager.shared.userData.ageMax)
        slider.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        return slider
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Selector
    
    @objc func valueChanged() {
        let min = Int(slider.lower)
        let max = Int(slider.upper)
        ageRangeLabel.text = "\(min) - \(max)"
        NetworkManager.shared.userData.ageMin = min
        NetworkManager.shared.userData.ageMax = max
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [ageLabel, ageRangeLabel, slider].forEach { contentView.addSubview($0) }
                
        ageLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        ageRangeLabel.snp.makeConstraints {
            $0.trailing.equalTo(ageLabel.snp.trailing)
            $0.centerY.equalTo(ageLabel)
        }
        
        slider.snp.makeConstraints {
            $0.top.equalTo(ageLabel.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(20)
        }
    }
}
