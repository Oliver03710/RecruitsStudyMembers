//
//  GenderViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift
import Toast

final class GenderViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = GenderView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = myView
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
        let input = GenderViewModel.Input(tap: myView.nextButton.rx.tap,
                                          maleTapped: myView.maleButton.rx.tap,
                                          femaleTapped: myView.femaleButton.rx.tap)
        
        let output = myView.viewModel.transform(input: input)
        
        output.maleSelected
            .drive { [weak self] bool in
                self?.myView.maleButton.backgroundColor = bool ? SSColors.whiteGreen.color : SSColors.white.color
                self?.myView.maleButton.layer.borderColor = bool ? SSColors.whiteGreen.color.cgColor : SSColors.gray3.color.cgColor
                
                self?.myView.femaleButton.backgroundColor = bool ? SSColors.white.color : SSColors.whiteGreen.color
                self?.myView.femaleButton.layer.borderColor = bool ? SSColors.gray3.color.cgColor : SSColors.whiteGreen.color.cgColor
            }
            .disposed(by: myView.viewModel.disposeBag)
        
        output.tap
            .drive { [weak self] _ in
                output.buttonValid.value ? self?.toNextPage() : self?.view.makeToast("성별을 선택해주세요.", position: .top)
            }
            .disposed(by: myView.viewModel.disposeBag)
        
        output.buttonValid
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] bool in
                self?.myView.nextButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: myView.viewModel.disposeBag)
        
    }
    
    func toNextPage() {
        view.makeToast("회원가입을 진행하시겠습니까?", position: .top) { [weak self] _ in
            self?.postUserInto()
        }
    }
    
    func postUserInto() {
        NetworkManager.shared.request(UserData.self, router: SeSacApiUser.signup)
            .subscribe(onSuccess: { [weak self] data, status in
                guard let self = self else { return }
                guard let status = SesacStatus.User.SignUpSuccess(rawValue: status) else { return }
                switch status {
                case .success:
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let vc = MainTabBarController()
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
                    UserDefaultsManager.userName = data.nick
                    UserDefaultsManager.userImage = data.sesac
                    UserDefaultsManager.resetSignupData()
                    
                case .existUser:
                    self.view.makeToast(status.errorDescription)
                    
                case .invalidNickname:
                    self.view.makeToast("해당 닉네임은 사용할 수 없습니다.", position: .top) { [weak self] _ in
                        self?.navigationController?.popViewControllers(3)
                    }
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.postUserInto()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }

                default:
                    self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: myView.viewModel.disposeBag)
    }

}
