//
//  CustomButton.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

class CustomButton: UIButton {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, buttonColor: UIColor? = SSColors.gray6.color) {
        self.init()
        backgroundColor = buttonColor
        setTitle(text, for: .normal)
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        clipsToBounds = true
        layer.cornerRadius = 8
    }

}
