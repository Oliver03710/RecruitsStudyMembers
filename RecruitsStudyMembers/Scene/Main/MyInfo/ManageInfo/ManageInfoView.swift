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
        case image, foldable, gender, study, searchMe
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
        
        let layout = UICollectionViewCompositionalLayout { [weak self] (section, env) -> NSCollectionLayoutSection? in

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
                let estimatedHeight = CGFloat(800)
                
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .estimated(estimatedHeight))
                
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                      heightDimension: .estimated(estimatedHeight))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//                let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                      heightDimension: .estimated(estimatedHeight2))
//                let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
//
//                let itemSize3 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                      heightDimension: .estimated(estimatedHeight3))
//                let item3 = NSCollectionLayoutItem(layoutSize: itemSize3)
//
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                       heightDimension: .estimated(estimatedHeight))
//                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
//                                                               subitems: [item, item2, item3])
                
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize,
                                                               subitem: item,
                                                               count: 3)
                
                let section = NSCollectionLayoutSection(group: group)
                
                let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "reusableView")
                section.decorationItems = [sectionBackgroundDecoration]
                return section

            case .gender, .study, .searchMe:
                guard let height = self?.window?.windowScene?.screen.bounds.height else { return nil }
                let estimatedHeight = CGFloat(height / 10)
                
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .estimated(estimatedHeight))
                
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize,
                                                               subitem: item,
                                                               count: 1)

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
        }

        let genderCellRegistration = UICollectionView.CellRegistration<GenderCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            cell.backgroundColor = .yellow
        }
        
        let studyCellRegistration = UICollectionView.CellRegistration<StudyCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            cell.backgroundColor = .brown
        }
        
        let searchMeCellRegistration = UICollectionView.CellRegistration<SearchMeCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            cell.backgroundColor = .brown
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DummyData>(collectionView: collectionView)
        { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            
            guard let customSection = Section(rawValue: indexPath.section) else { return nil }
            
            switch customSection {
            case .image: return collectionView.dequeueConfiguredReusableCell(using: imageCellRegistration, for: indexPath, item: identifier)
            case .foldable: return collectionView.dequeueConfiguredReusableCell(using: foldableCellRegistration, for: indexPath, item: identifier)
            case .gender: return collectionView.dequeueConfiguredReusableCell(using: genderCellRegistration, for: indexPath, item: identifier)
            case .study: return collectionView.dequeueConfiguredReusableCell(using: studyCellRegistration, for: indexPath, item: identifier)
            case .searchMe: return collectionView.dequeueConfiguredReusableCell(using: searchMeCellRegistration, for: indexPath, item: identifier)
            }
        }
        updateUI()
    }
    
    func updateUI() {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, DummyData>()
        currentSnapshot.appendSections(Section.allCases)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .image)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .foldable)
        
//        !isHiddens ?
//        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .foldable) : currentSnapshot.appendItems(DummyData.diffDummy(), toSection: .foldable)
//
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .gender)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .study)

        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
}
