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
    
    private let chatView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray1.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        return tv
    }()
    
    private let sendButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: GeneralIcons.sendInact.rawValue), for: .normal)
        return btn
    }()
    
    private var textViewHeightConstraint: Constraint?
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
        addSubview(chatView)
        chatView.addSubview(textView)
        chatView.addSubview(sendButton)
        
        tableView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(chatView.snp.top).offset(-16)
        }
        
        chatView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.lessThanOrEqualTo(88)
            textViewHeightConstraint = $0.height.greaterThanOrEqualTo(self.textView.contentSize.height + 52).constraint
        }
        
        textView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.directionalVerticalEdges.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(12)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-10)
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(textView)
            $0.height.width.equalTo(20)
            $0.trailing.equalToSuperview().inset(14)
        }
    }
    
    private func bindData() {
        viewModel.usersChat
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.disposeBag)
        
        Observable.merge(textView.rx.didBeginEditing.map { _ in TextFieldActions.editingDidBegin },
                         textView.rx.didEndEditing.map { _ in TextFieldActions.editingDidEnd })
        .asDriver(onErrorJustReturn: .editingDidEnd)
        .drive { [weak self] actions in
            guard let self = self else { return }
            switch actions {
            case .editingDidBegin:
                print(self.textView.contentSize.height)
                self.didUpdateTextViewContentSize()
                
            case .editingDidEnd:
                print(self.textView.contentSize.height)
            }
        }
        .disposed(by: viewModel.disposeBag)
        
        textView.rx
            .didChange
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let size = CGSize(width: self.textView.frame.width, height: .infinity)
                let estimatedSize = self.textView.sizeThatFits(size)
                let isMaxHeight = estimatedSize.height >= 54
                
                guard isMaxHeight != self.textView.isScrollEnabled else { return }
                self.textView.isScrollEnabled = isMaxHeight
                self.textView.reloadInputViews()
                self.setNeedsUpdateConstraints()
            })
            .disposed(by: viewModel.disposeBag)
        
        textView.rx.text
            .orEmpty
            .asDriver()
            .drive { [weak self] str in
                guard let self = self else { return }
                self.sendButton.setImage(UIImage(named: str.isEmpty ? GeneralIcons.sendInact.rawValue : GeneralIcons.sendAct.rawValue), for: .normal)
            }
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
    
    private func didUpdateTextViewContentSize() {
        self.textViewHeightConstraint?.update(offset: self.textView.contentSize.height + 28)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

}
