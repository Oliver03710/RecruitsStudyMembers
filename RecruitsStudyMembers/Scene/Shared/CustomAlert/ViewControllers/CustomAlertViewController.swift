//
//  CustomAlertViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/23.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift
import Toast

final class CustomAlertViewController: BaseViewController {

    // MARK: - Properties
    
    let customAlertView = CustomAlertView()
    private var sendToAccept = false
    
    
    // MARK: - Init
    
    override func loadView() {
        view = customAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        bindData()
    }
    
    private func bindData() {
        let input = CustomAlertViewModel.Input(cancelButtonTapped: customAlertView.cancelButton.rx.tap,
                                               confirmButtonTapped: customAlertView.confirmButton.rx.tap)
        let output = customAlertView.viewModel.transform(input: input)
        
        
        output.cancelButtonDriver
            .drive { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: customAlertView.viewModel.disposeBag)
        
        output.confirmButtonDriver
            .drive { [weak self] _ in
                guard let self = self else { return }
                switch self.customAlertView.state {
                case .sendRequest:
                    self.sendRequest()
                    
                case .acceptRequest:
                    self.acceptRequest()
                    
                case .deleteAccount:
                    self.deleteAccount()
                    self.dismiss(animated: true)
                    
                case .cancelStudy:
                    self.cancelStudy()
                    self.dismiss(animated: true)
                }
            }
            .disposed(by: customAlertView.viewModel.disposeBag)
    }
    
    private func deleteAccount() {
        NetworkManager.shared.request(router: SeSacApiUser.withdraw)
            .subscribe(onSuccess: { data, status in
                print(data)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = SplashViewController()
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
                
                ChatRepository.shared.deleteAll()
                UserDefaultsManager.removeAll()
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.deleteAccount()
                    } errorHandler: {
                        self?.view.makeToast("????????? ??????????????????. ?????? ??? ?????? ??????????????????.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: customAlertView.viewModel.disposeBag)
    }
    
    private func sendRequest() {
        NetworkManager.shared.request(router: SeSacApiQueue.sendRequest)
            .subscribe(onSuccess: { [weak self] data, status in
                print(data)
                guard let self = self, let status = SesacStatus.Queue.StudyRequest(rawValue: status) else { return }
                switch status {
                case .success:
                    self.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast("????????? ?????? ???????????? ???????????????.")
                    })
                    
                case .alreadyReceivedRequest:
                    self.sendToAccept = true
                    self.acceptRequest()
                    
                case .userCanceledSeeking:
                    self.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast("???????????? ????????? ????????? ?????????????????????.")
                    })
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.sendRequest()
                    } errorHandler: {
                        self?.view.makeToast("????????? ??????????????????. ?????? ??? ?????? ??????????????????.")
                    }

                default:
                    self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: customAlertView.viewModel.disposeBag)
    }
    
    private func acceptRequest() {
        NetworkManager.shared.request(router: SeSacApiQueue.acceptRequest)
            .subscribe(onSuccess: { [weak self] data, status in
                print(data)
                guard let self = self, let status = SesacStatus.Queue.AcceptStudyRequest(rawValue: status) else { return }
                switch status {
                case .success:
                    if self.sendToAccept {
                        self.dismiss(animated: true, completion: {
                            UIApplication.getTopMostViewController()?.view.makeToast("???????????? ???????????? ???????????? ?????????????????????. ?????? ??? ??????????????? ???????????????.", completion: { _ in
                                NetworkManager.shared.queueState.accept(.matched)
                                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                                let vc = MainTabBarController()
                                sceneDelegate?.window?.rootViewController = vc
                                sceneDelegate?.window?.makeKeyAndVisible()
                                let targetVC = ChatViewController()
                                vc.navigationController?.pushViewController(targetVC, animated: true)
                            })
                        })
                        
                    } else {
                        self.dismiss(animated: true, completion: {
                            NetworkManager.shared.queueState.accept(.matched)
                            let vc = ChatViewController()
                            UIApplication.getTopMostViewController()?.navigationController?.pushViewController(vc, animated: true)
                        })
                    }
                    self.sendToAccept = false
                    
                case .userAlreadyMatched:
                    self.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast("???????????? ?????? ?????? ????????? ???????????? ?????? ?????? ????????????.")
                    })
                    
                case .userCanceledSeeking:
                    self.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast("???????????? ????????? ????????? ?????????????????????.")
                    })
                    
                case .meAlreadyMatched:
                    self.dismiss(animated: true, completion: {
                        UIApplication.getTopMostViewController()?.view.makeToast("???! ???????????? ?????? ???????????? ??????????????????!", completion: { _ in
                            self.checkMyQueueState()
                        })
                    })
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.acceptRequest()
                    } errorHandler: {
                        self?.view.makeToast("????????? ??????????????????. ?????? ??? ?????? ??????????????????.")
                    }

                default:
                    self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: customAlertView.viewModel.disposeBag)
    }
    
    private func cancelStudy() {
        NetworkManager.shared.request(router: SeSacApiQueue.dodge)
            .subscribe(onSuccess: { [weak self] response, state in
                guard let self = self, let status = SesacStatus.Queue.Dodge(rawValue: state) else { return }
                switch status {
                case .success:
                    NetworkManager.shared.queueState.accept(.defaultState)
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let vc = MainTabBarController()
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
                    ChatRepository.shared.deleteAll()
                    
                case .wrongUid:
                    self.view.makeToast("??????????????? ????????? ???????????? ??????????????????.")
                }
                
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                let err = (error as NSError).code
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self.cancelStudy()
                    } errorHandler: {
                        self.view.makeToast("????????? ??????????????????. ?????? ??? ?????? ??????????????????.")
                    }

                default:
                    self.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: customAlertView.viewModel.disposeBag)
    }
    
    private func checkMyQueueState() {
        NetworkManager.shared.request(QueueStateData.self, router: SeSacApiQueue.myQueueState)
            .subscribe(onSuccess: { [weak self] response, state in
                print(response, state)
                guard let self = self, let state = SesacStatus.Queue.myQueueState(rawValue: state) else { return }
                switch state {
                case .success:
                    if response.matched == 1 {
                        self.dismiss(animated: true, completion: {
                            UIApplication.getTopMostViewController()?.view.makeToast("\(NetworkManager.shared.nickName)?????? ?????????????????????. ?????? ??? ??????????????? ???????????????.", completion: { _ in
                                NetworkManager.shared.queueState.accept(.matched)
                                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                                let vc = MainTabBarController()
                                sceneDelegate?.window?.rootViewController = vc
                                sceneDelegate?.window?.makeKeyAndVisible()
                                let targetVC = ChatViewController()
                                vc.navigationController?.pushViewController(targetVC, animated: true)
                            })
                        })
                    }
                    
                case .defaultState:
                    print("?????? ??????")
                }
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.checkMyQueueState()
                    } errorHandler: {
                        self?.view.makeToast("????????? ??????????????????. ?????? ??? ?????? ??????????????????.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: customAlertView.viewModel.disposeBag)
    }
}
