//
//  ReusableView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/16.
//

import UIKit

class ReusableView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension ReusableView {
    func configure() {
//        backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
}
