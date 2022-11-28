//
//  CustomLabel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/09.
//

import UIKit

class CustomLabel: UILabel {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, textFont: String, size: CGFloat, lineHeight: CGFloat) {
        self.init()
        
        let style = NSMutableParagraphStyle()
        let lineHeights = size * lineHeight
        style.minimumLineHeight = lineHeights
        style.maximumLineHeight = lineHeights
        
        guard let txtFont = UIFont(name: textFont, size: size) else { return }
        
        let attributedTexts = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: txtFont, .paragraphStyle: style, NSAttributedString.Key.foregroundColor: SSColors.black.color,  .baselineOffset: (lineHeights - size) / 4])
        
        attributedText = attributedTexts
        textAlignment = .center
        numberOfLines = 2
    }
    
    convenience init(text: String, font: String, size: CGFloat, color: UIColor? = SSColors.black.color) {
        self.init()
        self.text = text
        self.font = UIFont(name: font, size: size)
        self.textColor = color
    }
}
