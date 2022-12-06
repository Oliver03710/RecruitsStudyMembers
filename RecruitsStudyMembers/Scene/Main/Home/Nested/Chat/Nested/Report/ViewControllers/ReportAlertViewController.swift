//
//  ReportAlertViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/06.
//

import UIKit

final class ReportAlertViewController: BaseViewController {

    // MARK: - Properties
    
    let alertView = AlertSplitView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    
}
