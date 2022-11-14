//
//  ManageInfoView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

final class ManageInfoView: BaseView {

    // MARK: - Properties
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MyinfoView.NewsFeedItem>!
    
    lazy var items: [NewsFeedItem] = {
       return itemsInternal()
    }()
    
    var data:[PresentMenuSectionModel] = []

    // 케이스 1
    self.data.append(.SectionMainTitle(items: [PresentMenuTitleItem(image: hasImage, mainTitle: self.title, description: hasData?.description)]))
    // 케이스 2
    self.data.append(.SectionMenu(header: section.title, selectType: sectionType, items: menuBundle))
    // 케이스 3
    self.data.append(.SectionSelectCount(items: [PresentSelectCountItem(count: 1)]))
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
    
    

}
