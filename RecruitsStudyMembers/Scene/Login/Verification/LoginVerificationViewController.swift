//
//  LoginVerificationViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift
import Toast

final class LoginVerificationViewController: BaseViewController {

    // MARK: - Properties
    
    private let loginVerificationView = LoginVerificationView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = loginVerificationView
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
        let input = LoginVerificationViewModel.Input(startButtonTapped: loginVerificationView.startButton.rx.tap,
                                                     resetButtonTapped: loginVerificationView.resendButton.rx.tap,
                                                     textFieldText: loginVerificationView.certiTextField.rx.text)
        let output = loginVerificationView.viewModel.transform(input: input)

        output.textChanged
            .drive(loginVerificationView.certiTextField.rx.text)
            .disposed(by: loginVerificationView.viewModel.disposeBag)
        
        output.textValid
            .withUnretained(self)
            .bind { (vc, bool) in
                vc.loginVerificationView.startButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: loginVerificationView.viewModel.disposeBag)
        
        output.resetButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                vc.resetButtonTapped()
            }
            .disposed(by: loginVerificationView.viewModel.disposeBag)
        
        output.startButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                vc.toNextPage()
            }
            .disposed(by: loginVerificationView.viewModel.disposeBag)
        
    }
    
    func toNextPage() {
        print(UserDefaultsManager.certiNum)
        guard !UserDefaultsManager.verificationID.isEmpty && !UserDefaultsManager.certiNum.isEmpty else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: UserDefaultsManager.verificationID,
            verificationCode: UserDefaultsManager.certiNum
        )
        
        logIn(credential: credential)
        
    }
    
    func logIn(credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            
            if let error = error {
                let code = (error as NSError).code
                print(code)
                self.view.makeToast(error.localizedDescription)
                return
            }
            
            print("LogIn Success!!")
            print("\(authResult!)")
            let vc = NicknameViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func resetButtonTapped() {
        
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
            }
    }

}
