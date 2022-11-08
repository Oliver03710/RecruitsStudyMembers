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
    
    convenience init(text: String, textHighlightened: String) {
        self.init()
        let titleAttString = NSMutableAttributedString(string: text)
        let range: NSRange = (text as NSString).range(of: textHighlightened, options: .caseInsensitive)
        titleAttString.addAttribute(.foregroundColor, value: SSColors.green.color, range: range)
        attributedText = titleAttString
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        numberOfLines = 2
        textAlignment = .center
    }

}
