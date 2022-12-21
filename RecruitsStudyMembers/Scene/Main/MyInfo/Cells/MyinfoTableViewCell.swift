//
//  MyinfoTableViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/15.
//

import UIKit

import SnapKit

final class MyinfoTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    let imagesView: CircleImageView = {
        let iv = CircleImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let zeroIndexImageView: CircleImageView = {
        let iv = CircleImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        iv.isHidden = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let indicatorImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: GeneralIcons.moreArrow.rawValue))
        iv.contentMode = .scaleAspectFit
        iv.isHidden = true
        return iv
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    
    func setConstraints() {
        [imagesView, zeroIndexImageView, titleLabel, indicatorImageView].forEach { contentView.addSubview($0) }
        
        imagesView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.directionalVerticalEdges.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.width.equalTo(imagesView.snp.height)
        }
        
        zeroIndexImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.directionalVerticalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(zeroIndexImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imagesView.snp.trailing).offset(16)
            make.directionalVerticalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.width.equalToSuperview().inset(16)
        }
        
        indicatorImageView.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).inset(20)
            make.directionalVerticalEdges.equalTo(self.safeAreaLayoutGuide).inset(28)
            make.width.equalTo(indicatorImageView.snp.height)
        }
    }
    
    func setCellComponents(text: String, image: String, indexPath: IndexPath) {
        
        imagesView.image = UIImage(named: image)
        
        if indexPath.row == 0 {
            zeroIndexImageView.image = UIImage(named: image)
            zeroIndexImageView.layer.borderWidth = 1
            zeroIndexImageView.layer.borderColor = SSColors.gray2.color.cgColor
            indicatorImageView.isHidden = false
            zeroIndexImageView.isHidden = false
            imagesView.isHidden = true
        }
        
        titleLabel.text = text
        titleLabel.font = indexPath.row == 0 ? UIFont(name: SSFonts.title1M16.fonts, size: SSFonts.title1M16.size) : UIFont(name: SSFonts.title2R16.fonts, size: SSFonts.title2R16.size)
    }
    
}
