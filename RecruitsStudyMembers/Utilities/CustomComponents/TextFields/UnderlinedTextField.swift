//
//  UnderlinedTextField.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/17.
//

import UIKit

final class UnderlinedTextField: UITextField {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String) {
        self.init()
        placeholder = placeHolder
        font = UIFont(name: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size)
        textAlignment = .center
    }
    
    override func layoutSubviews() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = SSColors.gray3.color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
}

