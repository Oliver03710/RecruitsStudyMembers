//
//  ReportAlertViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/06.
//

import UIKit

import RxCocoa
import RxSwift

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
    
    override func configureUI() {
        binds()
    }
    
    private func binds() {
        let input = ReportAlertViewModel.Input(xmarkButtonTapped: alertView.alertTitleView.xmarkButton.rx.tap,
                                               illigalOrMannerButtonTapped: alertView.alertBodyView.illigalOrMannerButton.rx.tap,
                                               unpleasantOrAppointmentButtonTapped: alertView.alertBodyView.unpleasantOrAppointmentButton.rx.tap,
                                               noShowOrResponseButtonTapped: alertView.alertBodyView.noShowOrResponseButton.rx.tap,
                                               sexualOrKindButtonTapped: alertView.alertBodyView.sexualOrKindButton.rx.tap,
                                               harrasmentOrSkilledButtonTapped: alertView.alertBodyView.harrasmentOrSkilledButton.rx.tap,
                                               etcOrGoodtimeButtonTapped: alertView.alertBodyView.etcOrGoodtimeButton.rx.tap)
        let output = alertView.viewModel.transform(input: input)
        
        output.xmarkButtonDriver
            .drive { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: alertView.viewModel.disposeBag)
        
        output.alertViewButtonMergedDriver
            .drive { [weak self] actions in
                guard let self = self else { return }
                
                switch actions {
                case .illigalOrManner:
                    self.alertView.alertBodyView.illigalOrMannerButton.backgroundColor =
                    self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.illigalOrMannerButton.layer.borderColor =
                    self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.illigalOrMannerButton.setTitleColor(self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.illigalOrMannerButton.tintColor = self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    self.alertView.alertBodyView.illigalOrMannerButton.toggle = self.alertView.alertBodyView.illigalOrMannerButton.toggle == .on ? .off : .on
                    
                case .unpleasantOrAppointment:
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.backgroundColor =
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.layer.borderColor =
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.setTitleColor(self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.tintColor = self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle = self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .on ? .off : .on
                    
                case .noShowOrResponse:
                    self.alertView.alertBodyView.noShowOrResponseButton.backgroundColor =
                    self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.noShowOrResponseButton.layer.borderColor =
                    self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.noShowOrResponseButton.setTitleColor(self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.noShowOrResponseButton.tintColor = self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    self.alertView.alertBodyView.noShowOrResponseButton.toggle = self.alertView.alertBodyView.noShowOrResponseButton.toggle == .on ? .off : .on
                    
                case .sexualOrKind:
                    self.alertView.alertBodyView.sexualOrKindButton.backgroundColor =
                    self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.sexualOrKindButton.layer.borderColor =
                    self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.sexualOrKindButton.setTitleColor(self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.sexualOrKindButton.tintColor = self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    self.alertView.alertBodyView.sexualOrKindButton.toggle = self.alertView.alertBodyView.sexualOrKindButton.toggle == .on ? .off : .on
                    
                case .harrasmentOrSkilled:
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.backgroundColor =
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.layer.borderColor =
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.setTitleColor(self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.tintColor = self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle = self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .on ? .off : .on
                    
                case .etcOrGoodtime:
                    self.alertView.alertBodyView.etcOrGoodtimeButton.backgroundColor =
                    self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.etcOrGoodtimeButton.layer.borderColor =
                    self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.etcOrGoodtimeButton.setTitleColor(self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.etcOrGoodtimeButton.tintColor = self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    self.alertView.alertBodyView.etcOrGoodtimeButton.toggle = self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .on ? .off : .on
                    
                }
            }
            .disposed(by: alertView.viewModel.disposeBag)
    }
}
