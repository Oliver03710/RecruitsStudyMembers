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
    
    convenience init(text: String, font: String, size: CGFloat, lineHeight: CGFloat, config: UIButton.Configuration, foregroundColor: UIColor? = SSColors.black.color, backgroundColor: UIColor?) {
        self.init()
        configuration = buttonConfiguration(text: text, config: config, foregroundColor: foregroundColor, font: font, size: size, lineHeight: lineHeight)
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - Helper Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    func buttonConfiguration(text: String, config: UIButton.Configuration, foregroundColor: UIColor?, font: String, size: CGFloat, lineHeight: CGFloat) -> UIButton.Configuration {
        var configuration = config
        
        var container = AttributeContainer()
        container.font = UIFont(name: font, size: size)
        container.foregroundColor = foregroundColor
        container.paragraphStyle = paragraphStyle(size: size, lineHeight: lineHeight)
        
        configuration.attributedTitle = AttributedString(text, attributes: container)
        
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
