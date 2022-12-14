//
//  OnboardingLabel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

class OnboardingLabel: UILabel {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, textFont: String, textHighlightened: String, textHLenedFont: String, size: CGFloat, lineHeight: CGFloat) {
        self.init()
        
        let style = NSMutableParagraphStyle()
        let lineHeights = size * lineHeight
        style.minimumLineHeight = lineHeights
        style.maximumLineHeight = lineHeights
        
        guard let hledFont = UIFont(name: textHLenedFont, size: size), let txtFont = UIFont(name: textFont, size: size) else { return }
        
        let attributedTexts = NSMutableAttributedString(string: textHighlightened, attributes: [NSAttributedString.Key.font: hledFont, .paragraphStyle: style, NSAttributedString.Key.foregroundColor: SSColors.green.color,  .baselineOffset: (lineHeights - size) / 4])
        
        attributedTexts.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: txtFont, .paragraphStyle: style, .baselineOffset: (lineHeights - size) / 4]))
        
        attributedText = attributedTexts
        textAlignment = .center
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        numberOfLines = 2
    }

}
