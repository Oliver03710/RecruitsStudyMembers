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
                                               etcOrGoodtimeButtonTapped: alertView.alertBodyView.etcOrGoodtimeButton.rx.tap,
                                               textViewEditingBegan: alertView.textView.rx.didBeginEditing,
                                               textViewEditingDidEnd: alertView.textView.rx.didEndEditing,
                                               executionButtonTapped: alertView.executionButton.rx.tap,
                                               textViewString: alertView.textView.rx.text.orEmpty)
        let output = alertView.viewModel.transform(input: input)
        
        output.xmarkButtonDriver
            .drive { [weak self] _ in
                self?.dismiss(animated: true)
                NetworkManager.shared.popupPresented = false
            }
            .disposed(by: alertView.viewModel.disposeBag)
        
        output.alertViewButtonMergedDriver
            .drive { [weak self] actions in
                guard let self = self else { return }
                print("before", NetworkManager.shared.reviewArr)
                switch actions {
                case .illigalOrManner:
                    self.alertView.alertBodyView.illigalOrMannerButton.backgroundColor =
                    self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.illigalOrMannerButton.layer.borderColor =
                    self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.illigalOrMannerButton.setTitleColor(self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.illigalOrMannerButton.tintColor = self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    NetworkManager.shared.reviewArr[Review.illigalOrManner.rawValue] = self.alertView.alertBodyView.illigalOrMannerButton.toggle == .off ? 0 : 1
                    self.alertView.alertBodyView.illigalOrMannerButton.toggle = self.alertView.alertBodyView.illigalOrMannerButton.toggle == .on ? .off : .on
                    
                case .unpleasantOrAppointment:
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.backgroundColor =
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.layer.borderColor =
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.setTitleColor(self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.tintColor = self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    NetworkManager.shared.reviewArr[Review.unpleasantOrAppointment.rawValue] = self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .off ? 0 : 1
                    self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle = self.alertView.alertBodyView.unpleasantOrAppointmentButton.toggle == .on ? .off : .on
                    
                case .noShowOrResponse:
                    self.alertView.alertBodyView.noShowOrResponseButton.backgroundColor =
                    self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.noShowOrResponseButton.layer.borderColor =
                    self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.noShowOrResponseButton.setTitleColor(self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.noShowOrResponseButton.tintColor = self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    NetworkManager.shared.reviewArr[Review.noShowOrResponse.rawValue] = self.alertView.alertBodyView.noShowOrResponseButton.toggle == .off ? 0 : 1
                    self.alertView.alertBodyView.noShowOrResponseButton.toggle = self.alertView.alertBodyView.noShowOrResponseButton.toggle == .on ? .off : .on
                    
                case .sexualOrKind:
                    self.alertView.alertBodyView.sexualOrKindButton.backgroundColor =
                    self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.sexualOrKindButton.layer.borderColor =
                    self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.sexualOrKindButton.setTitleColor(self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.sexualOrKindButton.tintColor = self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    NetworkManager.shared.reviewArr[Review.sexualOrKind.rawValue] = self.alertView.alertBodyView.sexualOrKindButton.toggle == .off ? 0 : 1
                    self.alertView.alertBodyView.sexualOrKindButton.toggle = self.alertView.alertBodyView.sexualOrKindButton.toggle == .on ? .off : .on
                    
                case .harrasmentOrSkilled:
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.backgroundColor =
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.layer.borderColor =
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.setTitleColor(self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.tintColor = self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    NetworkManager.shared.reviewArr[Review.harrasmentOrSkilled.rawValue] = self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .off ? 0 : 1
                    self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle = self.alertView.alertBodyView.harrasmentOrSkilledButton.toggle == .on ? .off : .on
                    
                case .etcOrGoodtime:
                    self.alertView.alertBodyView.etcOrGoodtimeButton.backgroundColor =
                    self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? SSColors.white.color : SSColors.green.color
                    self.alertView.alertBodyView.etcOrGoodtimeButton.layer.borderColor =
                    self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? SSColors.gray4.color.cgColor : SSColors.green.color.cgColor
                    self.alertView.alertBodyView.etcOrGoodtimeButton.setTitleColor(self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? SSColors.black.color : SSColors.white.color, for: .normal)
                    self.alertView.alertBodyView.etcOrGoodtimeButton.tintColor = self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? SSColors.black.color : SSColors.white.color
                    NetworkManager.shared.reviewArr[Review.etcOrGoodtime.rawValue] = self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .off ? 0 : 1
                    self.alertView.alertBodyView.etcOrGoodtimeButton.toggle = self.alertView.alertBodyView.etcOrGoodtimeButton.toggle == .on ? .off : .on
                }
                print("after", NetworkManager.shared.reviewArr)
            }
            .disposed(by: alertView.viewModel.disposeBag)
        
        output.textViewDriver
        .drive { [weak self] actions in
            guard let self = self else { return }
            switch actions {
            case .editingDidBegin:
                if self.alertView.textView.text == "자세한 피드백은 다른 새싹들에게 도움이 됩니다. (500자 이내 작성)" || self.alertView.textView.textColor == SSColors.gray1.color {
                    self.alertView.textView.textColor = SSColors.black.color
                    self.alertView.textView.text = ""
                }
                
            case .editingDidEnd:
                if self.alertView.textView.text.isEmpty {
                    self.alertView.textView.text = "자세한 피드백은 다른 새싹들에게 도움이 됩니다. (500자 이내 작성)"
                    self.alertView.textView.textColor = SSColors.gray1.color
                }
            }
        }
        .disposed(by: alertView.viewModel.disposeBag)
        
        output.executionButtonValid
            .asDriver()
            .drive { [weak self] empty in
                guard let self = self else { return }
                if !empty && self.alertView.textView.text != "자세한 피드백은 다른 새싹들에게 도움이 됩니다. (500자 이내 작성)" {
                    self.alertView.executionButton.configuration =
                    self.alertView.executionButton.buttonConfiguration(text: "리뷰 등록하기", withImage: false, config: .plain(), foregroundColor: SSColors.white.color, font: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size, lineHeight: SSFonts.body3R14.lineHeight)
                    self.alertView.executionButton.layer.borderColor = SSColors.green.color.cgColor
                    self.alertView.executionButton.backgroundColor = SSColors.green.color
                    self.alertView.executionButton.isUserInteractionEnabled = true
                    
                } else {
                    self.alertView.executionButton.configuration =
                    self.alertView.executionButton.buttonConfiguration(text: "리뷰 등록하기", withImage: false, config: .plain(), foregroundColor: SSColors.gray3.color, font: SSFonts.body3R14.fonts, size: SSFonts.body3R14.size, lineHeight: SSFonts.body3R14.lineHeight)
                    self.alertView.executionButton.setTitleColor(SSColors.gray3.color, for: .normal)
                    self.alertView.executionButton.layer.borderColor = SSColors.gray6.color.cgColor
                    self.alertView.executionButton.backgroundColor = SSColors.gray6.color
                    self.alertView.executionButton.isUserInteractionEnabled = false
                }
            }
            .disposed(by: alertView.viewModel.disposeBag)
        
        output.executionButtonDriver
            .drive { _ in
                print("Tapped")
            }
            .disposed(by: alertView.viewModel.disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
