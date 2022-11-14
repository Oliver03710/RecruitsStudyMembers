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

final class GenderViewController: BaseViewController {

    // MARK: - Properties
    
    private let genderView = GenderView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = genderView
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
        let input = GenderViewModel.Input(tap: genderView.nextButton.rx.tap, maleTapped: genderView.maleButton.rx.tap, femaleTapped: genderView.femaleButton.rx.tap)
        let output = genderView.viewModel.transform(input: input)
        
        output.maleSelected
            .drive { [weak self] bool in
                self?.genderView.maleButton.backgroundColor = bool ? SSColors.whiteGreen.color : SSColors.white.color
                self?.genderView.maleButton.layer.borderColor = bool ? SSColors.whiteGreen.color.cgColor : SSColors.gray3.color.cgColor
                
                self?.genderView.femaleButton.backgroundColor = bool ? SSColors.white.color : SSColors.whiteGreen.color
                self?.genderView.femaleButton.layer.borderColor = bool ? SSColors.gray3.color.cgColor : SSColors.whiteGreen.color.cgColor
            }
            .disposed(by: genderView.viewModel.disposeBag)
        
        output.tap
            .drive { [weak self] _ in
                output.buttonValid.value ? self?.toNextPage() : self?.view.makeToast("성별을 선택해주세요.", position: .top)
            }
            .disposed(by: genderView.viewModel.disposeBag)
        
        output.buttonValid
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] bool in
                self?.genderView.nextButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: genderView.viewModel.disposeBag)
        
    }
    
    func toNextPage() {
        view.makeToast("회원가입을 진행하시겠습니까?", position: .top) { [weak self] didTap in
            if didTap {
                self?.postUserInto()
            }
        }
    }
    
    func postUserInto() {
        NetworkManager.shared.request(UserData.self, router: SeSacApi.signup)
            .subscribe(onSuccess: { response in
                print("Succeed")
                print(response)
            }, onFailure: { [weak self] error in
                print("Error")
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacError(rawValue: errors) else { return }
                
                switch errCode {
                case .alreadySignedup:
                    self?.view.makeToast(errCode.errorDescription)
                case .invalidNickname:
                    self?.view.makeToast(errCode.errorDescription)
                case .firebaseTokenError:
                    self?.view.makeToast(errCode.errorDescription)
                    NetworkManager.shared.refreshToken()
                case .unsignedupUser:
                    self?.view.makeToast(errCode.errorDescription)
                case .ServerError:
                    self?.view.makeToast(errCode.errorDescription)
                case .ClientError:
                    self?.view.makeToast(errCode.errorDescription)
                }
            })
            .disposed(by: genderView.viewModel.disposeBag)
    }

}
