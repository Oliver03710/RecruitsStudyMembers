//
//  SesacNearByViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

import RxCocoa
import RxSwift

final class SesacNearByViewController: BaseViewController {

    // MARK: - Properties
    
    let nearbyView = SharedSegmentedView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = nearbyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        searchStudyMembers()
    }
    
    private func searchStudyMembers() {
        NetworkManager.shared.request(QueueData.self, router: SeSacApiQueue.search)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                dump(response)
                response.fromQueueDB.forEach { data in
                    let data = MemberListData(data: data)
                    self.nearbyView.viewModel.memberList.acceptAppending(data)
                }
                
                self.nearbyView.configureUI()
                if !self.nearbyView.viewModel.memberList.value.isEmpty {
                    self.nearbyView.makeHidden(isHidden: true)
                }
                
            }, onFailure: { [weak self] error in
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacUserError(rawValue: errors) else { return }
                switch errCode {
                    
                case .firebaseTokenError:
                    NetworkManager.shared.fireBaseError {
                        self?.searchStudyMembers()
                    } errorHandler: {
                        self?.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요.", position: .top)
                    } defaultErrorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.", position: .top)
                    }
                    
                case .unsignedupUser, .ServerError, .ClientError:
                    self?.view.makeToast(errCode.errorDescription)
                default: break
                }
            })
            .disposed(by: nearbyView.viewModel.disposeBag)
    }
}
