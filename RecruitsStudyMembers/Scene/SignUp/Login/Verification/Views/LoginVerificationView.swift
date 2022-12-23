//
//  LoginVerificationView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift
import SnapKit
import Toast

final class LoginVerificationView: BaseView {

    // MARK: - Properties
    
    let instructionLabel: CustomLabel = {
        let label = CustomLabel(text: "인증번호가 문자로 전송 되었어요.", textFont: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size, lineHeight: SSFonts.display1R20.lineHeight)
        return label
    }()
    
    let certiTextField: SignupTextField = {
        let tf = SignupTextField(placeHolder: "인증 번호 입력")
        tf.keyboardType = .decimalPad
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray6.color
        return view
    }()
    
    let startButton: CustomButton = {
        let btn = CustomButton(text: "인증하고 시작하기", buttonColor: SSColors.gray6.color)
        return btn
    }()
    
    let resendButton: CustomButton = {
        let btn = CustomButton(text: "재전송", buttonColor: SSColors.green.color)
        return btn
    }()
    
    let timerLabel: CustomLabel = {
        let label = CustomLabel(text: "01:00", textFont: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size, lineHeight: SSFonts.title3M14.lineHeight)
        label.textColor = SSColors.green.color
        return label
    }()
    
    let viewModel = LoginVerificationViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [instructionLabel, certiTextField, lineView, startButton, resendButton, timerLabel].forEach { addSubview($0) }
        
        startButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.1)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(resendButton.snp.leading).offset(-8)
            make.height.equalTo(1)
            make.bottom.equalTo(startButton.snp.top).dividedBy(1.25)
        }
        
        certiTextField.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(resendButton.snp.leading).offset(-8)
            make.height.equalTo(24)
            make.bottom.equalTo(lineView.snp.top).offset(-12)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(1.4)
            make.height.equalTo(instructionLabel.snp.width).dividedBy(4)
            make.bottom.equalTo(certiTextField.snp.top).dividedBy(1.35)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.trailing.equalTo(resendButton.snp.leading).offset(-8)
            make.width.equalTo(resendButton.snp.height).multipliedBy(1.5)
            make.height.equalTo(16)
            make.bottom.equalTo(lineView.snp.top).offset(-12)
        }
        
        resendButton.snp.makeConstraints { make in
            make.bottom.equalTo(startButton.snp.top).dividedBy(1.25)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
            make.width.equalTo(resendButton.snp.height).multipliedBy(2)
        }

    }
}
