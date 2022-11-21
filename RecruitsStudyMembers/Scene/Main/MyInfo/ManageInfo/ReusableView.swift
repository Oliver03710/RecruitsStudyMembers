//
//  ReusableView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/16.
//

import UIKit

final class ReusableView: UICollectionReusableView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    
    // MARK: - Helper Functions
    
    func configure() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
    
}
