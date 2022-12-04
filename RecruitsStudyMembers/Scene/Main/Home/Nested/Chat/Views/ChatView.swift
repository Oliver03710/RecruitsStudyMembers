//
//  ChatView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/04.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit

final class ChatView: BaseView {

    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = UITableView.automaticDimension
        tv.keyboardDismissMode = .onDrag
        tv.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.reuseIdentifier)
        return tv
    }()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ChatSections> { dataSource, tableView, indexPath, item in
        switch item {
        case let .chatCell(cellModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.reuseIdentifier, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
            cell.configureCells(text: cellModel.string)
                return cell
        }
    }
    
    private let viewModel = ChatViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        addData()
        bindData()
    }
    
    override func setConstraints() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindData() {
        viewModel.usersChat
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.disposeBag)
    }
    
    private func addData() {
        let item1 = ChatItems.chatCell(ChatCellModel(string: "첫번째drijphigewoirbwpbm4wopbm4pobm4pob5mpo45mbp4o5bmp45ogdssbsdfbvdsfniodfgnoidsfgnodsfgnoidsfgnsdfogndfiognfignfignignfnodfbndoifbdfb"))
        let item2 = ChatItems.chatCell(ChatCellModel(string: "두번째"))
        let item3 = ChatItems.chatCell(ChatCellModel(string: "세번째"))
        let item4 = ChatItems.chatCell(ChatCellModel(string: "네번째"))
        let item5 = ChatItems.chatCell(ChatCellModel(string: "다섯번째"))
        let section1 = ChatSections(items: [item1, item2, item3, item4, item5])
        
        viewModel.usersChat.accept([section1])
    }

}
