//
//  EmailView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import SnapKit

final class EmailView: BaseView {

    // MARK: - Properties
    
    let instructionLabel: CustomLabel = {
        let label = CustomLabel(text: "이메일을 입력해 주세요", textFont: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size, lineHeight: SSFonts.display1R20.lineHeight)
        return label
    }()
    
    let subLabel: CustomLabel = {
        let label = CustomLabel(text: "휴대폰 번호 변경 시 인증을 위해 사용해요.", textFont: SSFonts.title2R16.fonts, size: SSFonts.title2R16.size, lineHeight: SSFonts.title2R16.lineHeight)
        label.textColor = SSColors.gray7.color
        return label
    }()

    
    let emailTextField: SignupTextField = {
        let tf = SignupTextField(placeHolder: "SeSAC@email.com")
        tf.keyboardType = .emailAddress
        tf.text = UserDefaultsManager.email
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray6.color
        return view
    }()
    
    let nextButton: CustomButton = {
        let btn = CustomButton(text: "다음", buttonColor: SSColors.gray6.color)
        btn.backgroundColor = !UserDefaultsManager.email.isEmpty ? SSColors.green.color : SSColors.gray6.color
        return btn
    }()
    
    let viewModel = EmailViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [instructionLabel, subLabel, emailTextField, lineView, nextButton].forEach { addSubview($0) }
        
        nextButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.1)
        }
        
        lineView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(nextButton.snp.top).dividedBy(1.25)
        }
        
       emailTextField.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(28)
            make.height.equalTo(24)
            make.bottom.equalTo(lineView.snp.top).offset(-12)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(1.4)
            make.height.equalTo(instructionLabel.snp.width).dividedBy(4)
            make.bottom.equalTo(emailTextField.snp.top).dividedBy(1.4)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        subLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(instructionLabel.snp.width).dividedBy(4.2)
            make.bottom.equalTo(emailTextField.snp.top).dividedBy(1.25)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}

