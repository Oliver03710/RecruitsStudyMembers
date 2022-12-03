//
//  EmailViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

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
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations()
        bindData()
    }
    
    func bindData() {
        let input = EmailViewModel.Input(tap: emailView.nextButton.rx.tap, emailText: emailView.emailTextField.rx.text)
        let output = emailView.viewModel.transform(input: input)

        output.emailValid
            .withUnretained(self)
            .bind { (vc, bool) in
                vc.emailView.nextButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: emailView.viewModel.disposeBag)
        
        output.tap
            .drive { [weak self] _ in
                output.buttonValid.value ? self?.toNextPage() : self?.view.makeToast("이메일 형식이 유효하지 않습니다.", position: .top)
            }
            .disposed(by: emailView.viewModel.disposeBag)
        
        output.emailValue
            .drive(emailView.emailTextField.rx.text)
            .disposed(by: emailView.viewModel.disposeBag)
    }
    
    func toNextPage() {
        let vc = GenderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
