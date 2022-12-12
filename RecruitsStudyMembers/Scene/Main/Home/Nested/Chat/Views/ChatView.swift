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
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.keyboardDismissMode = .onDrag
        tv.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.reuseIdentifier)
        tv.register(UserChatTableViewCell.self, forCellReuseIdentifier: UserChatTableViewCell.reuseIdentifier)
        tv.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.reuseIdentifier)
        tv.register(IntroTableViewCell.self, forCellReuseIdentifier: IntroTableViewCell.reuseIdentifier)
        return tv
    }()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<ChatSections> { dataSource, tableView, indexPath, item in
        switch item {
        case let .dateCell(dateModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier, for: indexPath) as? DateTableViewCell else { return UITableViewCell() }
            cell.configureCells(date: dateModel.string)
            cell.selectionStyle = .none
            return cell
            
        case let .userChatCell(userChatModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserChatTableViewCell.reuseIdentifier, for: indexPath) as? UserChatTableViewCell else { return UITableViewCell() }
            cell.configureCells(text: userChatModel.chat, date: userChatModel.date)
            cell.selectionStyle = .none
            return cell
            
        case let .introCell(introModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IntroTableViewCell.reuseIdentifier, for: indexPath) as? IntroTableViewCell else { return UITableViewCell() }
            cell.configureCells(text: introModel.string)
            cell.selectionStyle = .none
            return cell
            
        case let .myChatCell(myChatModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.reuseIdentifier, for: indexPath) as? MyChatTableViewCell else { return UITableViewCell() }
            cell.configureCells(text: myChatModel.chat, date: myChatModel.date)
            cell.selectionStyle = .none
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
    
    let moreView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.white.color
        return view
    }()
    
    let opaqueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.isOpaque = false
        view.isHidden = true
        return view
    }()
    
    private let reportButton: CustomButton = {
        let btn = CustomButton(text: "새싹 신고", image: GeneralIcons.siren.rawValue, config: .plain(), tint: SSColors.black.color, foregroundColor: SSColors.black.color, font: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size, lineHeight: SSFonts.title3M14.lineHeight)
        return btn
    }()
    
    private let cancelButton: CustomButton = {
        let btn = CustomButton(text: "스터디 취소", image: GeneralIcons.cancelMatch.rawValue, config: .plain(), tint: SSColors.black.color, foregroundColor: SSColors.black.color, font: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size, lineHeight: SSFonts.title3M14.lineHeight)
        return btn
    }()
    
    private let reviewButton: CustomButton = {
        let btn = CustomButton(text: "리뷰 등록", image: GeneralIcons.write.rawValue, config: .plain(), tint: SSColors.black.color, foregroundColor: SSColors.black.color, font: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size, lineHeight: SSFonts.title3M14.lineHeight)
        return btn
    }()
    
    private var textViewHeightConstraint: Constraint?
    private var chatViewBottomConstraint: Constraint?
    private var tableViewBottomConstraint: Constraint?
    var moreViewHeightConstraint: Constraint?
    
    var showMores = false
    var popupPresented = false
    var nickname = "이름"
    
    private let viewModel = ChatViewModel()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Selectors
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if !popupPresented {
            moveTableViewWithKeyboard(notification: notification)
        }
    }
        
    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.transform = .identity
    }
    
    @objc func getMessage(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let id = userInfo["id"] as? String,
              let chat = userInfo["chat"] as? String,
              let createdAt = userInfo["createdAt"] as? String,
              let from = userInfo["from"] as? String,
              let to = userInfo["to"] as? String else { return }
        
        ChatRepository.shared.addItem(id: id, chat: chat, createdAt: createdAt, from: from, to: to)
    }


    // MARK: - Helper Functions
    
    override func configureUI() {
        ChatRepository.shared.fetchData()
        addData()
        bindData()
        keyboardActions()
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: Notification.Name("getMessage"), object: nil)
        dump(ChatRepository.shared.tasks)
    }
    
    override func setConstraints() {
        addSubview(tableView)
        addSubview(chatView)
        addSubview(opaqueView)
        addSubview(moreView)
        
        moreView.addSubview(reportButton)
        moreView.addSubview(cancelButton)
        moreView.addSubview(reviewButton)
        
        chatView.addSubview(textView)
        chatView.addSubview(sendButton)
        
        opaqueView.snp.makeConstraints {
            $0.directionalHorizontalEdges.top.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        moreView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(76)
            moreViewHeightConstraint = $0.top.equalTo(safeAreaLayoutGuide).offset(-76).constraint
        }
        
        reportButton.snp.makeConstraints {
            $0.leading.directionalVerticalEdges.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        cancelButton.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview()
            $0.leading.equalTo(reportButton.snp.trailing)
            $0.width.equalToSuperview().dividedBy(3)
        }
        
        reviewButton.snp.makeConstraints {
            $0.directionalVerticalEdges.trailing.equalToSuperview()
            $0.leading.equalTo(cancelButton.snp.trailing)
        }
        
        tableView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview().inset(16)
            tableViewBottomConstraint = $0.bottom.equalTo(chatView.snp.top).offset(-16).constraint
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
                NetworkManager.shared.myChat = str
            }
            .disposed(by: viewModel.disposeBag)
        
        Observable.merge(reportButton.rx.tap.map { AlertButtonCombined.report },
                         cancelButton.rx.tap.map { AlertButtonCombined.cancel },
                         reviewButton.rx.tap.map { AlertButtonCombined.review })
        .asDriver(onErrorJustReturn: .report)
        .drive { [weak self] actions in
            guard let self = self else { return }
            self.showMoreButtons()
            self.popupPresented = true
            
            switch actions {
            case .report:
                let vc = ReportAlertViewController()
                vc.alertView.viewState = .report
                let currentVC = UIApplication.getTopMostViewController()
                vc.modalPresentationStyle = .overFullScreen
                currentVC?.present(vc, animated: true)
                
            case .cancel:
                let vc = CustomAlertViewController()
                let currentVC = UIApplication.getTopMostViewController()
                vc.customAlertView.titleLabel.text = "스터디를 취소하겠습니까?"
                vc.customAlertView.bodyLabel.text = "스터디를 취소하시면 패널티가 부과됩니다"
                vc.modalPresentationStyle = .overFullScreen
                vc.customAlertView.state = .cancelStudy
                currentVC?.present(vc, animated: true)
                
            case .review:
                let vc = ReportAlertViewController()
                vc.alertView.viewState = .review
                let currentVC = UIApplication.getTopMostViewController()
                vc.modalPresentationStyle = .overFullScreen
                currentVC?.present(vc, animated: true)
            }
        }
        .disposed(by: viewModel.disposeBag)
        
        sendButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else { return }
                if self.sendButton.currentImage == UIImage(named: GeneralIcons.sendAct.rawValue) {
                    self.sendMyChat()
                }
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func addData() {
        
        var chatting: [ChatItems] = []
        
        
        guard let first = ChatRepository.shared.tasks.first?.createdAt.toDate()?.toString(withFormat: "M월 dd일 EEEE") else { return }
        let firstDate = ChatItems.dateCell(DateCellModel(string: first))
        chatting.append(firstDate)
        
        let withWhom = ChatItems.introCell(IntroCellModel(string: nickname))
        chatting.append(withWhom)
        
        ChatRepository.shared.tasks.forEach { chat in
            if chat.to == UserDefaultsManager.myUid {
                guard let time = chat.createdAt.toDate()?.toString(withFormat: "HH:mm") else { return }
                let item = ChatItems.userChatCell(UserChatCellModel(chat: chat.chat, date: time))
                chatting.append(item)
                
            } else if chat.to == NetworkManager.shared.uid {
                guard let time = chat.createdAt.toDate()?.toString(withFormat: "HH:mm") else { return }
                let item = ChatItems.myChatCell(MyChatCellModel(chat: chat.chat, date: time))
                chatting.append(item)
            }
        }
        
        let sections = [ChatSections(items: chatting)]
        
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
    
    private func moveTableViewWithKeyboard(notification: NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    
    func showMoreButtons() {
        if !showMores {
            showMores = true
            moreViewHeightConstraint?.update(offset: 0)
            opaqueView.isHidden = false
            moreView.isHidden = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.opaqueView.backgroundColor = UIColor.black.withAlphaComponent(0.45)
                self?.layoutIfNeeded()
            }
        } else {
            showMores = false
            moreViewHeightConstraint?.update(offset: -76)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.opaqueView.backgroundColor = UIColor.black.withAlphaComponent(0)
                self?.layoutIfNeeded()
            } completion: { [weak self] _ in
                self?.moreView.isHidden = true
                self?.opaqueView.isHidden = true
            }
        }
    }
    
    private func sendMyChat() {
        NetworkManager.shared.request(Chat.self, router: SeSacApiChat.chatPost)
            .subscribe(onSuccess: { [weak self] response, state in
                guard let self = self else { return }
                print(response, state)
                guard let errStatus = SesacStatus.Chat.Send(rawValue: state) else { return }
                switch errStatus {
                case .success:
                    ChatRepository.shared.addItem(id: response.id,
                                                  chat: response.chat,
                                                  createdAt: response.createdAt,
                                                  from: response.from,
                                                  to: response.to)
                    self.textView.text = ""
                case .matchingEnded:
                    self.makeToast("스터디가 종료되어 채팅을 전송할 수 없습니다.")
                }
                
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self.sendMyChat()
                    } errorHandler: {
                        self.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                default: self.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
}
