//
//  AlertTitleView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/06.
//

import UIKit

import SnapKit

final class AlertTitleView: BaseView {

    // MARK: - Properties
    
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(text: "", textFont: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size, lineHeight: SSFonts.title3M14.lineHeight)
        return label
    }()
    
    private let subTitleLabel: CustomLabel = {
        let label = CustomLabel(text: "", textFont: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size, lineHeight: SSFonts.title3M14.lineHeight)
        label.textColor = SSColors.green.color
        return label
    }()
    
    private let xmarkButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: GeneralIcons.closeBig.rawValue), for: .normal)
        btn.tintColor = SSColors.gray6.color
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String?, subTitle: String?) {
        self.init()
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        [titleLabel, subTitleLabel, xmarkButton].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide.snp.height).dividedBy(2.3)
            $0.width.equalTo(safeAreaLayoutGuide.snp.width).dividedBy(2)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.centerX.width.equalToSuperview()
            $0.height.equalTo(safeAreaLayoutGuide.snp.height).dividedBy(2.3)
        }

        xmarkButton.snp.makeConstraints {
            $0.centerY.height.equalTo(titleLabel)
            $0.width.equalTo(xmarkButton.snp.height)
            $0.trailing.equalToSuperview()
        }
    }
}
