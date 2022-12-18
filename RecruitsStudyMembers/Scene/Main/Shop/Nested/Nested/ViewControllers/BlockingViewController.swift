//
//  BlockingViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/18.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

final class BlockingViewController: BaseViewController {

    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        bindData()
    }
    
    private func bindData() {
        NetworkManager.shared.receipt
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.requestReciptValid()
            })
            .disposed(by: disposeBag)
        
        NetworkManager.shared.isDismissed
            .asDriver()
            .drive { [weak self] bool in
                if bool {
                    self?.presentingViewController?.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast("아이템 구매 취소")
                        NetworkManager.shared.isDismissed.accept(false)
                    })
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func requestReciptValid() {
        NetworkManager.shared.request(router: SeSacApiShop.ios)
            .subscribe(onSuccess: { [weak self] response, state in
                guard let state = SesacStatus.Shop.IOS(rawValue: state) else { return }
                switch state {
                case .success:
                    self?.presentingViewController?.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast("아이템 구매 성공")
                        NetworkManager.shared.isUpdated.accept(true)
                    })
                    
                case .failToValidate:
                    self?.presentingViewController?.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast("영수증 검증에 실패하였습니다.")
                    })
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.requestReciptValid()
                    } errorHandler: {
                        self?.presentingViewController?.dismiss(animated: true, completion: {
                            UIApplication.getTopMostViewController()?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                        })
                    }
                    
                default:
                    self?.presentingViewController?.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast(errStatus.errorDescription)
                    })
                }
            })
            .disposed(by: disposeBag)
    }
}
