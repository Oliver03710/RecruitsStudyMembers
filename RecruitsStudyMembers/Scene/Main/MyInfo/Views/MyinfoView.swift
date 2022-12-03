//
//  MyinfoView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import SnapKit

final class MyinfoView: BaseView {
    
    // MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(MyinfoTableViewCell.self, forCellReuseIdentifier: MyinfoTableViewCell.reuseIdentifier)
        tv.dataSource = self
        tv.tableHeaderView = UIView()
        tv.bounces = false
        return tv
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.bottom.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            
        }
    }
}


// MARK: - Extension: UITableViewDataSource

extension MyinfoView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyInfo.itemsInternal().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyinfoTableViewCell.reuseIdentifier, for: indexPath) as? MyinfoTableViewCell else { return UITableViewCell() }
        
        cell.setCellComponents(text: MyInfo.itemsInternal()[indexPath.row].title, image: MyInfo.itemsInternal()[indexPath.row].image, indexPath: indexPath)
        
        return cell
    }
}
