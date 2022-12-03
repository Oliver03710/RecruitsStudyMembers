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

protocol TossQueueStateDelegate: AnyObject {
    func stillSeeking(_ state: QueueStates)
    func cancelSeeking(_ state: QueueStates)
}

final class MemberListViewController: BaseViewController {

    // MARK: - Properties
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = CustromSegmentedControl(items: ["주변 새싹", "받은 요청"])
        return segmentedControl
    }()
    
    private let vc1: BaseViewController = {
        let vc = SesacNearByViewController()
        vc.nearbyView.mainLabel.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        return vc
    }()
    
    private let vc2: BaseViewController = {
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
    
    weak var delegate: TossQueueStateDelegate?
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selectors
    
    @objc private func valueChanged(control: UISegmentedControl) {
        self.currentPage = control.selectedSegmentIndex
    }
    
    @objc private func backToHome() {
        deleteSearch()
    }
    
    @objc override func backButtonTapped() {
        delegate?.stillSeeking(.readyToBeMatched)
        navigationController?.popViewControllers(2)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        view.backgroundColor = SSColors.white.color
        setNaigations(naviTitle: "새싹 찾기")
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
    
    private func deleteSearch() {
        NetworkManager.shared.request(router: SeSacApiQueue.cancelRequest)
            .subscribe(onSuccess: { [weak self] response, status in
                guard let self = self, let status = SesacStatus.Queue.CancelFindRequest(rawValue: status) else { return }
                dump(response)
                switch status {
                case .success:
                    self.delegate?.cancelSeeking(.defaultState)
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
