//
//  AlertBaseView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/06.
//

import UIKit

final class AlertBaseView: BaseView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(baseRad: CGFloat) {
        self.init()
        cornerRadius(rad: baseRad)
    }
    
    
    // MARK: - Helper Functions
    
    private func cornerRadius(rad: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = rad
    }
}
