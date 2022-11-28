//
//  SharedSegmentedView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

import SnapKit

final class SharedSegmentedView: BaseView {

    // MARK: - Enum
    
    enum Section: Int, CaseIterable, Hashable {
        case image, foldable
    }
    
    
    // MARK: - Properties
    
    private let grayImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: GeneralIcons.graySprout.rawValue))
        return iv
    }()
    
    let mainLabel: CustomLabel = {
        let label = CustomLabel(text: "", font: SSFonts.display1R20.fonts, size: SSFonts.display1R20.size)
        label.textAlignment = .center
        return label
    }()
    
    private let subLabel: CustomLabel = {
        let label = CustomLabel(text: "스터디를 변경하거나 조금만 더 기다려 주세요!", font: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size, color: SSColors.gray7.color)
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.autoresizingMask = [.flexibleHeight]
        return cv
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, DefaultUserData>! = nil
    var currentSnapshot = NSDiffableDataSourceSnapshot<Section, DefaultUserData>()
    
    var isFolded = true
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        [grayImageView, mainLabel, subLabel].forEach { addSubview($0) }
        
        mainLabel.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(24)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(8)
            $0.height.equalTo(18)
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        grayImageView.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(mainLabel.snp.top).offset(-44)
            $0.height.equalTo(48)
            $0.width.equalTo(64)
        }
    }
}


// MARK: - Extension: Compositional Layout & Diffable DataSource

extension SharedSegmentedView {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { [weak self] (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let customSection = Section(rawValue: sectionIndex) else { return nil }

            switch customSection {
            case .image:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.56))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                return section

            case .foldable:
                let estimatedHeight = CGFloat(self?.isFolded ?? false ? 72 : 330)

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)

                let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: ReusableView.reuseIdentifier)
                section.decorationItems = [sectionBackgroundDecoration]
                return section
            }
            
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        layout.register(ReusableView.self, forDecorationViewOfKind: ReusableView.reuseIdentifier)
        layout.collectionView?.layoutIfNeeded()
        return layout
    }
    
    private func configureDataSource() {
        
        let imageCellRegistration = UICollectionView.CellRegistration<ImageCollectionViewCell, DefaultUserData> { (cell, indexPath, identifier) in
            var backConfig = UIBackgroundConfiguration.listPlainCell()
            backConfig.image = UIImage(named: "sesacBackground\(NetworkManager.shared.userData.background)")
            backConfig.cornerRadius = 8
            cell.backgroundConfiguration = backConfig
        }
        
        let foldableCellRegistration = UICollectionView.CellRegistration<FoldableCollectionViewCell, DefaultUserData> { [weak self] (cell, indexPath, identifier) in
            guard let bool = self?.isFolded else { return }
            cell.setAutoLayout(isFolded: bool)
            cell.setComponents(text: UserDefaultsManager.userName)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DefaultUserData>(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            
            if indexPath.section % 2 != 0 {
                return collectionView.dequeueConfiguredReusableCell(using: imageCellRegistration, for: indexPath, item: identifier)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: foldableCellRegistration, for: indexPath, item: identifier)
            }
//            guard let customSection = Section(rawValue: indexPath.section) else { return nil }
//
//            switch customSection {
//            case .image: return collectionView.dequeueConfiguredReusableCell(using: imageCellRegistration, for: indexPath, item: identifier)
//            case .foldable: return collectionView.dequeueConfiguredReusableCell(using: foldableCellRegistration, for: indexPath, item: identifier)
//            }
        }
        updateUI()
    }
    
    func updateUI() {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, DefaultUserData>()
        currentSnapshot.appendSections(Section.allCases)
        currentSnapshot.appendItems(DefaultUserData.callOne(), toSection: .image)
        currentSnapshot.appendItems(DefaultUserData.callOne(), toSection: .foldable)
//        isFolded ? currentSnapshot.appendItems(DummyData.callDummy(), toSection: .foldable) : currentSnapshot.appendItems(DummyData.diffDummy(), toSection: .foldable)

        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
}
