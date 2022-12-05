//
//  CircleView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/05.
//

import UIKit

final class CircleView: UIView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor?) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    
    // MARK: - Helper Functions
    
    override func layoutSubviews() {
        layer.masksToBounds = true
        layer.cornerRadius = bounds.height / 2
    }
}
