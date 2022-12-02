//
//  ManageInfoViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift

final class ManageInfoViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = ManageInfoView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = myView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    // MARK: - Selectors
    
    @objc func saveAction() {
        NetworkManager.shared.request(router: SeSacApiUser.myPage)
            .subscribe(onSuccess: { [weak self] response in
                print(response)
                self?.view.makeToast("업데이트 성공!") { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
                
            }, onFailure: { [weak self] error in
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacUserError(rawValue: errors) else { return }
                switch errCode {
                    
                case .firebaseTokenError:
                    guard let codeNum = NetworkManager.shared.refreshToken() else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            self?.login()
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
                    
                case .unsignedupUser, .ServerError, .ClientError:
                    self?.view.makeToast(errCode.errorDescription)
                default: break
                }
            })
            .disposed(by: myView.viewModel.disposeBag)
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        login()
        setNavigationStatus()
        myView.collectionView.delegate = self
        bindData()
    }
    
    func setNavigationStatus() {
        setNaigations(naviTitle: "정보 관리")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveAction))
    }
    
    func bindData() {
        
    }
    
    func login() {
        NetworkManager.shared.request(UserData.self, router: SeSacApiUser.login)
            .subscribe(onSuccess: { response in
                NetworkManager.shared.userData = response
                print(response)
                
            }, onFailure: { [weak self] error in
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacUserError(rawValue: errors) else { return }
                switch errCode {
                    
                case .firebaseTokenError:
                    guard let codeNum = NetworkManager.shared.refreshToken() else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            self?.login()
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
                    
                case .unsignedupUser, .ServerError, .ClientError:
                    self?.view.makeToast(errCode.errorDescription)
                default: break
                }
            })
            .disposed(by: myView.viewModel.disposeBag)
    }

}


// MARK: - Extension: UICollectionViewDelegate

extension ManageInfoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        if indexPath == [1, 0] {
            myView.isFolded = myView.isFolded ? false : true
            myView.updateUI()
        } else if indexPath == [6, 0] {
            let vc = CustomAlertViewController()
            vc.deleteView.state = .deleteAccount
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        
    }
}
