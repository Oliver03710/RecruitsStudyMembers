//
//  SharedSegmentedView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

import RxSwift
import SnapKit

final class SharedSegmentedView: BaseView {

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
    
    let changeStudyButton: CustomButton = {
        let btn = CustomButton(text: "스터디 변경하기", buttonColor: SSColors.green.color)
        return btn
    }()
    
    let refreshButton: CustomButton = {
        let btn = CustomButton(image: GeneralIcons.refresh.rawValue)
        return btn
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        cv.isHidden = true
        return cv
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<MemberListData, MemberListData>! = nil
    var currentSnapshot = NSDiffableDataSourceSnapshot<MemberListData, MemberListData>()
    
    let viewModel = MemberListViewModel()
    
    var isFolded = true
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        configureDataSource()
    }
    
    override func setConstraints() {
        [grayImageView, mainLabel, subLabel, refreshButton, changeStudyButton, collectionView].forEach { addSubview($0) }
        
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
        
        refreshButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.width.equalTo(48)
        }

        changeStudyButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.trailing.equalTo(refreshButton.snp.leading).offset(-8)
            $0.height.equalTo(48)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    func makeHidden(isHidden: Bool = false) {
        grayImageView.isHidden = isHidden
        mainLabel.isHidden = isHidden
        subLabel.isHidden = isHidden
        refreshButton.isHidden = isHidden
        changeStudyButton.isHidden = isHidden
        
        collectionView.isHidden = !isHidden
    }
}


// MARK: - Extension: Compositional Layout & Diffable DataSource

extension SharedSegmentedView {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let width = self.window?.windowScene?.screen.bounds.width else { return nil }
            let estimatedHeight = CGFloat(72)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(width * 0.54))
            
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: HeaderImageCollectionReusableView.reuseIdentifier,
                alignment: .top)
            
//            let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: ReusableView.reuseIdentifier)
//            section.decorationItems = [sectionBackgroundDecoration]
            section.boundarySupplementaryItems = [titleSupplementary]
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
//        layout.register(ReusableView.self, forDecorationViewOfKind: ReusableView.reuseIdentifier)
        return layout
    }
    
    func configureDataSource() {
        let foldableCellRegistration = UICollectionView.CellRegistration<FoldableCollectionViewCell, MemberListData> { [weak self] (cell, indexPath, identifier) in
            guard let bool = self?.isFolded else { return }
            
            var backConfig = UIBackgroundConfiguration.listPlainCell()
            backConfig.strokeColor = SSColors.gray2.color
            backConfig.strokeWidth = 1
            backConfig.cornerRadius = 8
            
            cell.backgroundConfiguration = backConfig
            cell.setAutoLayout(isFolded: bool)
            cell.setComponents(text: identifier.data.nick)
            
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<HeaderImageCollectionReusableView>(elementKind: HeaderImageCollectionReusableView.reuseIdentifier) {
            [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return }
            supplementaryView.setComponents(indexPath: indexPath, backgroundImg: self.viewModel.memberList.value[indexPath.section].data.background, foregroundImg: self.viewModel.memberList.value[indexPath.section].data.sesac)
        }
        
        dataSource = UICollectionViewDiffableDataSource<MemberListData, MemberListData>(collectionView: collectionView) {
            (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: foldableCellRegistration, for: indexPath, item: identifier)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        updateUI()
    }
    
    func updateUI() {
        currentSnapshot = NSDiffableDataSourceSnapshot<MemberListData, MemberListData>()
        
        viewModel.memberList.value.forEach { data in
            currentSnapshot.appendSections([data])
            currentSnapshot.appendItems([data], toSection: data)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
}
