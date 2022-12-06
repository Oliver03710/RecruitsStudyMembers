//
//  ReportAlertView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/06.
//

import UIKit

import SnapKit

final class AlertSplitView: BaseView {
    
    // MARK: - Properties
    
    private let alertBaseView: AlertBaseView = {
        let view = AlertBaseView(baseRad: 16)
        return view
    }()
    
    let alertTitleView: AlertTitleView = {
        let view = AlertTitleView(title: "새싹 신고", subTitle: "다시는 해당 새싹과 매칭되지 않습니다")
        return view
    }()
    
    lazy var alertBodyView = AlertBodyView()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = SSColors.gray1.color
        tv.clipsToBounds = true
        tv.layer.cornerRadius = 8
        tv.text = "신고 사유를 적어주세요\n허위 신고시 제재를 받을 수 있습니다"
        tv.font = UIFont(name: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size)
        tv.textColor = SSColors.gray7.color
        return tv
    }()
    
    let executionButton: CustomButton = {
        let btn = CustomButton(text: "신고하기", withImage: false, config: .plain(), foregroundColor: SSColors.gray3.color, font: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size, lineHeight: SSFonts.body3R14.lineHeight)
        btn.backgroundColor = SSColors.gray6.color
        return btn
    }()
    
    var viewState = AlertSplit.report
    let viewModel = ReportAlertViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        self.isOpaque = false
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        alertBodyView.alertState = viewState
        addProperties()
    }
    
    override func setConstraints() {
        alertBaseView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().inset(16)
            $0.height.equalToSuperview().dividedBy(1.8)
        }
        
        alertTitleView.snp.makeConstraints {
            $0.directionalHorizontalEdges.top.equalToSuperview().inset(16)
            $0.height.equalToSuperview().dividedBy(6.61)
        }

        alertBodyView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(alertTitleView.snp.bottom).offset(24)
            $0.height.equalToSuperview().dividedBy(5.7)
        }
        
        textView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(alertBodyView.snp.bottom).offset(24)
            $0.height.equalToSuperview().dividedBy(3.3)
        }
        
        executionButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(textView.snp.bottom).offset(24)
            $0.height.equalToSuperview().dividedBy(8.55)
        }
    }
    
    private func addProperties() {
        addSubview(alertBaseView)
        [alertTitleView, alertBodyView, textView, executionButton].forEach { alertBaseView.addSubview($0) }
    }
}
