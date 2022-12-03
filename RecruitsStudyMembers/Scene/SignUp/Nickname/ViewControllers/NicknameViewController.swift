//
//  NicknameViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import RxCocoa
import RxSwift

final class NicknameViewController: BaseViewController {

    // MARK: - Properties
    
    private let nicknameView = NicknameView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = nicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        bindData()
        setNaigations()
    }
    
    func bindData() {
        let input = NicknameViewModel.Input(tap: nicknameView.nextButton.rx.tap, textFieldText: nicknameView.nicknameTextField.rx.text)
        let output = nicknameView.viewModel.transform(input: input)
        
        output.textValid
            .withUnretained(self)
            .bind { (vc, bool) in
                vc.nicknameView.nextButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: nicknameView.viewModel.disposeBag)
        
        output.textTransformed
            .bind(to: nicknameView.nicknameTextField.rx.text)
            .disposed(by: nicknameView.viewModel.disposeBag)

        output.textTransformed
            .bind { str in
                UserDefaultsManager.nickname = str
            }
            .disposed(by: nicknameView.viewModel.disposeBag)
        
        output.tapDriver
            .drive { [weak self] _ in
                output.buttonValid.value ? self?.toNextPage() : self?.view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요.", position: .top)
            }
            .disposed(by: nicknameView.viewModel.disposeBag)
    }
    
    func toNextPage() {
        let vc = BirthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
