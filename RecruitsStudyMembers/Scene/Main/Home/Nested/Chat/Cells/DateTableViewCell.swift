//
//  DateTableViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/05.
//

import UIKit

import SnapKit

final class DateTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let ellipseView: CircleView = {
        let view = CircleView(backgroundColor: SSColors.gray7.color)
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = SSColors.white.color
        label.font = UIFont(name: SSFonts.title5M12.fonts, size: SSFonts.title5M12.size)
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
        contentView.addSubview(ellipseView)
        ellipseView.addSubview(dateLabel)
        
        ellipseView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(28)
            $0.width.greaterThanOrEqualTo(ellipseView.snp.height)
        }
        
        dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
        }
    }
    
    func configureCells(date: String?) {
        dateLabel.text = date
    }
}
