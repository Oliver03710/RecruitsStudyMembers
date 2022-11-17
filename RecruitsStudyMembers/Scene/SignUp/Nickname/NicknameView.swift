//
//  NicknameView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import SnapKit

final class NicknameView: BaseView {

    // MARK: - Properties
    
    let instructionLabel: CustomLabel = {
        let label = CustomLabel(text: "닉네임을 입력해 주세요", textFont: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size, lineHeight: SSFonts.display1R20.lineHeight)
        return label
    }()
    
    let nicknameTextField: SignupTextField = {
        let tf = SignupTextField(placeHolder: "10자 이내로 입력")
        tf.keyboardType = .default
        tf.text = UserDefaultsManager.nickname
        tf.becomeFirstResponder()
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray6.color
        return view
    }()
    
    let nextButton: CustomButton = {
        let btn = CustomButton(text: "다음", buttonColor: SSColors.gray6.color)
        btn.backgroundColor = !UserDefaultsManager.nickname.isEmpty ? SSColors.green.color : SSColors.gray6.color
        return btn
    }()
    
    let viewModel = NicknameViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [instructionLabel, nicknameTextField, lineView, nextButton].forEach { addSubview($0) }
        
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
        
        nicknameTextField.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(28)
            make.height.equalTo(24)
            make.bottom.equalTo(lineView.snp.top).offset(-12)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).dividedBy(1.4)
            make.height.equalTo(instructionLabel.snp.width).dividedBy(4)
            make.bottom.equalTo(nicknameTextField.snp.top).dividedBy(1.35)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
