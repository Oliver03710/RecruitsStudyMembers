//
//  CustomSlider.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/18.
//

import UIKit

import SnapKit

final class CustomSlider: UIControl {
    
    // MARK: - Enum
    
    private enum SliderConstants {
        static let barRatio = 1.0/10.0
    }
    
    
    // MARK: - properties
    
    private let lowerThumbButton: ThumbButton = {
        let btn = ThumbButton()
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    private let upperThumbButton: ThumbButton = {
        let btn = ThumbButton()
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    private let trackView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.gray2.color
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let trackTintView: UIView = {
        let view = UIView()
        view.backgroundColor = SSColors.green.color
        view.isUserInteractionEnabled = false
        return view
    }()
    
    var minValue = 0.0 {
        didSet {
            self.lower = self.minValue
        }
    }
    
    var maxValue = 10.0 {
        didSet {
            self.upper = self.maxValue
        }
    }
    var lower = 0.0 {
        didSet {
            self.updateLayout(self.lower, true)
        }
    }
    var upper = 0.0 {
        didSet {
            self.updateLayout(self.upper, false)
        }
    }
    
    var lowerThumbColor = SSColors.green.color {
        didSet {
            self.lowerThumbButton.backgroundColor = self.lowerThumbColor
        }
    }
    
    var upperThumbColor = SSColors.green.color {
        didSet {
            self.upperThumbButton.backgroundColor = self.upperThumbColor
        }
    }
    
    var trackColor = SSColors.gray2.color {
        didSet {
            self.trackView.backgroundColor = self.trackColor
        }
    }
    
    var trackTintColor = SSColors.green.color {
        didSet {
            self.trackTintView.backgroundColor = self.trackTintColor
        }
    }
    
    private var previousTouchPoint = CGPoint.zero
    private var isLowerThumbViewTouched = false
    private var isUpperThumbViewTouched = false
    private var leftConstraint: Constraint?
    private var rightConstraint: Constraint?
    
    private var thumbViewLength: Double {
        Double(self.bounds.height)
    }
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.trackView)
        self.addSubview(self.trackTintView)
        self.addSubview(self.lowerThumbButton)
        self.addSubview(self.upperThumbButton)
        
        self.lowerThumbButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.lessThanOrEqualTo(self.upperThumbButton.snp.left)
            $0.left.greaterThanOrEqualToSuperview()
            $0.width.height.equalTo(22)
            self.leftConstraint = $0.left.equalTo(self.snp.left).priority(999).constraint
        }
        self.upperThumbButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.greaterThanOrEqualTo(self.lowerThumbButton.snp.right)
            $0.right.lessThanOrEqualToSuperview()
            $0.width.height.equalTo(22)
            self.rightConstraint = $0.left.equalTo(self.snp.left).priority(999).constraint
        }
        self.trackView.snp.makeConstraints {
            $0.left.right.centerY.equalToSuperview()
            $0.height.equalTo(self).multipliedBy(SliderConstants.barRatio)
        }
        self.trackTintView.snp.makeConstraints {
            $0.left.equalTo(self.lowerThumbButton.snp.right)
            $0.right.equalTo(self.upperThumbButton.snp.left)
            $0.top.bottom.equalTo(self.trackView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("xib is not implemented")
    }
    
    
    // MARK: - functions
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        return self.lowerThumbButton.frame.contains(point) || self.upperThumbButton.frame.contains(point)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        self.previousTouchPoint = touch.location(in: self)
        self.isLowerThumbViewTouched = self.lowerThumbButton.frame.contains(self.previousTouchPoint)
        self.isUpperThumbViewTouched = self.upperThumbButton.frame.contains(self.previousTouchPoint)
        
        if self.isLowerThumbViewTouched {
            self.lowerThumbButton.isSelected = true
        } else {
            self.upperThumbButton.isSelected = true
        }
        
        return self.isLowerThumbViewTouched || self.isUpperThumbViewTouched
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
        let touchPoint = touch.location(in: self)
        defer {
            self.previousTouchPoint = touchPoint
            self.sendActions(for: .valueChanged)
        }
        
        let drag = Double(touchPoint.x - self.previousTouchPoint.x)
        let scale = self.maxValue - self.minValue
        let scaledDrag = scale * drag / Double(self.bounds.width - self.thumbViewLength)
        
        if self.isLowerThumbViewTouched {
            self.lower = (self.lower + scaledDrag)
                .clamped(to: (self.minValue...self.upper))
        } else {
            self.upper = (self.upper + scaledDrag)
                .clamped(to: (self.lower...self.maxValue))
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        self.sendActions(for: .valueChanged)
        
        self.lowerThumbButton.isSelected = false
        self.upperThumbButton.isSelected = false
    }
    
    private func updateLayout(_ value: Double, _ isLowerThumb: Bool) {
        DispatchQueue.main.async {
            let startValue = value - self.minValue
            let length = self.bounds.width - self.thumbViewLength
            let offset = startValue * length / (self.maxValue - self.minValue)
            
            if isLowerThumb {
                self.leftConstraint?.update(offset: offset)
            } else {
                self.rightConstraint?.update(offset: offset)
            }
        }
    }
}


// MARK: - Extension: Comparable

extension Comparable {
    
  func clamped(to limits: ClosedRange<Self>) -> Self {
    min(max(self, limits.lowerBound), limits.upperBound)
  }
    
}
