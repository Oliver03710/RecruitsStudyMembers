//
//  AlertBodyView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/06.
//

import UIKit

import SnapKit

final class AlertBodyView: BaseView {

    // MARK: - Properties
    
    let illigalOrMannerButton: CustomButton = {
        let btn = CustomButton(text: "", withImage: false, config: .plain(), foregroundColor: SSColors.black.color, font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size, lineHeight: SSFonts.title4R14.lineHeight)
        return btn
    }()
    
    let unpleasantOrAppointmentButton: CustomButton = {
        let btn = CustomButton(text: "", withImage: false, config: .plain(), foregroundColor: SSColors.black.color, font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size, lineHeight: SSFonts.title4R14.lineHeight)
        return btn
    }()
    
    let noShowOrResponseButton: CustomButton = {
        let btn = CustomButton(text: "", withImage: false, config: .plain(), foregroundColor: SSColors.black.color, font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size, lineHeight: SSFonts.title4R14.lineHeight)
        return btn
    }()
    
    let sexualOrKindButton: CustomButton = {
        let btn = CustomButton(text: "", withImage: false, config: .plain(), foregroundColor: SSColors.black.color, font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size, lineHeight: SSFonts.title4R14.lineHeight)
        return btn
    }()
    
    let harrasmentOrSkilledButton: CustomButton = {
        let btn = CustomButton(text: "", withImage: false, config: .plain(), foregroundColor: SSColors.black.color, font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size, lineHeight: SSFonts.title4R14.lineHeight)
        return btn
    }()
    
    let etcOrGoodtimeButton: CustomButton = {
        let btn = CustomButton(text: "", withImage: false, config: .plain(), foregroundColor: SSColors.black.color, font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size, lineHeight: SSFonts.title4R14.lineHeight)
        return btn
    }()

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        [illigalOrMannerButton, unpleasantOrAppointmentButton,noShowOrResponseButton,
         sexualOrKindButton, harrasmentOrSkilledButton, etcOrGoodtimeButton].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        let widthDivided = 3.2
        let heightDivided = 2.2
        
        if NetworkManager.shared.moreViewState == .report {
            illigalOrMannerButton.snp.makeConstraints {
                $0.top.leading.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(heightDivided)
                $0.width.equalToSuperview().dividedBy(widthDivided)
            }
            
            unpleasantOrAppointmentButton.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(heightDivided)
                $0.width.equalToSuperview().dividedBy(widthDivided)
            }
            
            noShowOrResponseButton.snp.makeConstraints {
                $0.top.trailing.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(heightDivided)
                $0.width.equalToSuperview().dividedBy(widthDivided)
            }
            
            sexualOrKindButton.snp.makeConstraints {
                $0.bottom.leading.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(heightDivided)
                $0.width.equalToSuperview().dividedBy(widthDivided)
            }
            
            harrasmentOrSkilledButton.snp.makeConstraints {
                $0.bottom.centerX.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(heightDivided)
                $0.width.equalToSuperview().dividedBy(widthDivided)
            }
            
            etcOrGoodtimeButton.snp.makeConstraints {
                $0.bottom.trailing.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(heightDivided)
                $0.width.equalToSuperview().dividedBy(widthDivided)
            }
        } else {
            illigalOrMannerButton.snp.makeConstraints {
                $0.top.leading.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(widthDivided)
                $0.width.equalToSuperview().dividedBy(heightDivided)
            }
            
            unpleasantOrAppointmentButton.snp.makeConstraints {
                $0.top.trailing.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(widthDivided)
                $0.width.equalToSuperview().dividedBy(heightDivided)
            }
            
            noShowOrResponseButton.snp.makeConstraints {
                $0.leading.centerY.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(widthDivided)
                $0.width.equalToSuperview().dividedBy(heightDivided)
            }
            
            sexualOrKindButton.snp.makeConstraints {
                $0.trailing.centerY.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(widthDivided)
                $0.width.equalToSuperview().dividedBy(heightDivided)
            }
            
            harrasmentOrSkilledButton.snp.makeConstraints {
                $0.bottom.leading.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(widthDivided)
                $0.width.equalToSuperview().dividedBy(heightDivided)
            }
            
            etcOrGoodtimeButton.snp.makeConstraints {
                $0.bottom.trailing.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(widthDivided)
                $0.width.equalToSuperview().dividedBy(heightDivided)
            }
        }
        
    }
    
    private func setTitle() {
        illigalOrMannerButton.setTitle(NetworkManager.shared.moreViewState == .report ? "불법/사기" : "좋은 매너", for: .normal)
        unpleasantOrAppointmentButton.setTitle(NetworkManager.shared.moreViewState == .report ? "불편한언행" : "정확한 시간 약속", for: .normal)
        noShowOrResponseButton.setTitle(NetworkManager.shared.moreViewState == .report ? "노쇼" : "빠른 응답", for: .normal)
        sexualOrKindButton.setTitle(NetworkManager.shared.moreViewState == .report ? "선정성" : "친절한 성격", for: .normal)
        harrasmentOrSkilledButton.setTitle(NetworkManager.shared.moreViewState == .report ? "인신공격" : "능숙한 실력", for: .normal)
        etcOrGoodtimeButton.setTitle(NetworkManager.shared.moreViewState == .report ? "기타" : "유익한 시간", for: .normal)
    }
}

