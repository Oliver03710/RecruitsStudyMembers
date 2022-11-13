//
//  LoginViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift
import Toast

final class LoginViewController: BaseViewController {

    // MARK: - Properties
    
    private let loginView = LoginView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        bindData()
    }
    
    func bindData() {
        let input = LoginViewModel.Input(textFieldText: loginView.phoneNumTextField.rx.text,
                                         textFieldIsEditing: loginView.phoneNumTextField.rx.controlEvent(.editingDidBegin),
                                         textFieldFiniedEditing: loginView.phoneNumTextField.rx.controlEvent(.editingDidEnd),
                                         tap: loginView.getCertiNumButton.rx.tap)
        let output = loginView.viewModel.transform(input: input)
        
        output.phoneNum
            .withUnretained(self)
            .bind { (vc, bool) in
                vc.loginView.getCertiNumButton.isEnabled = bool
                vc.loginView.getCertiNumButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: loginView.viewModel.disposeBag)
        
        output.textChanged
            .bind(to: loginView.phoneNumTextField.rx.text)
            .disposed(by: loginView.viewModel.disposeBag)
        
        output.textFieldActions
            .withUnretained(self)
            .bind { (vc, actions) in
                switch actions {
                case .editingDidBegin:
                    vc.loginView.lineView.backgroundColor = SSColors.black.color
                case .editingDidEnd:
                    vc.loginView.lineView.backgroundColor = SSColors.gray6.color
                }
            }
            .disposed(by: loginView.viewModel.disposeBag)

        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.toNextPage()
            }
            .disposed(by: loginView.viewModel.disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func toNextPage() {
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(UserDefaultsManager.phoneNum, uiDelegate: nil) { verificationID, error in

                if let error = error {
                    let code = (error as NSError).code
                    print(code)
                    self.view.makeToast(error.localizedDescription)
                    return
                }
                
                guard let id = verificationID else { return }
                print(id)
                UserDefaultsManager.verificationID = id
                let vc = LoginVerificationViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
    }
}
