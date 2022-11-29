//
//  SearchCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/22.
//

import UIKit

import SnapKit

final class SearchCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Properties
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.white.color
        view.layer.borderWidth = 1.0
        view.layer.borderColor = SSColors.gray4.color.cgColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let studyLabel: UILabel = {
        let label = CustomLabel(text: "", font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size)
        return label
    }()
    
    private let xMarkImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "xmark"))
        iv.contentMode = .scaleAspectFill
        iv.tintColor = SSColors.green.color
        return iv
    }()
    
    var sections = 0
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let targetSize = CGSize(width: sections == 0 ? studyLabel.intrinsicContentSize.width + 36 : studyLabel.intrinsicContentSize.width + 68, height: 50)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        contentView.addSubview(baseView)
        baseView.addSubview(studyLabel)
        baseView.addSubview(xMarkImageView)

        baseView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(4)
            $0.directionalVerticalEdges.equalTo(safeAreaLayoutGuide).inset(4)
        }

        xMarkImageView.snp.makeConstraints {
            $0.directionalVerticalEdges.equalTo(baseView.safeAreaLayoutGuide).inset(8)
            $0.trailing.equalTo(baseView.safeAreaLayoutGuide).inset(12)
            $0.width.height.equalTo(16)
        }

        studyLabel.snp.makeConstraints {
            $0.leading.equalTo(baseView.safeAreaLayoutGuide).inset(12)
            $0.trailing.equalTo(xMarkImageView.snp.leading).offset(-4)
            $0.directionalVerticalEdges.equalTo(baseView.safeAreaLayoutGuide).inset(8)
        }
        
    }
    
    func setCellComponents(text: String?, indexPath: IndexPath, NumberOfRecommend: Int) {
        studyLabel.text = text
        
        if indexPath.section == 0 {
            studyLabel.snp.remakeConstraints {
                $0.edges.equalTo(baseView.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
            }
            
            xMarkImageView.isHidden = true
            baseView.layer.borderColor = (0..<NumberOfRecommend).contains(indexPath.item) ? SSColors.error.color.cgColor : SSColors.gray4.color.cgColor
            studyLabel.textColor = (0..<NumberOfRecommend).contains(indexPath.item) ? SSColors.error.color : SSColors.black.color
            
        } else {
            xMarkImageView.isHidden = false
            baseView.layer.borderColor = SSColors.green.color.cgColor
            studyLabel.textColor = SSColors.green.color
            
        }
    }
    
}
