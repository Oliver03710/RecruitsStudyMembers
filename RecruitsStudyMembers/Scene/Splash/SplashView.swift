//
//  SplashView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

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
        
    }

}
