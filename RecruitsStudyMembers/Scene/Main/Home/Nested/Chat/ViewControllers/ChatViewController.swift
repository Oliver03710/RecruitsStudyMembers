//
//  ChatViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/04.
//

import UIKit

import SnapKit

final class ChatViewController: BaseViewController {

    // MARK: - Properties
    
    let chatView = ChatView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selectors
    
    @objc func showMore() {
        chatView.showMoreButtons()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations(naviTitle: "NickName")
    }
    
    override func setNaigations(naviTitle: String? = nil) {
        super.setNaigations(naviTitle: naviTitle)
        let stopButton = UIBarButtonItem(image: UIImage(named: GeneralIcons.more.rawValue), style: .plain, target: self, action: #selector(showMore))
        
        self.navigationItem.rightBarButtonItem = stopButton
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatView.showMoreButtons()
    }
}
