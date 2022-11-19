//
//  FoldableCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/15.
//

import UIKit

import SnapKit

final class FoldableCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: SSFonts.title1M16.fonts, size: SSFonts.title1M16.size)
        label.text = "이름"
        label.backgroundColor = .orange
        return label
    }()
    
    let foldableButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: GeneralIcons.moreArrow90.rawValue), for: .normal)
        btn.backgroundColor = .red
        return btn
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [nameLabel, view].forEach { contentView.addSubview($0) }
        contentView.addSubview(foldableButton)
    }
    
    func setComponents(isFolded: Bool, item: Int) {
        if isFolded {
            nameLabel.snp.makeConstraints {
                $0.top.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
                $0.height.equalTo(40)
            }
            
            foldableButton.snp.makeConstraints {
                $0.centerY.equalTo(nameLabel)
                $0.trailing.equalTo(nameLabel.snp.trailing).inset(16)
                $0.height.equalTo(12)
                $0.width.equalTo(foldableButton.snp.height).multipliedBy(2)
            }
            
        } else {
            nameLabel.snp.makeConstraints {
                $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
                $0.height.equalTo(40)
            }
            
            foldableButton.snp.makeConstraints {
                $0.centerY.equalTo(nameLabel)
                $0.trailing.equalTo(nameLabel.snp.trailing).inset(16)
                $0.height.equalTo(12)
                $0.width.equalTo(foldableButton.snp.height).multipliedBy(2)
            }
            
            view.snp.makeConstraints {
                $0.top.equalTo(nameLabel.snp.bottom).offset(16)
                $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
                $0.height.equalTo(24)
                $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            }
        }
        
    }
    
    
}
