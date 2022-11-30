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
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let foregroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
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
    
    func setConstraints() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(foregroundImageView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        foregroundImageView.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
            $0.width.height.equalTo(120)
        }
    }
    
    func setComponents(indexPath: IndexPath) {
        
    }
    
}
