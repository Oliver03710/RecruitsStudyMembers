//
//  StudyCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/17.
//

import UIKit

import SnapKit

final class StudyCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let studyLabel: CustomLabel = {
        let label = CustomLabel(text: "자주 하는 스터디")
        return label
    }()
    
    private let underlinedTextField: UnderlinedTextField = {
        let tf = UnderlinedTextField(placeHolder: "스터디를 입력해 주세요")
        return tf
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    override func layoutSubviews() {
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRectMake(0.0, underlinedTextField.frame.height - 1, underlinedTextField.frame.width, 1.0)
//        bottomLine.backgroundColor = SSColors.gray3.color.cgColor
//        underlinedTextField.borderStyle = .none
//        underlinedTextField.layer.addSublayer(bottomLine)
//    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [studyLabel, underlinedTextField].forEach { contentView.addSubview($0) }
                
        studyLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        underlinedTextField.snp.makeConstraints {
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(safeAreaLayoutGuide).dividedBy(2)
            $0.height.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
