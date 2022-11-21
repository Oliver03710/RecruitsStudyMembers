//
//  SearchCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/22.
//

import UIKit

import SnapKit

final class SearchCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let selectButton: CustomButton = {
        let btn = CustomButton(text: "", borderColor: SSColors.gray4.color, backgroundColor: SSColors.white.color)
        btn.titleLabel?.font = UIFont(name: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size)
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 12)
        btn.configuration = config
        return btn
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        contentView.addSubview(selectButton)
        
        selectButton.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(4)
        }
    }
    
    func setCellComponents(text: String?) {
        selectButton.setTitle(text, for: .normal)
    }
    
}
