//
//  SearchView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/21.
//

import UIKit

import SnapKit

final class SearchView: BaseView {
    
    // MARK: - Struct For Collection View Header
    
    struct Item: Hashable {
        let label = UILabel()
        private let identifier = UUID()
    }
    
    
    // MARK: - Properties
    
    let seekButton: CustomButton = {
        let btn = CustomButton(text: "새싹 찾기", buttonColor: SSColors.green.color)
        return btn
    }()
    
    let accButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 48))
        btn.backgroundColor = SSColors.green.color
        btn.setTitle("새싹 찾기", for: .normal)
        return btn
    }()
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        sb.sizeToFit()
        return sb
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.backgroundColor = SSColors.white.color
        cv.autoresizingMask = [.flexibleWidth]
        cv.keyboardDismissMode = .onDrag
        return cv
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Item, SearchData>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Item, SearchData>! = nil
    
    let viewModel = SearchViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        configureDataSource()
    }
    
    override func setConstraints() {
        [collectionView, seekButton].forEach { addSubview($0) }
        
        seekButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
        }
        
        collectionView.snp.makeConstraints {
            $0.directionalHorizontalEdges.top.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(seekButton.snp.top).offset(-16)
        }
    }

}


// MARK: - Extension: Compositional Layout & Diffable DataSource

extension SearchView {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .estimated(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0)
                
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: SearchCollectionReusableView.reuseIdentifier,
                alignment: .top)
            
            section.boundarySupplementaryItems = [titleSupplementary]
            
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, SearchData> { [weak self] (cell, indexPath, item) in
            guard let self = self else { return }
            cell.setCellComponents(text: item.title, indexPath: indexPath, NumberOfRecommend: self.viewModel.numberOfRecommend.value)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Item, SearchData>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<SearchCollectionReusableView>(elementKind: SearchCollectionReusableView.reuseIdentifier) {
            [weak self] supplementaryView, elementKind, indexPath in
            if let snapshot = self?.currentSnapshot {
                let category = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.setComponents(text: category.label.text)
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
    }
    
    func updateUI() {
        
        let aroundNow = Item()
        aroundNow.label.text = "지금 주변에는"
        aroundNow.label.font = UIFont(name: SSFonts.title6R12.fonts, size: SSFonts.title6R12.size)
        aroundNow.label.textColor = SSColors.black.color
        
        let willingTo = Item()
        willingTo.label.text = "내가 하고 싶은"
        willingTo.label.font = UIFont(name: SSFonts.title6R12.fonts, size: SSFonts.title6R12.size)
        willingTo.label.textColor = SSColors.black.color
        
        currentSnapshot = NSDiffableDataSourceSnapshot<Item, SearchData>()
        currentSnapshot.appendSections([aroundNow, willingTo])
        
        currentSnapshot.appendItems(viewModel.studyList.value, toSection: aroundNow)
        currentSnapshot.appendItems(viewModel.mychoiceList.value, toSection: willingTo)
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
}
