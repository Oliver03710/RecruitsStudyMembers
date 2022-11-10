//
//  BirthComponentView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/11.
//

import UIKit

import SnapKit

final class BirthComponentView: BaseView {

    // MARK: - Properties
    
    let birthLabel: SignUpLabel = {
        let label = SignUpLabel(text: "년", textFont: SSFonts.title2R16.fonts, size: SSFonts.title2R16.size, lineHeight: SSFonts.title2R16.lineHeight)
        return label
    }()
    
    let birthTextField: SignupTextField = {
        let tf = SignupTextField(placeHolder: "1990")
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray6.color
        return view
    }()
    
    let datePickerButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        return btn
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [birthLabel, birthTextField, datePickerButton, lineView].forEach { addSubview($0) }
        
        lineView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(birthLabel.snp.leading).dividedBy(1.1)
            make.height.equalTo(1)
        }
        
        birthTextField.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(12)
            make.height.equalTo(self.snp.height).dividedBy(2)
            make.width.equalTo(birthTextField.snp.height).multipliedBy(1.8)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        datePickerButton.snp.makeConstraints { make in
            make.edges.equalTo(birthTextField.snp.edges)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(6.6)
            make.height.equalTo(birthLabel.snp.width).multipliedBy(1.95)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.centerY.equalTo(self.snp.centerY)
        }
    }

}
