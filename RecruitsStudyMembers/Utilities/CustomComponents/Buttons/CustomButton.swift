//
//  CustomButton.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

final class CustomButton: UIButton {

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
    
    // 회원가입 화면 성별 버튼
    convenience init(text: String, borderColor: UIColor? = SSColors.gray3.color, image: String) {
        self.init()
        var configuration = UIButton.Configuration.plain()
        let style = NSMutableParagraphStyle()
        let lineHeights = SSFonts.title2R16.size * SSFonts.title2R16.lineHeight
        style.minimumLineHeight = lineHeights
        style.maximumLineHeight = lineHeights
        
        var container = AttributeContainer()
        container.font = UIFont(name: SSFonts.title2R16.fonts, size: SSFonts.title2R16.size)
        container.foregroundColor = SSColors.black.color
        container.paragraphStyle = style
        container.baselineOffset = (lineHeights - SSFonts.title2R16.size) / 4
        
        configuration.attributedTitle = AttributedString(text, attributes: container)
        configuration.imagePlacement = .top
        configuration.imagePadding = 5
        configuration.titleAlignment = .center
        
        setImage(UIImage(named: image), for: .normal)
        self.configuration = configuration
        
        tintColor = SSColors.white.color
        
        layer.borderWidth = 1
        layer.borderColor = borderColor?.cgColor
    }
    
    // 정보관리 화면 성별 버튼
    convenience init(text: String, borderColor: UIColor? = SSColors.gray3.color, backgroundColor: UIColor? = SSColors.white.color) {
        self.init()
        setTitle(text, for: .normal)
        self.backgroundColor = backgroundColor
        layer.borderWidth = 1
        layer.borderColor = borderColor?.cgColor
        setTitleColor(backgroundColor == SSColors.green.color ? SSColors.white.color : SSColors.black.color, for: .normal)
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        clipsToBounds = true
        layer.cornerRadius = 8
    }

}
