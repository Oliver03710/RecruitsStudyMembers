//
//  ManageInfoView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import SnapKit

final class ManageInfoView: BaseView {
    
    // MARK: - Enum
    
    enum Section: Int, CaseIterable, Hashable {
        case image, foldable, rest
    }
    
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return cv
    }()
    var isHiddens = false
    var count = 0
    
    var dataSource: UICollectionViewDiffableDataSource<Section, DummyData>! = nil
    var currentSnapshot = NSDiffableDataSourceSnapshot<Section, DummyData>()
    
    let viewModel = ManageInfoViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDataSource()
        collectionView.bounces = false
    }
    
    override func setConstraints() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
}


// MARK: - Extension: Compositional Layout & Diffable DataSource

extension ManageInfoView {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in

            guard let customSection = Section(rawValue: section) else { return nil }

            switch customSection {
            case .image:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(0.56))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                return section

            case .foldable:
                let estimatedHeight = CGFloat(50)
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .estimated(estimatedHeight))
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                               subitem: item,
                                                               count: 1)
                let section = NSCollectionLayoutSection(group: group)
                
                let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "reusableView")
                section.decorationItems = [sectionBackgroundDecoration]
                return section

            case .rest:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(0.2))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                return section
            }
        }
        
        layout.register(ReusableView.self, forDecorationViewOfKind: "reusableView")
        return layout
    }
    
    private func configureDataSource() {
        
        let imageCellRegistration = UICollectionView.CellRegistration<ImageCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            cell.foreImageView.image = UIImage(named: identifier.foregroundImage!)
            
            
            
            var backConfig = UIBackgroundConfiguration.listPlainCell()
            backConfig.image = UIImage(named: identifier.backgroundImage!)
            backConfig.cornerRadius = 8
            cell.backgroundConfiguration = backConfig
            
        }
        
        let foldableCellRegistration = UICollectionView.CellRegistration<FoldableCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            

            
            cell.nameLabel.text = identifier.name
            cell.titleLabel.text = identifier.title
            cell.configureCell(indexPath: indexPath, bool: self.isHiddens, count: self.count)
//            cell.configureCell(indexPath: indexPath, bool: self.isHiddens)
//            cell.configureCell(isHidden: self.isHiddens)
//            var backConfig = UIBackgroundConfiguration.listPlainCell()
//            backConfig.cornerRadius = 8
            
//            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//            backConfig.strokeColor = SSColors.gray2.color
//            backConfig.strokeWidth = 1
//            cell.backgroundConfiguration = backConfig
        }

        let restCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
//            cell.label.text = "\(identifier)"
//            cell.contentView.backgroundColor = SSColors.yellowGreen.color
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 1
//            cell.label.textAlignment = .center
//            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DummyData>(collectionView: collectionView)
        { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            
            guard let customSection = Section(rawValue: indexPath.section) else { return nil }
            
            switch customSection {
            case .image:
                print(indexPath)
                return collectionView.dequeueConfiguredReusableCell(using: imageCellRegistration, for: indexPath, item: identifier)
            case .foldable:
                print(indexPath)
                return collectionView.dequeueConfiguredReusableCell(using: foldableCellRegistration, for: indexPath, item: identifier)
            case .rest:
                print(indexPath)
                return collectionView.dequeueConfiguredReusableCell(using: imageCellRegistration, for: indexPath, item: identifier)
            }
        }
        updateUI()

//        currentSnapshot = NSDiffableDataSourceSnapshot<Section, DummyData>()
//        Section.allCases.forEach { section in
//            currentSnapshot.appendSections([section])
//            currentSnapshot.appendItems(DummyData.callDummy(), toSection: section)
//        }
//        dataSource.apply(currentSnapshot, animatingDifferences: true)

    }
    
    func updateUI() {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, DummyData>()
        currentSnapshot.appendSections(Section.allCases)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .image)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .rest)
        if !isHiddens {
            currentSnapshot.appendItems(DummyData.callDummy(), toSection: .foldable)
        } else {
            currentSnapshot.appendItems(DummyData.diffDummy(), toSection: .foldable)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
}
