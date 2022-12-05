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
        tv.bounces = false
        tv.rowHeight = UITableView.automaticDimension
        tv.keyboardDismissMode = .onDrag
        tv.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.reuseIdentifier)
        tv.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.reuseIdentifier)
        return tv
    }()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ChatSections> { dataSource, tableView, indexPath, item in
        switch item {
        case let .dateCell(dateModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier, for: indexPath) as? DateTableViewCell else { return UITableViewCell() }
            cell.configureCells(date: dateModel.string)
                return cell
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
        tv.textColor = SSColors.gray7.color
        tv.text = "메세지를 입력하세요"
        tv.font = UIFont(name: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size)
        return tv
    }()
    
    private let sendButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: GeneralIcons.sendInact.rawValue), for: .normal)
        return btn
    }()
    
    private var textViewHeightConstraint: Constraint?
    var chatViewBottomConstraint: Constraint?
    private let viewModel = ChatViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Selectors
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
//        if textView.isEditable {
            guard let constraint = chatViewBottomConstraint else { return }
            moveViewWithKeyboard(notification: notification, viewBottomConstraint: constraint, keyboardWillShow: true)
//        }
    }
        
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let constraint = chatViewBottomConstraint else { return }
        moveViewWithKeyboard(notification: notification, viewBottomConstraint: constraint, keyboardWillShow: false)
    }


    // MARK: - Helper Functions
    
    override func configureUI() {
        addData()
        bindData()
        keyboardActions()
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
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            chatViewBottomConstraint = $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16).constraint
            $0.height.lessThanOrEqualTo(98)
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
        viewModel.dateSection
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.disposeBag)
        
        Observable.merge(textView.rx.didBeginEditing.map { _ in TextFieldActions.editingDidBegin },
                         textView.rx.didEndEditing.map { _ in TextFieldActions.editingDidEnd })
        .asDriver(onErrorJustReturn: .editingDidEnd)
        .drive { [weak self] actions in
            guard let self = self else { return }
            switch actions {
            case .editingDidBegin:
                if self.textView.text == "메세지를 입력하세요" && self.textView.textColor == SSColors.gray7.color {
                    self.textView.textColor = SSColors.black.color
                    self.textView.text = ""
                }
                self.didUpdateTextViewContentSize()
                
            case .editingDidEnd:
                if self.textView.text.isEmpty {
                    self.textView.text = "메세지를 입력하세요"
                    self.textView.textColor = SSColors.gray7.color
                }
            }
        }
        .disposed(by: viewModel.disposeBag)
        
        textView.rx
            .didChange
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let size = CGSize(width: self.textView.frame.width, height: .infinity)
                let estimatedSize = self.textView.sizeThatFits(size)
                let isMaxHeight = estimatedSize.height >= 74
                
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
                self.sendButton.setImage(UIImage(named: str.isEmpty || self.textView.textColor == SSColors.gray7.color ? GeneralIcons.sendInact.rawValue : GeneralIcons.sendAct.rawValue), for: .normal)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func addData() {
        
        let item1 = ChatItems.dateCell(DateCellModel(string: "어제"))
        let item2 = ChatItems.chatCell(ChatCellModel(string: "첫번째drijphigewoirbwpbm4wopbm4pobm4pob5mpo45mbp4o5bmp45ogdssbsdfbvdsfniodfgnoidsfgnodsfgnoidsfgnsdfogndfiognfignfignignfnodfbndoifbdfb"))
        let item3 = ChatItems.chatCell(ChatCellModel(string: "두번째"))
        let item4 = ChatItems.chatCell(ChatCellModel(string: "세번째"))
        let item5 = ChatItems.dateCell(DateCellModel(string: "오늘"))
        let item6 = ChatItems.chatCell(ChatCellModel(string: "네번째"))
        let item7 = ChatItems.chatCell(ChatCellModel(string: "다섯번째"))
        let item8 = ChatItems.chatCell(ChatCellModel(string: "여섯번째"))
        let item9 = ChatItems.chatCell(ChatCellModel(string: "일곱번째"))
        let item10 = ChatItems.chatCell(ChatCellModel(string: "여덟번째"))
        
        let sections = [ChatSections(items: [item1, item2, item3, item4, item5, item6, item7, item8, item9, item10])]
        
        viewModel.dateSection.accept(sections)
    }
    
    private func didUpdateTextViewContentSize() {
        textViewHeightConstraint?.update(offset: SSFonts.body3R14.size)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func keyboardActions() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func moveViewWithKeyboard(notification: NSNotification, viewBottomConstraint: Constraint, keyboardWillShow: Bool) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        
        if keyboardWillShow {
            let bottomConstant: CGFloat = 16
            viewBottomConstraint.update(offset: -keyboardHeight + bottomConstant)
            
        }else {
            viewBottomConstraint.update(offset: -16)
        }
        
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            self?.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
}
