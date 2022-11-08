//
//  FirstViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import SnapKit

final class FirstViewController: BaseViewController {

    // MARK: - Properties
    
    private let introLabel: OnboardingLabel = {
        let label = OnboardingLabel(text: "위치 기반으로 빠르게 주위 친구를 확인", textHighlightened: "위치 기반")
        return label
    }()
    
    private let introImageView: CustomImageView = {
        let iv = CustomImageView(frame: .zero, image: UIImage(named: OnboardingImages.onboardingImg1.rawValue))
        return iv
    }()
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [introLabel, introImageView].forEach { view.addSubview($0) }
        
        introImageView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.centerY.equalTo(view.snp.centerY).dividedBy(1.2)
            make.height.equalTo(introImageView.snp.width)
        }
        
        introLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(78)
            make.bottom.equalTo(introImageView.snp.top).offset(-56)
            make.height.equalTo(80)
        }

    }

}
