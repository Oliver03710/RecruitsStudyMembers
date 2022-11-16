//
//  FoldableCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/15.
//

import UIKit

import SnapKit

final class FoldableCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Enum

    enum Section: Int, CaseIterable, Hashable {
        case title, study, review
    }
    
    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let foldableButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: GeneralIcons.moreArrow90.rawValue), for: .normal)
        return btn
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
    
    // MARK: - Helper Functions
    
    private func setConstraints() {
        
        [nameLabel, foldableButton, titleLabel].forEach { contentView.addSubview($0) }
        
        foldableButton.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).inset(16)
            $0.height.equalTo(12)
            $0.width.equalTo(foldableButton.snp.height).multipliedBy(2)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).inset(16)
            $0.leading.equalTo(self.snp.leading).inset(16)
            $0.height.equalTo(40)
            $0.trailing.equalTo(foldableButton.snp.leading).offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalTo(self.snp.directionalHorizontalEdges).inset(16)
            $0.bottom.equalTo(self.snp.bottom).inset(16)
        }

//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
//            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)
//            ])
//        view.snp.makeConstraints {
//            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
//            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
//        }
        
//        innerCollectionView.snp.makeConstraints {
//            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
//            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
//        }
    }
    
    func configureCell(indexPath: IndexPath, bool: Bool, count: Int) {
        if count > 0 && !bool {
            nameLabel.snp.remakeConstraints {
                $0.top.equalTo(self.snp.top).inset(16)
                $0.leading.equalTo(self.snp.leading).inset(16)
                $0.height.equalTo(40)
                $0.trailing.equalTo(foldableButton.snp.leading).offset(-16)
            }
        } else if count > 0 && bool {
            foldableButton.snp.remakeConstraints {
                $0.centerY.equalTo(nameLabel.snp.centerY)
                $0.trailing.equalTo(self.snp.trailing).inset(16)
                $0.height.equalTo(12)
                $0.width.equalTo(foldableButton.snp.height).multipliedBy(2)
            }
            
            nameLabel.snp.remakeConstraints {
                $0.top.equalTo(self.snp.top).inset(16)
                $0.leading.equalTo(self.snp.leading).inset(16)
                $0.height.equalTo(40)
                $0.trailing.equalTo(foldableButton.snp.leading).offset(-16)
            }
            
            titleLabel.snp.remakeConstraints {
                $0.top.equalTo(nameLabel.snp.bottom).offset(16)
                $0.directionalHorizontalEdges.equalTo(self.snp.directionalHorizontalEdges).inset(16)
                $0.bottom.equalTo(self.snp.bottom).inset(16)
            }
        }
        
        
//        if indexPath.item == 0 {
//            if !bool {
//                [nameLabel].forEach { contentView.addSubview($0) }
//
//                nameLabel.snp.makeConstraints {
//                    $0.edges.equalTo(self.snp.edges).inset(16)
//                }
//            } else {
//                nameLabel.snp.remakeConstraints {
//                    $0.edges.equalTo(self.snp.edges).inset(16)
//                }
//            }
//        } else {
//
//            if !bool {
//                NSLayoutConstraint.activate([
//                    nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//                    nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
//                    nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//                    nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)
//                    ])
//
//                foldableButton.snp.makeConstraints {
//                    $0.centerY.equalTo(nameLabel.snp.centerY)
//                    $0.trailing.equalTo(self.snp.trailing).inset(16)
//                    $0.height.equalTo(12)
//                    $0.width.equalTo(foldableButton.snp.height).multipliedBy(2)
//                }
//
//                nameLabel.snp.makeConstraints {
//                    $0.top.equalTo(self.snp.top).inset(16)
//                    $0.leading.equalTo(self.snp.leading).inset(16)
//                    $0.height.equalTo(40)
//                    $0.trailing.equalTo(foldableButton.snp.leading).offset(-16)
//                }
//
//                titleLabel.snp.makeConstraints {
//                    $0.top.equalTo(nameLabel.snp.bottom).offset(16)
//                    $0.directionalHorizontalEdges.equalTo(self.snp.directionalHorizontalEdges).inset(16)
//                    $0.bottom.equalTo(self.snp.bottom).inset(16)
//                }
//            } else {
//
//                NSLayoutConstraint.activate([
//                    nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//                    nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
//                    nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//                    nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)
//                    ])
//                foldableButton.snp.remakeConstraints {
//                    $0.centerY.equalTo(nameLabel.snp.centerY)
//                    $0.trailing.equalTo(safeAreaLayoutGuide).inset(16)
//                    $0.height.equalTo(12)
//                    $0.width.equalTo(foldableButton.snp.height).multipliedBy(2)
//                }
//
//
//
//                titleLabel.snp.remakeConstraints {
//                    $0.top.equalTo(nameLabel.snp.bottom).offset(16)
//                    $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
//                }
//            }
//
//
//
//
//        }
//
    }
}
