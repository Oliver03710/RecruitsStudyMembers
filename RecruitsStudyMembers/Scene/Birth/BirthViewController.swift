//
//  BirthViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import RxCocoa
import RxSwift

final class BirthViewController: BaseViewController {

    // MARK: - Properties
    
    private let birthView = BirthView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = birthView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selectors
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations()
        bindData()
    }
    
    func setNaigations() {
        setNaviBar()
        
        let backButton = UIBarButtonItem(image: UIImage(named: GeneralIcons.arrow.rawValue), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    
    func bindData() {
        let input = BirthViewModel.Input(tap: birthView.nextButton.rx.tap)
        let output = birthView.viewModel.transform(input: input)

        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.toNextPage()
            }
            .disposed(by: birthView.viewModel.disposeBag)
    }
    
    func toNextPage() {
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
