//
//  SearchCollectionReusableView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/22.
//

import UIKit

import SnapKit

final class SearchCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: SSFonts.title6R12.fonts, size: SSFonts.title6R12.size)
        label.textColor = SSColors.black.color
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    func setConstraints() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(8)
        }
    }
    
    func setComponents(indexPath: IndexPath) {
        headerLabel.text = indexPath.section == 0 ? "지금 주변에는" : "내가 하고 싶은"
    }
    
}
