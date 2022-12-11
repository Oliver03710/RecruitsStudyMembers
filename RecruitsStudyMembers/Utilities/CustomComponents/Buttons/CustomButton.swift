//
//  CustomButton.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

final class CustomButton: UIButton {

    // MARK: - Properties
    
    var toggle = ButtonToggle.on
    
    
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
    
    // 지도 화면의 현재 위치 버튼
    convenience init(image: String) {
        self.init()
        setImage(UIImage(named: image), for: .normal)
        backgroundColor = SSColors.white.color
    }
    
    // 새싹 찾기의 요청 버튼
    convenience init(state: CustomAlertState) {
        self.init()
        let style = NSMutableParagraphStyle()
        let lineHeights = SSFonts.title3M14.size * SSFonts.title3M14.lineHeight
        style.minimumLineHeight = lineHeights
        style.maximumLineHeight = lineHeights
        
        var container = AttributeContainer()
        container.font = UIFont(name: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size)
        container.foregroundColor = SSColors.white.color
        container.paragraphStyle = style
        container.baselineOffset = (lineHeights - SSFonts.title2R16.size) / 4
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString(state == .sendRequest ? "요청하기" : "수락하기", attributes: container)
        configuration.titleAlignment = .center
        self.configuration = configuration
        
        self.backgroundColor = state == .sendRequest ? SSColors.error.color : SSColors.success.color
        layer.borderWidth = 1
        layer.borderColor = state == .sendRequest ? SSColors.error.color.cgColor : SSColors.success.color.cgColor
    }
    
    // 채팅의 더보기 버튼
    convenience init(text: String, image: String, config: UIButton.Configuration, tint: UIColor?, foregroundColor: UIColor?, font: String, size: CGFloat, lineHeight: CGFloat) {
        self.init()
        setImage(UIImage(named: image), for: .normal)
        tintColor = tint
        self.configuration = buttonConfiguration(text: text, withImage: true, config: config, foregroundColor: foregroundColor, font: font, size: size, lineHeight: lineHeight)
    }
    
    // 채팅 더보기 이후 버튼
    convenience init(text: String, withImage: Bool, config: UIButton.Configuration, borderColor: UIColor? = SSColors.gray4.color, foregroundColor: UIColor?, font: String, size: CGFloat, lineHeight: CGFloat) {
        self.init()
        layer.borderWidth = 1
        layer.borderColor = borderColor?.cgColor
        clipsToBounds = true
        layer.cornerRadius = 8
        tintColor = SSColors.black.color
        self.configuration = buttonConfiguration(text: text, withImage: withImage, config: config, foregroundColor: foregroundColor, font: font, size: size, lineHeight: lineHeight)
    }

    
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    func buttonConfiguration(text: String, withImage: Bool, config: UIButton.Configuration, foregroundColor: UIColor? ,font: String, size: CGFloat, lineHeight: CGFloat) -> UIButton.Configuration {
        var configuration = config
        
        var container = AttributeContainer()
        container.font = UIFont(name: font, size: size)
        container.foregroundColor = foregroundColor
        container.paragraphStyle = paragraphStyle(size: size, lineHeight: lineHeight)
        container.baselineOffset = (size * lineHeight - size) / 4
        
        configuration.attributedTitle = AttributedString(text, attributes: container)
        
        if withImage {
            configuration.imagePlacement = .top
            configuration.imagePadding = 10
            configuration.titleAlignment = .center
        }
        
        return configuration
    }
    
    private func paragraphStyle(size: CGFloat, lineHeight: CGFloat) -> NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        let lineHeights = size * lineHeight
        style.minimumLineHeight = lineHeights
        style.maximumLineHeight = lineHeights
        return style
    }

}
