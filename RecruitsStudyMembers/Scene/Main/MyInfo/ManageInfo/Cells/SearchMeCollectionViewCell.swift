//
//  SearchMeCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/17.
//

import UIKit

final class SearchMeCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let studyLabel: CustomLabel = {
        let label = CustomLabel(text: "자주 하는 스터디")
        return label
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [studyLabel].forEach { contentView.addSubview($0) }
                
        studyLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    
}
