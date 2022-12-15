//
//  ShopViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import RxCocoa
import RxSwift

final class ShopViewController: BaseViewController {

    // MARK: - Properties
    
    private let shopView = ShopView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = shopView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        checkMyShopState()
    }
    
    private func checkMyShopState() {
        NetworkManager.shared.request(ShopData.self, router: SeSacApiShop.checkMyInfo)
            .subscribe(onSuccess: { response, _ in
                NetworkManager.shared.shopState = response
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.checkMyShopState()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: shopView.viewModel.disposeBag)
    }
}
