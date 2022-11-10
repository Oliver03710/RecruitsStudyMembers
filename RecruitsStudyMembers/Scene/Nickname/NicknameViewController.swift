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
        let input = NicknameViewModel.Input(tap: nicknameView.nextButton.rx.tap, textFieldText: nicknameView.nicknameTextField.rx.text)
        let output = nicknameView.viewModel.transform(input: input)
        
        output.textValid
            .withUnretained(self)
            .bind { (vc, bool) in
                vc.nicknameView.nextButton.isEnabled = bool
                vc.nicknameView.nextButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: nicknameView.viewModel.disposeBag)
        
        output.textTransformed
            .bind(to: nicknameView.nicknameTextField.rx.text)
            .disposed(by: nicknameView.viewModel.disposeBag)

        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.toNextPage()
            }
            .disposed(by: nicknameView.viewModel.disposeBag)
    }
    
    func toNextPage() {
        let vc = BirthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
