//
//  MemberListViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

import SnapKit

final class MemberListViewController: BaseViewController {

    // MARK: - Properties
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = CustromSegmentedControl(items: ["주변 새싹", "받은 요청"])
        return segmentedControl
    }()
    
    private let vc1: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    
    private let vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
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
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selectors
    
    @objc private func changeValue(control: UISegmentedControl) {
        self.currentPage = control.selectedSegmentIndex
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setSegmentedControl()
    }
    
    override func setConstraints() {
        view.addSubview(segmentedControl)
        view.addSubview(pageViewController.view)
        
        segmentedControl.snp.makeConstraints {
            $0.directionalHorizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.height.equalTo(44)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(4)
        }
    }
    
    private func setSegmentedControl() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green, .font: UIFont.systemFont(ofSize: 13, weight: .semibold)], for: .selected)
        segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        changeValue(control: segmentedControl)
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
