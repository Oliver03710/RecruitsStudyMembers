//
//  HeaderImageCollectionReusableView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/30.
//

import UIKit

import SnapKit

final class HeaderImageCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let foregroundImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let requestButton: UIButton = {
        let btn = CustomButton(text: "요청하기", backgroundColor: SSColors.error.color, borderColor: SSColors.error.color)
        return btn
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    private func setConstraints() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(foregroundImageView)
        backgroundImageView.addSubview(requestButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        foregroundImageView.snp.makeConstraints {
            $0.centerX.equalTo(backgroundImageView.snp.centerX)
            $0.centerY.equalTo(backgroundImageView.snp.centerY).multipliedBy(1.25)
            $0.width.height.equalTo(160)
        }
        
        requestButton.snp.makeConstraints {
            $0.top.trailing.equalTo(backgroundImageView).inset(12)
            $0.width.equalTo(80)
            $0.height.equalTo(requestButton.snp.width).dividedBy(2)
        }
    }
    
    func setComponents(indexPath: IndexPath, backgroundImg: Int, foregroundImg: Int) {
        backgroundImageView.image = UIImage(named: "sesacBackground\(backgroundImg)")
        foregroundImageView.image = UIImage(named: "sesacFace\(foregroundImg)")
        requestButton.tag = indexPath.section
    }
    
}
