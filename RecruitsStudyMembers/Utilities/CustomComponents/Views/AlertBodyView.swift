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
    
    private let illigalOrmannerButton: CustomButton = {
        let btn = CustomButton(text: "", borderColor: SSColors.gray3.color, backgroundColor: SSColors.white.color)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let unpleasantOrAppointmentButton: CustomButton = {
        let btn = CustomButton(text: "", borderColor: SSColors.gray3.color, backgroundColor: SSColors.white.color)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let noShowOrResponseButton: CustomButton = {
        let btn = CustomButton(text: "", borderColor: SSColors.gray3.color, backgroundColor: SSColors.white.color)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let sexualOrKindButton: CustomButton = {
        let btn = CustomButton(text: "", borderColor: SSColors.gray3.color, backgroundColor: SSColors.white.color)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let harrasmentOrSkilledButton: CustomButton = {
        let btn = CustomButton(text: "", borderColor: SSColors.gray3.color, backgroundColor: SSColors.white.color)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let etcOrGoodtimeButton: CustomButton = {
        let btn = CustomButton(text: "", borderColor: SSColors.gray3.color, backgroundColor: SSColors.white.color)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    var alertState = AlertSplit.report

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle(states: alertState)
    }
    
    convenience init(state: AlertSplit) {
        self.init()
        alertState = state
        setTitle(states: state)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        [illigalOrmannerButton, unpleasantOrAppointmentButton,noShowOrResponseButton,
         sexualOrKindButton, harrasmentOrSkilledButton, etcOrGoodtimeButton].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        let widthDivided = 3.2
        let heightDivided = 2.2
        
        switch alertState {
        case .report:
            illigalOrmannerButton.snp.makeConstraints {
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
            
        case .review:
            illigalOrmannerButton.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(3).offset(16 / 3)
                $0.width.equalToSuperview().dividedBy(2).offset(-4)
            }
            
            unpleasantOrAppointmentButton.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(3).offset(16 / 3)
                $0.width.equalToSuperview().dividedBy(2).offset(-4)
            }
            
            unpleasantOrAppointmentButton.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(3).offset(16 / 3)
                $0.width.equalToSuperview().dividedBy(2).offset(-4)
            }
            
            unpleasantOrAppointmentButton.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(3).offset(16 / 3)
                $0.width.equalToSuperview().dividedBy(2).offset(-4)
            }
            
            unpleasantOrAppointmentButton.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(3).offset(16 / 3)
                $0.width.equalToSuperview().dividedBy(2).offset(-4)
            }
            
            unpleasantOrAppointmentButton.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.height.equalToSuperview().dividedBy(3).offset(16 / 3)
                $0.width.equalToSuperview().dividedBy(2).offset(-4)
            }
        }
    }
    
    private func setTitle(states: AlertSplit) {
        switch states {
        case .report:
            illigalOrmannerButton.setTitle("불법/사기", for: .normal)
            unpleasantOrAppointmentButton.setTitle("불편한언행", for: .normal)
            noShowOrResponseButton.setTitle("노쇼", for: .normal)
            sexualOrKindButton.setTitle("선정성", for: .normal)
            harrasmentOrSkilledButton.setTitle("인신공격", for: .normal)
            etcOrGoodtimeButton.setTitle("기타", for: .normal)
            
        case .review:
            illigalOrmannerButton.setTitle("좋은 매너", for: .normal)
            unpleasantOrAppointmentButton.setTitle("정확한 시간 약속", for: .normal)
            noShowOrResponseButton.setTitle("빠른 응답", for: .normal)
            sexualOrKindButton.setTitle("친절한 성격", for: .normal)
            harrasmentOrSkilledButton.setTitle("능숙한 실력", for: .normal)
            etcOrGoodtimeButton.setTitle("유익한 시간", for: .normal)
        }
    }
}

