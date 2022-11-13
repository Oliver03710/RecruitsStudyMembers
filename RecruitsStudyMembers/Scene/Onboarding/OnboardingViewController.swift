//
//  OnboardingViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol MovePageIndexDelegate: AnyObject {
    func moveTo(index: Int)
}

final class OnboardingViewController: BaseViewController {

    // MARK: - Properties
    
    private let onboardingView = OnboardingView()
    private let pageVC = OnboardingPageViewController()
    
    private var pageControl: UIPageControl = {
        let pc = UIPageControl(frame: .zero)
        pc.pageIndicatorTintColor = SSColors.gray5.color
        pc.currentPageIndicatorTintColor = SSColors.black.color
        return pc
    }()
    
    weak var movePageDelegate: MovePageIndexDelegate?
    
    
    // MARK: - Init
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selectors
    
    @objc func moveTo(_ sender: UIPageControl) {
        pageVC.setViewControllers([pageVC.pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setIndexDelegate()
        bindData()
    }
    
    override func setConstraints() {
        addChild(pageVC)
        [pageVC.view, pageControl].forEach { view.addSubview($0) }
        
        pageVC.view.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(pageControl.snp.top).offset(-8)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(onboardingView.startButton.snp.top).offset(-32)
            make.width.equalTo(view.snp.width).dividedBy(3.4)
            make.height.equalTo(pageControl.snp.width).dividedBy(3)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        pageVC.didMove(toParent: self)
    }
    
    func setIndexDelegate() {
        pageVC.indexDelegate = self
        pageControl.numberOfPages = pageVC.pages.count
        pageControl.allowsContinuousInteraction = false
        pageControl.addTarget(self, action: #selector(moveTo), for: .valueChanged)
    }
    
    func bindData() {
        let input = OnboardingViewModel.Input(tap: onboardingView.startButton.rx.tap)
        let output = onboardingView.viewModel.transform(input: input)
        
        output.tapDriver
            .drive { [weak self] _ in
                self?.toNextPage()
            }
            .disposed(by: onboardingView.viewModel.disposeBag)
    }
    
    func toNextPage() {
        UserDefaultsManager.passOnboarding = true
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = LoginViewController()
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}


// MARK: - Extension: PageIndexDelegate

extension OnboardingViewController: PageIndexDelegate {
    
    func passIndex(index: Int) {
        pageControl.currentPage = index
    }
    
}
    
