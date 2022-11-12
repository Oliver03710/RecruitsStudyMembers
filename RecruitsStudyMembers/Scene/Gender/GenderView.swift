//
//  GenderView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import SnapKit

final class GenderView: BaseView {

    // MARK: - Properties
    
    let instructionLabel: SignUpLabel = {
        let label = SignUpLabel(text: "성별을 선택해 주세요", textFont: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size, lineHeight: SSFonts.display1R20.lineHeight)
        return label
    }()
    
    let subLabel: SignUpLabel = {
        let label = SignUpLabel(text: "새싹 찾기 기능을 이용하기 위해서 필요해요!", textFont: SSFonts.title2R16.fonts, size: SSFonts.title2R16.size, lineHeight: SSFonts.title2R16.lineHeight)
        label.textColor = SSColors.gray7.color
        return label
    }()
    
    let maleButton: CustomButton = {
        let btn = CustomButton(text: "남자", image: GeneralIcons.man.rawValue)
        return btn
    }()
    
    let femaleButton: CustomButton = {
        let btn = CustomButton(text: "여자", image: GeneralIcons.woman.rawValue)
        return btn
    }()
    
    let nextButton: CustomButton = {
        let btn = CustomButton(text: "다음", buttonColor: SSColors.gray6.color)
        return btn
    }()
    
    let viewModel = GenderViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [instructionLabel, subLabel, maleButton, femaleButton, nextButton].forEach { addSubview($0) }
        
        nextButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.1)
        }
        
        maleButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.width.equalTo(self.snp.width).dividedBy(2.27)
            make.height.equalTo(maleButton.snp.width).dividedBy(1.38)
            make.bottom.equalTo(nextButton.snp.top).dividedBy(1.1)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(self.snp.width).dividedBy(2.27)
            make.height.equalTo(maleButton.snp.width).dividedBy(1.38)
            make.bottom.equalTo(nextButton.snp.top).dividedBy(1.1)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(1.4)
            make.height.equalTo(instructionLabel.snp.width).dividedBy(4)
            make.bottom.equalTo(maleButton.snp.top).dividedBy(1.3)
            make.centerX.equalTo(self.snp.centerX)
        }

        subLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(instructionLabel.snp.width).dividedBy(4.2)
            make.bottom.equalTo(maleButton.snp.top).dividedBy(1.15)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}
