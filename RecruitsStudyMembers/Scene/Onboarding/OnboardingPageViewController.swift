//
//  OnboardingPageViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

protocol PageIndexDelegate: AnyObject {
    func passIndex(index: Int)
}

final class OnboardingPageViewController: UIPageViewController {

    // MARK: - Properties
    
    var pages: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]
    
    weak var indexDelegate: PageIndexDelegate?
    
    
    // MARK: - Init
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Helper Functions
    
    func configureUI() {
        PageVCDelegate()
        initViewControllers()
    }
    
    private func PageVCDelegate() {
        dataSource = self
        delegate = self
    }
    
    private func initViewControllers() {
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }

}


// MARK: - Extension: UIPageViewControllerDelegate

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentPageViewController = pageViewController.viewControllers?.first else { return }
        guard let index = pages.firstIndex(of: currentPageViewController) else { return }
        indexDelegate?.passIndex(index: index)
    }
    
}


// MARK: - Extenstion: UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pages[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pages.count ? nil : pages[nextIndex]

    }
    
}

