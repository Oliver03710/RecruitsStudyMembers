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
            .throttle(.seconds(5), scheduler: MainScheduler.instance)
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
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            
            if let error = error as NSError? {
                guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else { return }
                switch errorCode {
                case .userTokenExpired, .sessionExpired, .invalidVerificationID:
                    self?.view.makeToast("전화 번호 인증 실패")
                default:
                    self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.")
                }
                return
            }
            
            authResult?.user.getIDToken { idToken, error in
                
                if let error = error as NSError? {
                    guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else { return }
                    switch errorCode {
                    case .userTokenExpired, .sessionExpired, .invalidVerificationID:
                        self?.view.makeToast("전화 번호 인증 실패")
                        return
                    default:
                        self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.")
                        return
                    }
                }
                
                guard let idToken = idToken else { return }
                UserDefaultsManager.token = idToken
                print(idToken)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self?.requestCheckUser()
            }
        }
    }
    
    func resetButtonTapped() {
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(UserDefaultsManager.phoneNum, uiDelegate: nil) { [weak self] verificationID, error in
                
                if let error = error as NSError? {
                    guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else { return }
                    switch errorCode {
                    case .tooManyRequests:
                        self?.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요.", position: .center)
                    default:
                        self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.")
                    }
                    return
                }
                
                guard let id = verificationID else { return }
                print(id)
                UserDefaultsManager.verificationID = id
            }
    }
    
    func requestCheckUser() {
        NetworkManager.shared.request(UserData.self, router: SeSacApi.login)
            .subscribe(onSuccess: { response in
                print(response)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = MainTabBarController()
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
                
            }, onFailure: { [weak self] error in
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacError(rawValue: errors) else { return }
                switch errCode {
                    
                case .firebaseTokenError:
                    guard let codeNum = NetworkManager.shared.refreshToken() else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            self?.requestCheckUser()
                        }
                        return
                    }
                    guard let errorCode = AuthErrorCode.Code(rawValue: codeNum) else { return }
                    switch errorCode {
                    case .tooManyRequests:
                        self?.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요.", position: .center)
                    default:
                        self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.")
                    }

                case .unsignedupUser:
                    self?.view.makeToast(errCode.errorDescription, position: .top) { _ in
                        let vc = NicknameViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                case .ServerError, .ClientError:
                    self?.view.makeToast(errCode.errorDescription)
                default: break
                }
            })
            .disposed(by: loginVerificationView.viewModel.disposeBag)
    }
}
