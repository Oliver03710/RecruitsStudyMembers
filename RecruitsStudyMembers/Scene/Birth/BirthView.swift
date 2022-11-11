//
//  BirthView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import SnapKit

final class BirthView: BaseView {

    // MARK: - Properties
    
    let instructionLabel: SignUpLabel = {
        let label = SignUpLabel(text: "생년월일을 알려주세요", textFont: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size, lineHeight: SSFonts.display1R20.lineHeight)
        return label
    }()
    
    let leftView: BirthComponentView = {
        let view = BirthComponentView()
        return view
    }()
    
    let centerView: BirthComponentView = {
        let view = BirthComponentView()
        view.birthLabel.text = "월"
        view.birthTextField.placeholder = "1"
        return view
    }()
    
    let rightView: BirthComponentView = {
        let view = BirthComponentView()
        view.birthLabel.text = "일"
        view.birthTextField.placeholder = "1"
        return view
    }()
    
    let nextButton: CustomButton = {
        let btn = CustomButton(text: "다음", buttonColor: SSColors.gray6.color)
//        btn.isEnabled = false
        return btn
    }()
    
    let viewModel = BirthViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [instructionLabel, leftView, centerView, rightView, nextButton].forEach { addSubview($0) }
        
        nextButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.1)
        }
        
        leftView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(instructionLabel.snp.height)
            make.width.equalTo(leftView.snp.height).multipliedBy(1.5)
            make.bottom.equalTo(nextButton.snp.top).dividedBy(1.25)
        }
        
        centerView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(instructionLabel.snp.height)
            make.width.equalTo(centerView.snp.height).multipliedBy(1.5)
            make.bottom.equalTo(nextButton.snp.top).dividedBy(1.25)
        }
        
        rightView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(instructionLabel.snp.height)
            make.width.equalTo(rightView.snp.height).multipliedBy(1.5)
            make.bottom.equalTo(nextButton.snp.top).dividedBy(1.25)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(1.4)
            make.height.equalTo(instructionLabel.snp.width).dividedBy(4)
            make.bottom.equalTo(leftView.snp.top).dividedBy(1.21)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}
