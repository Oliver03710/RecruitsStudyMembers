//
//  ChatTableViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/04.
//

import UIKit

import SnapKit

final class ChatTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let textsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.backgroundColor = .yellow
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    private func setConstraints() {
        contentView.addSubview(textsLabel)
        
        textsLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        }
    }
    
    func configureCells(text: String?) {
        textsLabel.text = text
    }
}
