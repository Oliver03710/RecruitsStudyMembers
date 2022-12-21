//
//  MyinfoViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

final class MyinfoViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = MyinfoView()
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setTableViewComponents()
        getUserInfo()
    }
    
    func setTableViewComponents() {
        myView.tableView.delegate = self
    }
    
    private func getUserInfo() {
        NetworkManager.shared.request(UserData.self, router: SeSacApiUser.login)
            .subscribe(onSuccess: { respone, _ in
                NetworkManager.shared.userData = respone
                print(respone)
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.getUserInfo()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }

                default:
                    self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: disposeBag)
    }
    
}


// MARK: - Extension: UITableViewDelegate

extension MyinfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = ManageInfoViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = myView.bounds.height
        return indexPath.row == 0 ? height / 11 : height / 12
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        }
    }
}
