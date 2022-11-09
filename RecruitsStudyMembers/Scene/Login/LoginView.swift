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
    
    let instructionLabel: SignUpLabel = {
        let label = SignUpLabel(text: "새싹 서비스 이용을 위해 휴대폰 번호를 입력해 주세요", textFont: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size, lineHeight: SSFonts.display1R20.lineHeight)
        return label
    }()
    
    let phoneNumTextField: SignupTextField = {
        let tf = SignupTextField(placeHolder: "휴대폰 번호(-없이 숫자만 입력)")
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray6.color
        return view
    }()
    
    let getCertiNumButton: CustomButton = {
        let btn = CustomButton(text: "", buttonColor: SSColors.gray6.color)
        return btn
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        
    }

}
