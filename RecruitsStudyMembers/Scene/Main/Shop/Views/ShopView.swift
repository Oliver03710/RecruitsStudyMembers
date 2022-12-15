//
//  ShopView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import SnapKit
import Toast

final class ShopView: BaseView {

    // MARK: - Properties
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "sesacBackground\(BackgroundImages.sesacBackground0.rawValue)")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let foregroundImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = FaceImages.sesacFace0.images
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let saveButton: CustomButton = {
        let btn = CustomButton(text: "저장하기", config: .plain(), borderColor: SSColors.green.color, foregroundColor: SSColors.white.color, backgroundColor: SSColors.green.color, font: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size, lineHeight: SSFonts.body3R14.lineHeight)
        return btn
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: ["새싹", "배경"])
        return segmentedControl
    }()
    
    private let sesacViewController: BuySesacImageViewController = {
        let vc = BuySesacImageViewController()
        return vc
    }()
    
    private let backgroundViewController: BuySesacBackgroundViewController = {
        let vc = BuySesacBackgroundViewController()
        return vc
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        return vc
    }()
    
    private var dataViewControllers: [UIViewController] {
        [sesacViewController, backgroundViewController]
    }
    
    private var currentPage: Int = 0 {
        didSet {
            print(oldValue, self.currentPage)
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            pageViewController.setViewControllers([dataViewControllers[self.currentPage]], direction: direction, animated: true, completion: nil)
        }
    }
    
    let viewModel = ShopViewModel()
    
    
    // MARK: - Selectors
    
    @objc private func valueChanged(control: UISegmentedControl) {
        self.currentPage = control.selectedSegmentIndex
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setSegmentedControl()
    }
    
    override func setConstraints() {
        [backgroundImageView, segmentedControl, pageViewController.view].forEach { addSubview($0) }
        [foregroundImageView, saveButton].forEach { backgroundImageView.addSubview($0) }
        
        backgroundImageView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(176)
        }
        
        foregroundImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.25)
            $0.width.height.equalTo(184)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.trailing.equalTo(backgroundImageView).inset(12)
            $0.width.equalTo(80)
            $0.height.equalTo(saveButton.snp.width).dividedBy(2)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(backgroundImageView.snp.bottom).offset(12)
            $0.height.equalTo(44)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(4)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(4)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(4)
        }
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
}


// MARK: - Extension: UIPageViewControllerDataSource

extension ShopView: UIPageViewControllerDataSource {
    
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

extension ShopView: UIPageViewControllerDelegate {
    
}
