//
//  SharedSegmentedView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

import SnapKit

final class SharedSegmentedView: BaseView {

    // MARK: - Properties
    
    private let grayImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: GeneralIcons.graySprout.rawValue))
        return iv
    }()
    
    let mainLabel: CustomLabel = {
        let label = CustomLabel(text: "", font: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size)
        label.textAlignment = .center
        return label
    }()
    
    private let subLabel: CustomLabel = {
        let label = CustomLabel(text: "스터디를 변경하거나 조금만 더 기다려 주세요!", font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size, color: SSColors.gray7.color)
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [grayImageView, mainLabel, subLabel].forEach { addSubview($0) }
        
        mainLabel.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(24)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(8)
            $0.height.equalTo(18)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        grayImageView.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(mainLabel.snp.top).offset(-44)
            $0.height.equalTo(48)
            $0.width.equalTo(64)
        }
    }

}
