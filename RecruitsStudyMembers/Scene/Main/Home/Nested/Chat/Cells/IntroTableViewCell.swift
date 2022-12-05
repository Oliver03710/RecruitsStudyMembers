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
    }
    
    func configureCells() {
        
    }
}
