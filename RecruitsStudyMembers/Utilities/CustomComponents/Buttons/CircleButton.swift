//
//  CircleButton.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/20.
//

import UIKit

final class CircleButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: String) {
        self.init()
        setImage(UIImage(named: image), for: .normal)
    }
    
    // MARK: - Helper Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
}
