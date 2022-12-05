//
//  IntroTableViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/05.
//

import UIKit

import SnapKit

final class IntroTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    private let bellImageView: CustomImageView = {
        let iv = CustomImageView(frame: .zero, image: UIImage(named: GeneralIcons.bell.rawValue))
        iv.tintColor = SSColors.gray7.color
        return iv
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = SSColors.gray7.color
        label.font = UIFont(name: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size)
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = SSColors.gray6.color
        label.textAlignment = .center
        label.font = UIFont(name: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size)
        label.text = "채팅을 통해 약속을 정해보세요 :)"
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
        contentView.addSubview(bellImageView)
        contentView.addSubview(mainLabel)
        contentView.addSubview(subLabel)
        
        subLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(24)
        }
        
        bellImageView.snp.makeConstraints {
            $0.centerY.equalTo(mainLabel)
            $0.width.height.equalTo(16)
            $0.trailing.equalTo(mainLabel.snp.leading).offset(-4)
        }
        
        mainLabel.snp.makeConstraints {
            $0.bottom.equalTo(subLabel.snp.top).offset(-4)
            $0.top.equalToSuperview().inset(8)
            $0.width.greaterThanOrEqualTo(mainLabel.snp.height)
            $0.centerX.equalToSuperview().multipliedBy(1.04)
        }
    }
    
    func configureCells(text: String) {
        mainLabel.text = "\(text)님과 매칭되었습니다"
    }
}
