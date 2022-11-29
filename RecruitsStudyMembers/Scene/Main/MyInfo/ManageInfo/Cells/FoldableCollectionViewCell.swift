//
//  FoldableCollectionViewCell.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/15.
//

import UIKit

import SnapKit

final class FoldableCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - Struct For Collection View Header
    
    struct Headers: Hashable {
        let label = UILabel()
        private let identifier = UUID()
    }
    
    struct Item: Hashable {
        let title: String
        private let identifier = UUID()
        
        static func titles() -> [Item] {
            return [Item(title: "좋은 매너"), Item(title: "정확한 시간 약속"), Item(title: "빠른 응답"), Item(title: "친절한 성격"), Item(title: "능숙한 실력"), Item(title: "유익한 시간")]
        }
        
        static func placeHolder() -> [Item] {
            return [Item(title: "첫 리뷰를 기다리는 중이에요!")]
        }
    }
    
    
    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: SSFonts.title1M16.fonts, size: SSFonts.title1M16.size)
        label.text = "이름"
        label.textColor = SSColors.black.color
        return label
    }()
    
    let foldableImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: GeneralIcons.moreArrow90.rawValue)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.autoresizingMask = [.flexibleHeight]
        cv.contentOffset = .zero
        return cv
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Headers, Item>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Headers, Item>! = nil
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDataSource()
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
    
    override func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        // Replace the height in the target size to
        // allow the cell to flexibly compute its height
        var targetSize = targetSize
        targetSize.height = CGFloat.greatestFiniteMagnitude
        
        // The .required horizontal fitting priority means
        // the desired cell width (targetSize.width) will be
        // preserved. However, the vertical fitting priority is
        // .fittingSizeLevel meaning the cell will find the
        // height that best fits the content
        let size = super.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return size
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [nameLabel, foldableImageView, collectionView].forEach { contentView.addSubview($0) }
        
        nameLabel.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.greaterThanOrEqualTo(40)
        }
        
        foldableImageView.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(12)
            $0.width.equalTo(foldableImageView.snp.height).multipliedBy(2)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    func setComponents(text: String?) {
        nameLabel.text = text
    }
    
    func setAutoLayout(isFolded: Bool) {
        collectionView.isHidden = isFolded
    }
}


extension FoldableCollectionViewCell {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
                
                let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(20))
                
                let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: titleSize,
                    elementKind: SearchCollectionReusableView.reuseIdentifier,
                    alignment: .top)
                section.boundarySupplementaryItems = [titleSupplementary]
                return section
                
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(32))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(32))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0)
                
                let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(28))
                
                let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: titleSize,
                    elementKind: SearchCollectionReusableView.reuseIdentifier,
                    alignment: .top)
                section.boundarySupplementaryItems = [titleSupplementary]
                return section
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()

        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureDataSource() {
        
        let titleCellRegistration = UICollectionView.CellRegistration<SesacTitleCollectionViewCell, Item> { (cell, indexPath, item) in
            cell.setComponents(text: item.title)
        }
        
        let reviewCellRegistration = UICollectionView.CellRegistration<SesacReviewCollectionViewCell, Item> { (cell, indexPath, item) in
            cell.setComponents(text: item.title)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Headers, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            return indexPath.section == 0 ? collectionView.dequeueConfiguredReusableCell(using: titleCellRegistration, for: indexPath, item: item) : collectionView.dequeueConfiguredReusableCell(using: reviewCellRegistration, for: indexPath, item: item)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<SearchCollectionReusableView>(elementKind: SearchCollectionReusableView.reuseIdentifier) {
            supplementaryView, elementKind, indexPath in
            supplementaryView.setComponents(indexPath: indexPath)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        let sesacTitle = Headers()
        sesacTitle.label.text = "새싹 타이틀"
        sesacTitle.label.font = UIFont(name: SSFonts.title6R12.fonts, size: SSFonts.title6R12.size)
        sesacTitle.label.textColor = SSColors.black.color
        
        let sesacReview = Headers()
        sesacReview.label.text = "새싹 리뷰"
        sesacReview.label.font = UIFont(name: SSFonts.title6R12.fonts, size: SSFonts.title6R12.size)
        sesacReview.label.textColor = SSColors.black.color
        
        currentSnapshot = NSDiffableDataSourceSnapshot<Headers, Item>()
        currentSnapshot.appendSections([sesacTitle, sesacReview])
        
        currentSnapshot.appendItems(Item.titles(), toSection: sesacTitle)
        currentSnapshot.appendItems(Item.placeHolder(), toSection: sesacReview)
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
}
