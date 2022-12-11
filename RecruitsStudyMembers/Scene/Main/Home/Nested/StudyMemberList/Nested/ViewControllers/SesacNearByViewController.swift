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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchStudyMembers()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        nearbyView.state = .sendRequest
        bindData()
        nearbyView.collectionView.delegate = self
    }
    
    private func searchStudyMembers() {
        NetworkManager.shared.request(QueueData.self, router: SeSacApiQueue.search)
            .subscribe(onSuccess: { [weak self] response, status in
                guard let self = self else { return }
                dump(response)
                self.nearbyView.viewModel.memberList.accept([])
                
                response.fromQueueDB.forEach { data in
                    let data = MemberListData(data: data)
                    self.nearbyView.viewModel.memberList.acceptAppending(data)
                }
                
                self.nearbyView.updateUI()
                if !self.nearbyView.viewModel.memberList.value.isEmpty {
                    self.nearbyView.makeHidden(isHidden: true)
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
            .disposed(by: nearbyView.viewModel.disposeBag)
    }
    
    private func bindData() {
        
    }
}


extension SesacNearByViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
