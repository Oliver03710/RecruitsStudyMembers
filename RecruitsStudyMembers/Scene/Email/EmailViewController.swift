//
//  EmailViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import RxCocoa
import RxSwift

final class EmailViewController: BaseViewController {

    // MARK: - Properties
    
    private let emailView = EmailView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = emailView
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
        let input = EmailViewModel.Input(tap: emailView.nextButton.rx.tap, emailText: emailView.emailTextField.rx.text)
        let output = emailView.viewModel.transform(input: input)

        output.emailValid
            .withUnretained(self)
            .bind { (vc, bool) in
                vc.emailView.nextButton.isEnabled = bool
                vc.emailView.nextButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: emailView.viewModel.disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.toNextPage()
            }
            .disposed(by: emailView.viewModel.disposeBag)
    }
    
    func toNextPage() {
        let vc = GenderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
