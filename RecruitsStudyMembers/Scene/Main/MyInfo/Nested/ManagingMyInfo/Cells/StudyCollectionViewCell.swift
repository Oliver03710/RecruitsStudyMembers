//
//  StudyCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/17.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class StudyCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let studyLabel: CustomLabel = {
        let label = CustomLabel(text: "자주 하는 스터디", font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size)
        return label
    }()
    
    private let underlinedTextField: UnderlinedTextField = {
        let tf = UnderlinedTextField(placeHolder: "스터디를 입력해 주세요")
        tf.text = NetworkManager.shared.userData.study
        return tf
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray3.color
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        bindData()
    }
    
    override func setConstraints() {
        [studyLabel, underlinedTextField, lineView].forEach { contentView.addSubview($0) }
                
        studyLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        underlinedTextField.snp.makeConstraints {
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(safeAreaLayoutGuide).dividedBy(2)
            $0.height.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(underlinedTextField.snp.bottom)
            $0.height.equalTo(1)
            $0.directionalHorizontalEdges.equalTo(underlinedTextField.snp.directionalHorizontalEdges)
        }
    }
    
    private func bindData() {
        underlinedTextField.rx.text
            .orEmpty
            .asDriver()
            .drive { text in
                NetworkManager.shared.userData.study = text
            }
            .disposed(by: disposeBag)
    }
    
    func setComponents(text: String?) {
        underlinedTextField.text = text
    }
}
