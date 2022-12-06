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
    
    var alertState = AlertSplit.report

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle()
    }
    
    convenience init(state: AlertSplit) {
        self.init()
        alertState = state
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        [illigalOrMannerButton, unpleasantOrAppointmentButton,noShowOrResponseButton,
         sexualOrKindButton, harrasmentOrSkilledButton, etcOrGoodtimeButton].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        let widthDivided = 3.2
        let heightDivided = 2.2
        
        illigalOrMannerButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(alertState == .report ? heightDivided : widthDivided)
            $0.width.equalToSuperview().dividedBy(alertState == .report ? widthDivided : heightDivided)
        }
        
        unpleasantOrAppointmentButton.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(alertState == .report ? heightDivided : widthDivided)
            $0.width.equalToSuperview().dividedBy(alertState == .report ? widthDivided : heightDivided)
        }
        
        noShowOrResponseButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(alertState == .report ? heightDivided : widthDivided)
            $0.width.equalToSuperview().dividedBy(alertState == .report ? widthDivided : heightDivided)
        }
        
        sexualOrKindButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(alertState == .report ? heightDivided : widthDivided)
            $0.width.equalToSuperview().dividedBy(alertState == .report ? widthDivided : heightDivided)
        }
        
        harrasmentOrSkilledButton.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(alertState == .report ? heightDivided : widthDivided)
            $0.width.equalToSuperview().dividedBy(alertState == .report ? widthDivided : heightDivided)
        }
        
        etcOrGoodtimeButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(alertState == .report ? heightDivided : widthDivided)
            $0.width.equalToSuperview().dividedBy(alertState == .report ? widthDivided : heightDivided)
        }
    }
    
    private func setTitle() {
        illigalOrMannerButton.setTitle(alertState == .report ? "불법/사기" : "좋은 매너", for: .normal)
        unpleasantOrAppointmentButton.setTitle(alertState == .report ? "불편한언행" : "정확한 시간 약속", for: .normal)
        noShowOrResponseButton.setTitle(alertState == .report ? "노쇼" : "빠른 응답", for: .normal)
        sexualOrKindButton.setTitle(alertState == .report ? "선정성" : "친절한 성격", for: .normal)
        harrasmentOrSkilledButton.setTitle(alertState == .report ? "인신공격" : "능숙한 실력", for: .normal)
        etcOrGoodtimeButton.setTitle(alertState == .report ? "기타" : "유익한 시간", for: .normal)
    }
}

