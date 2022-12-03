//
//  SesacTitleCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/22.
//

import UIKit

import SnapKit

final class SesacTitleCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = SSColors.white.color
        label.layer.borderColor = SSColors.gray4.color.cgColor
        label.layer.borderWidth = 1.0
        label.font = UIFont(name: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size)
        label.textColor = SSColors.black.color
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(4)
        }
    }
    
    func setComponents(text: String?) {
        titleLabel.text = text
    }
}
