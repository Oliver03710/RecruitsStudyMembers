//
//  SearchViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Toast

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    let searchView = SearchView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        settingNavibars()
        collectionViewDelegate()
        bindData()
    }
    
    private func settingNavibars() {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.backgroundColor = SSColors.white.color
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.title = nil
        navigationController?.navigationBar.tintColor = SSColors.black.color
        navigationController?.isNavigationBarHidden = false
        
        let backButton = UIBarButtonItem(image: UIImage(named: GeneralIcons.arrow.rawValue), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem  = backButton
        
        navigationItem.titleView = searchView.searchBar
    }
    
    private func collectionViewDelegate() {
        searchView.collectionView.delegate = self
    }
    
    private func bindData() {
        
        let input = SearchViewModel.Input(textDidBeginEditing: searchView.searchBar.rx.textDidBeginEditing,
                                          textDidEndEditing: searchView.searchBar.rx.textDidEndEditing,
                                          seekButtonTapped: searchView.seekButton.rx.tap,
                                          accButtonTapped: searchView.accButton.rx.tap,
                                          searchButtonClicked: searchView.searchBar.rx.searchButtonClicked)
        
        let output = searchView.viewModel.transform(input: input)
        
        
        output.textEditingAction
        .drive { [weak self] actions in
            guard let self = self else { return }
            switch actions {
            case .editingDidBegin:
                self.searchView.seekButton.isHidden = true
                self.searchView.searchBar.searchTextField.inputAccessoryView = self.searchView.accButton
                
            case .editingDidEnd:
                self.searchView.seekButton.isHidden = false
            }
        }
        .disposed(by: searchView.viewModel.disposeBag)
        
        output.actionsCombined
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.showListTapped()
            }
            .disposed(by: searchView.viewModel.disposeBag)
        
        output.searchButtonDriver
            .drive { [weak self] action in
                switch action {
                case .action1:
                    var bool = false
                    
                    guard let text = self?.searchView.searchBar.text else { return }
                    let study = text.split(separator: " ", omittingEmptySubsequences: true)
                    self?.searchView.searchBar.searchTextField.text = ""
                    
                    study.forEach { str in
                        NetworkManager.shared.myStudyList.forEach { item in
                            if item.title.lowercased() == str.lowercased() {
                                self?.view.makeToast("이미 있는 항목입니다.", position: .top)
                                bool = true
                            }
                            return
                        }
                        
                        if NetworkManager.shared.myStudyList.count > 7 && !bool {
                            self?.view.makeToast("더 이상 추가할 수 없습니다.", position: .top)
                            
                        } else if !bool {
                            let data = SearchView.Item(title: String(str))
                            NetworkManager.shared.myStudyList.append(data)
                            self?.searchView.updateUI()
                            
                        } else {
                            bool = false
                        }
                    }
                    
                default: break
                }

            }
            .disposed(by: searchView.viewModel.disposeBag)
    }
    
    private func showListTapped() {
        NetworkManager.shared.request(router: SeSacApiQueue.queue)
            .subscribe(onSuccess: { [weak self] response in
                let vc = MemberListViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
                
            }, onFailure: { [weak self] error in
                let err = (error as NSError).code
                print(err)
                guard let errStatus = SesacStatus.DefaultError(rawValue: err) else { return }
                switch errStatus {
                case .firebase:
                    NetworkManager.shared.fireBaseError {
                        self?.showListTapped()
                    } errorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 잠시 후 다시 실행해주세요.")
                    }
                    
                default: self?.view.makeToast(errStatus.errorDescription)
                }
            })
            .disposed(by: searchView.viewModel.disposeBag)
    }
    
}


// MARK: - Extension: UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        if indexPath.section == 0 {
            
            var bool = false
            
            NetworkManager.shared.myStudyList.forEach { myItem in
                if myItem.title.lowercased() == NetworkManager.shared.nearByStudyList[indexPath.item].title.lowercased() {
                    view.makeToast("이미 있는 항목입니다.", position: .top)
                    bool = true
                }
                return
            }
            
            if NetworkManager.shared.myStudyList.count > 7 && !bool {
                view.makeToast("더 이상 추가할 수 없습니다.", position: .top)
                
            } else if !bool {
                let data = SearchView.Item(title: NetworkManager.shared.nearByStudyList[indexPath.item].title)
                NetworkManager.shared.myStudyList.append(data)
                searchView.updateUI()
                
            } else {
                bool = false
            }
            
        } else {
            NetworkManager.shared.myStudyList.remove(at: indexPath.item)
        }
        searchView.updateUI()
    }
}
