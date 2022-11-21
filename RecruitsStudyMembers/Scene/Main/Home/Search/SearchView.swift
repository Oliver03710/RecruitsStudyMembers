//
//  SearchView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/21.
//

import UIKit

final class SearchView: BaseView {
    
    // MARK: - Properties
    
    let seekButton: CustomButton = {
        let btn = CustomButton(text: "새싹 찾기", buttonColor: SSColors.green.color)
        return btn
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        
    }

}
