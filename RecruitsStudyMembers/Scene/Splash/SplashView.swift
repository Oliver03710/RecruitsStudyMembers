//
//  SplashView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import SnapKit

final class SplashView: BaseView {

    // MARK: - Properties
    
    private let logoImageView: CustomImageView = {
        let iv = CustomImageView(frame: .zero, image: UIImage(named: SplashImages.splashLogo.rawValue))
        return iv
    }()
    
    private let textImageView: CustomImageView = {
        let iv = CustomImageView(frame: .zero, image: UIImage(named: SplashImages.splashText.rawValue))
        return iv
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        [logoImageView, textImageView].forEach { addSubview($0) }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).dividedBy(1.2)
            make.width.equalTo(220)
            make.height.equalTo(264)
        }
        
        textImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.35)
            make.width.equalTo(328)
            make.height.equalTo(112)
        }
    }

}
