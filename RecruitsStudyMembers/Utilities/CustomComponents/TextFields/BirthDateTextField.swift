//
//  BirthDateTextField.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/11.
//

import UIKit

final class BirthDateTextField: UITextField {

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
    }
    
    
    // MARK: - Helper Functions
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        return false
    }
    
}
