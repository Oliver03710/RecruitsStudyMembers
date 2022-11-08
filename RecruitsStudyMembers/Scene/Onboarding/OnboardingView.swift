//
//  OnboardingView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import SnapKit

final class OnboardingView: BaseView {

    // MARK: - Properties
    
    private let startButton: CustomButton = {
        let btn = CustomButton(text: "시작하기", buttonColor: SSColors.green.color)
        return btn
    }()
    
    
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
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        addSubview(startButton)
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).inset(50)
            make.directionalHorizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
    }

}
