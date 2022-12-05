//
//  UserChatTableViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/04.
//

import UIKit

import SnapKit

final class UserChatTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let baseView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = SSColors.gray4.color.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let chatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size)
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.textColor = SSColors.gray6.color
        label.font = UIFont(name: SSFonts.title6R12.fonts, size: SSFonts.title6R12.size)
        label.text = "88:88"
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
        contentView.addSubview(baseView)
        contentView.addSubview(dateLabel)
        baseView.addSubview(chatLabel)
        
        baseView.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.greaterThanOrEqualTo(10)
        }
        
        chatLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(baseView.snp.trailing).offset(8)
            $0.height.equalTo(SSFonts.title6R12.size + 8)
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
        dateLabel.setContentCompressionResistancePriority(.init(999), for: .horizontal)
    }
    
    func configureCells(text: String?) {
        chatLabel.text = text
        dateLabel.text = "88:88"
    }
}
