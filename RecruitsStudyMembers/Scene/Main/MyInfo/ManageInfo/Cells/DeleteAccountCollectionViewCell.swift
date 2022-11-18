//
//  DeleteAccountCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/18.
//

import UIKit

import SnapKit

final class DeleteAccountCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    let resignButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원탈퇴", for: .normal)
        btn.titleLabel?.font = UIFont(name: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size)
        btn.backgroundColor = .red
        return btn
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        contentView.addSubview(resignButton)
        
        resignButton.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(10).priority(999)
        }
    }
}
