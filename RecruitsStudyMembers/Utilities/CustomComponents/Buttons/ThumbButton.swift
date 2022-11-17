//
//  ThumbButton.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/18.
//

import UIKit

final class ThumbButton: UIButton {
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = SSColors.green.color
        }
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = SSColors.green.color
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = SSColors.white.color.cgColor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Helper Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
}
