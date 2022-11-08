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
    
    convenience init(text: String, textHighlightened: String, fontName: String, size: CGFloat, lineHeight: CGFloat) {
        self.init()
        
        let style = NSMutableParagraphStyle()
        let lineHeights = size * lineHeight
        style.minimumLineHeight = lineHeights
        style.maximumLineHeight = lineHeights
        
        let titleAttString = NSMutableAttributedString(string: text, attributes: [.paragraphStyle: style,
                                                                                  .baselineOffset: (lineHeights - size) / 4])
        
        let range: NSRange = (text as NSString).range(of: textHighlightened, options: .caseInsensitive)
        titleAttString.addAttribute(.foregroundColor, value: SSColors.green.color, range: range)
        
        attributedText = titleAttString
        font = UIFont(name: fontName, size: size)
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        numberOfLines = 2
        textAlignment = .center
        
        let style = NSMutableParagraphStyle()
        let fontSize: CGFloat = 20
        let lineheight = fontSize * 1.6  //font size * multiple
        style.minimumLineHeight = lineheight
        style.maximumLineHeight = lineheight
    }

}
