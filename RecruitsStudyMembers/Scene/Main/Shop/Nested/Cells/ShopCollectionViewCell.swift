//
//  ShopCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/15.
//

import UIKit

final class ShopCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    let foreImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "")
        return iv
    }()
    
    var state: ShopViewSelected = .face
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(state: ShopViewSelected) {
        self.init()
        self.state = state
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [foreImageView].forEach { contentView.addSubview($0) }
        
        foreImageView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    func ConfigureCells(image: String) {
        foreImageView.image = UIImage(named: image)
    }
}
