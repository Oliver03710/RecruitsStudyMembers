//
//  CustomImageView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

class CustomImageView: UIImageView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, image: UIImage? = nil) {
        self.init(frame: frame)
        self.image = image
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        self.contentMode = .scaleAspectFill
    }

}
