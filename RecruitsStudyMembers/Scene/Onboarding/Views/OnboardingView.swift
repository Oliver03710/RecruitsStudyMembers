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
    
    let startButton: CustomButton = {
        let btn = CustomButton(text: "시작하기", buttonColor: SSColors.green.color)
        return btn
    }()
    
    let viewModel = OnboardingViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        addSubview(startButton)

        startButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.8)
            make.directionalHorizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
        
    }

}
