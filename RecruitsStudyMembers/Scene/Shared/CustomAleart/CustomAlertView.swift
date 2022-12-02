//
//  CustomAlertView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/23.
//

import UIKit

import SnapKit

final class CustomAlertView: BaseView {
    
    // MARK: - Properties
    
    private let alertView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = SSColors.white.color
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정말 탈퇴하시겠습니까?"
        label.font = UIFont(name: SSFonts.body1M16.fonts, size: SSFonts.body1M16.size)
        label.textAlignment = .center
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "탈퇴하시면 새싹 스터디를 이용할 수 없어요 ㅠ"
        label.font = UIFont(name: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let confirmButton: UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.backgroundColor = SSColors.green.color
        btn.setTitleColor(SSColors.white.color, for: .normal)
        btn.setTitle("확인", for: .normal)
        btn.titleLabel?.font = UIFont(name: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size)
        return btn
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.backgroundColor = SSColors.gray2.color
        btn.setTitleColor(SSColors.black.color, for: .normal)
        btn.setTitle("취소", for: .normal)
        btn.titleLabel?.font = UIFont(name: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size)
        return btn
    }()
    
    var state = CustomAlertState.acceptRequest
    let viewModel = CustomAlertViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        self.isOpaque = false
    }
    
    override func setConstraints() {
        addSubview(alertView)
        [titleLabel, bodyLabel, confirmButton, cancelButton].forEach { alertView.addSubview($0) }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().inset(16)
            $0.height.equalToSuperview().dividedBy(4.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
        
        bodyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.equalTo(alertView.snp.centerX).offset(4)
            $0.trailing.equalTo(alertView.snp.trailing).inset(16)
            $0.top.equalTo(bodyLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(alertView.snp.bottom).inset(16)
        }
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalTo(alertView.snp.centerX).offset(-4)
            $0.leading.equalTo(alertView.snp.leading).inset(16)
            $0.top.equalTo(bodyLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(alertView.snp.bottom).inset(16)
        }
    }
}
