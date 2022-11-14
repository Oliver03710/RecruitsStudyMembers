//
//  MyinfoView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

final class MyinfoView: BaseView {

    // MARK: - Enum
    
    enum Section {
        case main
    }

    
    // MARK: - Properties
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MyinfoView.NewsFeedItem>!
    
    lazy var items: [NewsFeedItem] = {
       return itemsInternal()
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        configureHierarchy()
        configureDataSource()
    }
    
}

extension MyinfoView {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    func configureDataSource() {
        
        
        let cellRegistration = UICollectionView.CellRegistration
        <MyinfoCollectionViewCell, NewsFeedItem> { (cell, indexPath, newsItem) in
            // Populate the cell with our item description.
            cell.titleLabel.text = newsItem.title
            cell.bodyLabel.text = newsItem.body

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            cell.dateLabel.text = dateFormatter.string(from: newsItem.date)
            cell.showsSeparator = indexPath.item != self.items.count - 1
        }
        
        dataSource = UICollectionViewDiffableDataSource
        <Section, NewsFeedItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: NewsFeedItem) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        // load our data
        let newsItems = items
        var snapshot = NSDiffableDataSourceSnapshot<Section, NewsFeedItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newsItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func createLayout() -> UICollectionViewLayout {
        let estimatedHeight = CGFloat(100)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                       subitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }


    
    
    struct NewsFeedItem: Hashable {
        let title: String
        let date: Date
        let body: String
        let identifier = UUID()

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        init(title: String, date: DateComponents, body: String) {
            self.title = title
            self.date = DateComponents(calendar: Calendar.current,
                                       year: date.year,
                                       month: date.month,
                                       day: date.day).date!
            self.body = body
        }
        
    }
    
    

    
}


extension MyinfoView {
    func itemsInternal() -> [NewsFeedItem] {
        return [ NewsFeedItem(title: "Conference 2019 Registration Now Open",
                              date: DateComponents(year: 2019, month: 3, day: 14), body: """
                    Register by Wednesday, March 20, 2019 at 5:00PM PSD for your chance to join us and thousands
                    of coders, creators, and crazy ones at this year's Conference 19 in San Jose, June 3-7.
                    """),
                 NewsFeedItem(title: "Apply for a Conference19 Scholarship",
                              date: DateComponents(year: 2019, month: 3, day: 14), body: """
                    Conference Scholarships reward talented studens and STEM orgination members with the opportunity
                    to attend this year's conference. Apply by Sunday, March 24, 2019 at 5:00PM PDT
                    """),
                 NewsFeedItem(title: "Conference18 Video Subtitles Now in More Languages",
                              date: DateComponents(year: 2019, month: 8, day: 8), body: """
                    All of this year's session videos are now available with Japanese and Simplified Chinese subtitles.
                    Watch in the Videos tab or on the Apple Developer website.
                    """),
                 NewsFeedItem(title: "Lunchtime Inspiration",
                              date: DateComponents(year: 2019, month: 6, day: 8), body: """
                    All of this year's session videos are now available with Japanese and Simplified Chinease subtitles.
                    Watch in the Videos tab or on the Apple Developer website.
                    """),
                 NewsFeedItem(title: "Close Your Rings Challenge",
                              date: DateComponents(year: 2019, month: 6, day: 8), body: """
                    Congratulations to all Close Your Rings Challenge participants for staying active
                    throughout the week! Everyone who participated in the challenge can pick up a
                    special reward pin outside on the Plaza until 5:00 p.m.
                    """)
        ]
    }
}
