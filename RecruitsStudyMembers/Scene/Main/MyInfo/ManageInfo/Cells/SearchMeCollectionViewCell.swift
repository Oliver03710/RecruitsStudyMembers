//
//  SearchMeCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/17.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SearchMeCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let studyLabel: CustomLabel = {
        let label = CustomLabel(text: "내 번호 검색 허용")
        return label
    }()
    
    private let numSwitch: UISwitch = {
        let swit = UISwitch()
        swit.isOn = false
        swit.onTintColor = SSColors.green.color
        return swit
    }()
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindData()
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [studyLabel, numSwitch].forEach { contentView.addSubview($0) }
                
        studyLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        numSwitch.snp.makeConstraints {
            $0.trailing.centerY.equalTo(studyLabel)
            $0.height.equalTo(28)
            $0.width.equalTo(52)
        }
    }
    
    private func bindData() {
        numSwitch.rx.value
    }

}
