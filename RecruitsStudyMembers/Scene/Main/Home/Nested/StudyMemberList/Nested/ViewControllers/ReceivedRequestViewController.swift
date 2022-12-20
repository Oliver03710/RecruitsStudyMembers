//
//  ReceivedRequestViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

import RxCocoa
import RxSwift

final class ReceivedRequestViewController: BaseViewController {

    // MARK: - Properties
    
    let receivedView = SharedSegmentedView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = receivedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchStudyMembers()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        receivedView.state = .acceptRequest
    }
    
    private func searchStudyMembers() {
        NetworkManager.shared.request(QueueData.self, router: SeSacApiQueue.search)
            .subscribe(onSuccess: { [weak self] response, _ in
                guard let self = self else { return }
                dump(response)
                self.receivedView.viewModel.memberList.accept([])
                
                response.fromQueueDBRequested.forEach { data in
                    let data = MemberListData(data: data)
                    self.receivedView.viewModel.memberList.acceptAppending(data)
                }
                
                self.receivedView.updateUI()
                if !self.receivedView.viewModel.memberList.value.isEmpty {
                    self.receivedView.makeHidden(isHidden: true)
                } else {
                    self.receivedView.makeHidden(isHidden: true)
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.searchStudyMembers()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: receivedView.viewModel.disposeBag)
    }
}
