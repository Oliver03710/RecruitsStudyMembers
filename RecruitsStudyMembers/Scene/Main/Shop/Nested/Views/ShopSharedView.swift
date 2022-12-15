//
//  ShopSharedView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/15.
//

import UIKit

import SnapKit

final class ShopSharedView: BaseView {
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.autoresizingMask = [.flexibleHeight]
        return cv
    }()
    
    var faceDataSource: UICollectionViewDiffableDataSource<Int, FaceImages>! = nil
    var faceCurrentSnapshot: NSDiffableDataSourceSnapshot<Int, FaceImages>! = nil
    
    var backgroundDataSource: UICollectionViewDiffableDataSource<Int, BackgroundImages>! = nil
    var backgroundCurrentSnapshot: NSDiffableDataSourceSnapshot<Int, BackgroundImages>! = nil
    
    var state: ShopViewSelected = .face
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(state: ShopViewSelected) {
        self.init()
        self.state = state
        configureDataSource(state: state)
    }
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }
}


// MARK: - Extension: Compositional Layout & Diffable DataSource

extension ShopSharedView {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalWidth(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.contentInsets = .init(top: 0, leading: 0, bottom: 24, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureDataSource(state: ShopViewSelected) {
        switch state {
        case .face:
            let cellRegistration = UICollectionView.CellRegistration<ShopCollectionViewCell, FaceImages> { (cell, indexPath, item) in
                cell.ConfigureCells(image: "sesacFace\(item.rawValue)")
            }
            
            faceDataSource = UICollectionViewDiffableDataSource<Int, FaceImages>(collectionView: collectionView) {
                (collectionView, indexPath, item) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
            
            faceCurrentSnapshot = NSDiffableDataSourceSnapshot<Int, FaceImages>()
            faceCurrentSnapshot.appendSections([0])
            faceCurrentSnapshot.appendItems(FaceImages.allCases)
            faceDataSource.apply(faceCurrentSnapshot, animatingDifferences: false)
            
        case .background:
            let cellRegistration = UICollectionView.CellRegistration<ShopCollectionViewCell, BackgroundImages> { (cell, indexPath, item) in
                cell.ConfigureCells(image: "sesacBackground\(item.rawValue)")
            }
            
            backgroundDataSource = UICollectionViewDiffableDataSource<Int, BackgroundImages>(collectionView: collectionView) {
                (collectionView, indexPath, item) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
            
            backgroundCurrentSnapshot = NSDiffableDataSourceSnapshot<Int, BackgroundImages>()
            backgroundCurrentSnapshot.appendSections([0])
            backgroundCurrentSnapshot.appendItems(BackgroundImages.allCases)
            backgroundDataSource.apply(backgroundCurrentSnapshot, animatingDifferences: false)
        }
    }
}
