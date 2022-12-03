//
//  LoginView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import SnapKit

final class LoginView: BaseView {

    // MARK: - Properties
    
    let instructionLabel: CustomLabel = {
        let label = CustomLabel(text: "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요", textFont: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size, lineHeight: SSFonts.display1R20.lineHeight)
        return label
    }()
    
    let phoneNumTextField: SignupTextField = {
        let tf = SignupTextField(placeHolder: "휴대폰 번호(-없이 숫자만 입력)")
        tf.keyboardType = .decimalPad
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray6.color
        return view
    }()
    
    let getCertiNumButton: CustomButton = {
        let btn = CustomButton(text: "인증 문자 받기", buttonColor: SSColors.gray6.color)
        return btn
    }()
    
    let viewModel = LoginViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [instructionLabel, phoneNumTextField, lineView, getCertiNumButton].forEach { addSubview($0) }
        
        getCertiNumButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.1)
        }
        
        lineView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(1)
            make.bottom.equalTo(getCertiNumButton.snp.top).dividedBy(1.25)
        }
        
        phoneNumTextField.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(28)
            make.height.equalTo(24)
            make.bottom.equalTo(lineView.snp.top).offset(-12)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(1.4)
            make.height.equalTo(instructionLabel.snp.width).dividedBy(4)
            make.bottom.equalTo(phoneNumTextField.snp.top).dividedBy(1.35)
            make.centerX.equalTo(self.snp.centerX)
        }
    }

}
