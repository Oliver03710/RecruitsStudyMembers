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
        let label = CustomLabel(text: "상대방 연령대")
        return label
    }()
    
    private let ageRangeLabel: CustomLabel = {
        let label = CustomLabel(text: "18 - 35")
        label.textColor = SSColors.green.color
        label.font = UIFont(name: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size)
        return label
    }()
    
    private let slider: CustomSlider = {
        let slider = CustomSlider()
        slider.minValue = 18
        slider.maxValue = 65
        slider.lower = 18
        slider.upper = 65
        return slider
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
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
