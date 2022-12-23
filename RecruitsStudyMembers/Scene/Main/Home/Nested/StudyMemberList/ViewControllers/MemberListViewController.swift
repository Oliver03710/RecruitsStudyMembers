//
//  MemberListViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Toast

final class MemberListViewController: BaseViewController {

    // MARK: - Properties
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: ["주변 새싹", "받은 요청"])
        return segmentedControl
    }()
    
    private let vc1: SesacNearByViewController = {
        let vc = SesacNearByViewController()
        vc.nearbyView.mainLabel.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        return vc
    }()
    
    private let vc2: ReceivedRequestViewController = {
        let vc = ReceivedRequestViewController()
        vc.receivedView.mainLabel.text = "아직 받은 요청이 없어요ㅠ"
        return vc
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        return vc
    }()
    
    var dataViewControllers: [UIViewController] {
        [vc1, vc2]
    }
    
    var currentPage: Int = 0 {
        didSet {
            print(oldValue, self.currentPage)
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            pageViewController.setViewControllers([dataViewControllers[self.currentPage]], direction: direction, animated: true, completion: nil)
        }
    }
    
    private var timer: Timer?
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    
    // MARK: - Selectors
    
    @objc private func valueChanged(control: UISegmentedControl) {
        self.currentPage = control.selectedSegmentIndex
    }
    
    @objc private func backToHome() {
        deleteSearch()
    }
    
    @objc private func backToSelectStudy() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc override func backButtonTapped() {
        NetworkManager.shared.queueState.accept(.readyToBeMatched)
        navigationController?.popViewControllers(2)
    }
    
    @objc private func timerActions() {
        checkMyQueueState()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        view.backgroundColor = SSColors.white.color
        setNaigations(naviTitle: "새싹 찾기")
        bindData()
        setSegmentedControl()
    }
    
    override func setConstraints() {
        [segmentedControl, pageViewController.view].forEach { view.addSubview($0) }
        
        segmentedControl.snp.makeConstraints {
            $0.directionalHorizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.height.equalTo(44)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(4)
        }
    }
    
    override func setNaigations(naviTitle: String? = nil) {
        super.setNaigations(naviTitle: naviTitle)
        guard let title4 = UIFont(name: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size) else { return }
        let stopButton = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(backToHome))
        stopButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SSColors.black.color,
                                           .font: title4], for: .normal)
        stopButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SSColors.gray3.color,
                                           .font: title4], for: .selected)
        
        self.navigationItem.rightBarButtonItem = stopButton
    }
    
    private func setSegmentedControl() {
        guard let title4 = UIFont(name: SSFonts.title4R14.fonts, size: SSFonts.title4R14.size) else { return }
        guard let title3 = UIFont(name: SSFonts.title3M14.fonts, size: SSFonts.title3M14.size) else { return }
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SSColors.gray6.color,
                                                 .font: title4], for: .normal)
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: SSColors.green.color,
                                                 .font: title3], for: .selected)
        
        segmentedControl.addTarget(self, action: #selector(valueChanged(control:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        valueChanged(control: segmentedControl)
    }
    
    private func bindData() {
        Observable.merge(vc1.nearbyView.changeStudyButton.rx.tap.map { _ in ButtonCombined.action1 },
                         vc2.receivedView.changeStudyButton.rx.tap.map { _ in ButtonCombined.action2 })
        .asDriver(onErrorJustReturn: .action1)
        .drive { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
        Observable.merge(vc1.nearbyView.refreshButton.rx.tap.map { _ in ButtonCombined.action1 },
                         vc2.receivedView.refreshButton.rx.tap.map { _ in ButtonCombined.action2 })
        .asDriver(onErrorJustReturn: .action1)
        .drive { action in
            switch action {
            case .action1:
                self.searchStudyMembers(buttonAction: .action1)
            case .action2:
                self.searchStudyMembers(buttonAction: .action1)
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func deleteSearch() {
        NetworkManager.shared.request(router: SeSacApiQueue.cancelRequest)
            .subscribe(onSuccess: { [weak self] response, status in
                guard let self = self, let status = SesacStatus.Queue.CancelFindRequest(rawValue: status) else { return }
                dump(response)
                switch status {
                case .success:
                    NetworkManager.shared.queueState.accept(.defaultState)
                    self.navigationController?.popViewControllers(2)
                    
                case .requestCanceled:
                    self.view.makeToast("누군가와 스터디하기로 약속하셨습니다.")
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.deleteSearch()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func searchStudyMembers(buttonAction: ButtonCombined) {
        NetworkManager.shared.request(QueueData.self, router: SeSacApiQueue.search)
            .subscribe(onSuccess: { [weak self] response, status in
                guard let self = self else { return }
                dump(response)
                
                switch buttonAction {
                case .action1:
                    self.vc1.nearbyView.viewModel.memberList.accept([])
                    
                    response.fromQueueDB.forEach { data in
                        let data = MemberListData(data: data)
                        self.vc1.nearbyView.viewModel.memberList.acceptAppending(data)
                    }
                    
                    self.vc1.nearbyView.updateUI()
                    if !self.vc1.nearbyView.viewModel.memberList.value.isEmpty {
                        self.vc1.nearbyView.makeHidden(isHidden: true)
                    }
                    
                case .action2:
                    self.vc2.receivedView.viewModel.memberList.accept([])
                    
                    response.fromQueueDBRequested.forEach { data in
                        let data = MemberListData(data: data)
                        self.vc2.receivedView.viewModel.memberList.acceptAppending(data)
                    }
                    
                    self.vc2.receivedView.updateUI()
                    if !self.vc2.receivedView.viewModel.memberList.value.isEmpty {
                        self.vc2.receivedView.makeHidden(isHidden: true)
                    }
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        switch buttonAction {
                        case .action1:
                            self?.searchStudyMembers(buttonAction: .action1)
                        case .action2:
                            self?.searchStudyMembers(buttonAction: .action2)
                        }
                        
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkMyQueueState() {
        NetworkManager.shared.request(QueueStateData.self, router: SeSacApiQueue.myQueueState)
            .subscribe(onSuccess: { [weak self] response, state in
                print(response, state)
                guard let self = self,
                      let name = response.matchedNick,
                      let state = SesacStatus.Queue.myQueueState(rawValue: state) else { return }
                
                NetworkManager.shared.nickName = name
                
                switch state {
                case .success:
                    if response.matched == 0 {
                        print("Waiting For Matching...")
                        
                    } else if response.matched == 1 {
                        self.view.makeToast("\(NetworkManager.shared.nickName)님과 매칭되셨습니다. 잠시 후 채팅방으로 이동합니다.") {
                            _ in
                            NetworkManager.shared.queueState.accept(.matched)
                            
                            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                            let sceneDelegate = windowScene?.delegate as? SceneDelegate
                            let vc = MainTabBarController()
                            sceneDelegate?.window?.rootViewController = vc
                            sceneDelegate?.window?.makeKeyAndVisible()
                            let targetVC = ChatViewController()
                            vc.navigationController?.pushViewController(targetVC, animated: true)
                        }
                    }
                    
                case .defaultState:
                    print("기본 상태")
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.checkMyQueueState()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setTimer() {
        if timer != nil && timer!.isValid {
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerActions), userInfo: nil, repeats: true)
    }
}


// MARK: - Extension: UIPageViewControllerDataSource

extension MemberListViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        return self.dataViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController), index + 1 < self.dataViewControllers.count else { return nil }
        return self.dataViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?[0], let index = self.dataViewControllers.firstIndex(of: viewController) else { return }
        self.currentPage = index
        self.segmentedControl.selectedSegmentIndex = index
    }
}


// MARK: - Extension: UIPageViewControllerDelegate

extension MemberListViewController: UIPageViewControllerDelegate {
    
}
