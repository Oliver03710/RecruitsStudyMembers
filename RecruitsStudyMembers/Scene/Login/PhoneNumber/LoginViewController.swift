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
        UserDefaultsManager.resetSingupData()
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

        output.tapDriver
            .throttle(.seconds(3))
            .drive { [weak self] _ in
                output.buttonValid.value ? self?.toNextPage() : self?.view.makeToast("잘못된 전화번호 형식입니다.", position: .top)
            }
            .disposed(by: loginView.viewModel.disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func toNextPage() {
        view.makeToast("전화번호 인증 시작", position: .center)
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(UserDefaultsManager.phoneNum, uiDelegate: nil) { [weak self] verificationID, error in

                if let error = error as NSError? {
                    guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else { return }
                    switch errorCode {
                    case .tooManyRequests:
                        self?.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요.")
                        return
                    default:
                        self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.")
                        return
                    }
                }
                
                guard let id = verificationID else { return }
                print(id)
                UserDefaultsManager.verificationID = id
                let vc = LoginVerificationViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
                
            }
    }
}
