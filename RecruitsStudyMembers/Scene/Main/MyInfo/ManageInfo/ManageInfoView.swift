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
        case image, foldable, gender, study, searchMe, age, deleteAccount
    }
    
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.autoresizingMask = [.flexibleHeight]
        return cv
    }()
    
    var isFolded = true
    
    var dataSource: UICollectionViewDiffableDataSource<Section, DummyData>! = nil
    var currentSnapshot = NSDiffableDataSourceSnapshot<Section, DummyData>()
    
    let viewModel = ManageInfoViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        configureDataSource()
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
        
        let sectionProvider = { [weak self] (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let customSection = Section(rawValue: sectionIndex) else { return nil }
            guard let height = self?.window?.windowScene?.screen.bounds.height else { return nil }

            switch customSection {
            case .image:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.56))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                return section

            case .foldable:
                let estimatedHeight = CGFloat(400)

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

//                let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: ReusableView.reuseIdentifier)
//                section.decorationItems = [sectionBackgroundDecoration]
                return section

            case .gender, .study, .searchMe, .age:

                let estimatedHeight = CGFloat(height / 10)

                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))

                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitem: item, count: 1)

                let section = NSCollectionLayoutSection(group: group)

                return section

            case .deleteAccount:

                let estimatedHeight = CGFloat(height / 13)

                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))

                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitem: item, count: 1)

                let section = NSCollectionLayoutSection(group: group)

                return section
            }
            
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
//        layout.register(ReusableView.self, forDecorationViewOfKind: ReusableView.reuseIdentifier)
        layout.collectionView?.layoutIfNeeded()
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
        
        let foldableCellRegistration = UICollectionView.CellRegistration<FoldableCollectionViewCell, DummyData> { [weak self] (cell, indexPath, identifier) in
            guard let bool = self?.isFolded else { return }
            cell.setComponents(text: identifier.name)
            cell.setAutoLayout(isFolded: bool)
            
            var backConfig = UIBackgroundConfiguration.listPlainCell()
            backConfig.strokeColor = SSColors.gray2.color
            backConfig.strokeWidth = 1.0
            backConfig.cornerRadius = 8.0
            cell.backgroundConfiguration = backConfig
        }

        let genderCellRegistration = UICollectionView.CellRegistration<GenderCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            
        }
        
        let studyCellRegistration = UICollectionView.CellRegistration<StudyCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            
        }
        
        let searchMeCellRegistration = UICollectionView.CellRegistration<SearchMeCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            
        }
        
        let ageCellRegistration = UICollectionView.CellRegistration<AgeChoiceCollectionViewCell, DummyData> { (cell, indexPath, identifier) in
            
        }
        
        let resignCellRegistration = UICollectionView.CellRegistration<DeleteAccountCollectionViewCell, DummyData> { (cell, indexPath, identifier) in

        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DummyData>(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            
            guard let customSection = Section(rawValue: indexPath.section) else { return nil }
            
            switch customSection {
            case .image: return collectionView.dequeueConfiguredReusableCell(using: imageCellRegistration, for: indexPath, item: identifier)
            case .foldable: return collectionView.dequeueConfiguredReusableCell(using: foldableCellRegistration, for: indexPath, item: identifier)
            case .gender: return collectionView.dequeueConfiguredReusableCell(using: genderCellRegistration, for: indexPath, item: identifier)
            case .study: return collectionView.dequeueConfiguredReusableCell(using: studyCellRegistration, for: indexPath, item: identifier)
            case .searchMe: return collectionView.dequeueConfiguredReusableCell(using: searchMeCellRegistration, for: indexPath, item: identifier)
            case .age: return collectionView.dequeueConfiguredReusableCell(using: ageCellRegistration, for: indexPath, item: identifier)
            case .deleteAccount: return collectionView.dequeueConfiguredReusableCell(using: resignCellRegistration, for: indexPath, item: identifier)
            }
        }
        updateUI()
    }
    
    func updateUI() {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, DummyData>()
        currentSnapshot.appendSections(Section.allCases)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .image)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .foldable)
//        isFolded ? currentSnapshot.appendItems(DummyData.callDummy(), toSection: .foldable) : currentSnapshot.appendItems(DummyData.diffDummy(), toSection: .foldable)

        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .gender)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .study)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .searchMe)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .age)
        currentSnapshot.appendItems(DummyData.callDummy(), toSection: .deleteAccount)

        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
}
