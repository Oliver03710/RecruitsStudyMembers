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
                                          accButtonTapped: searchView.accButton.rx.tap)
        
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
    }
    
    private func showListTapped() {
        let vc = MemberListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - Extension: UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let newData = searchView.dataSource.itemIdentifier(for: indexPath) else {
//            collectionView.deselectItem(at: indexPath, animated: true)
//            return
//        }
//
//        if indexPath.section == 0 {
//            let data = SearchView.Item(title: NetworkManager.shared.nearByStudyList[indexPath.item].title)
//            NetworkManager.shared.myStudyList.append(data)
//        } else {
//            NetworkManager.shared.myStudyList.remove(at: indexPath.item)
//        }
//
//        var currentSnapshot = searchView.dataSource.snapshot()
//
//        currentSnapshot.reconfigureItems([newData])
//        searchView.dataSource.apply(currentSnapshot)
//
//        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        collectionView.deselectItem(at: indexPath, animated: false)
        if indexPath.section == 0 {
            let data = SearchView.Item(title: NetworkManager.shared.nearByStudyList[indexPath.item].title)
            NetworkManager.shared.myStudyList.append(data)
        } else {
            NetworkManager.shared.myStudyList.remove(at: indexPath.item)
        }
        searchView.updateUI()
    }
}
