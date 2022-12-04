//
//  ChatViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/04.
//

import UIKit

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
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations(naviTitle: "NickName")
    }
    
    override func setNaigations(naviTitle: String? = nil) {
        super.setNaigations(naviTitle: naviTitle)
        let stopButton = UIBarButtonItem(image: UIImage(named: GeneralIcons.more.rawValue), style: .plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = stopButton
    }

}
