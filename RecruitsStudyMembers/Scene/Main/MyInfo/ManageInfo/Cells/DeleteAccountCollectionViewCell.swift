//
//  DeleteAccountCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/18.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class DeleteAccountCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    let deleteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원탈퇴", for: .normal)
        btn.setTitleColor(SSColors.black.color, for: .normal)
        btn.titleLabel?.font = UIFont(name: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size)
        return btn
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        contentView.addSubview(deleteButton)
        
        deleteButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        deleteButton.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
        }
    }
}
