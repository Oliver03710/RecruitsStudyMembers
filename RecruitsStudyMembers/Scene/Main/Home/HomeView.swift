//
//  HomeView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//


import UIKit
import CoreLocation
import MapKit

import SnapKit

final class HomeView: BaseView {
    
    // MARK: - Properties
    
    let mapView: MKMapView = {
        let mv = MKMapView()
        return mv
    }()
    
    let locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [allGenderButton, maleButton, femaleButton])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 0
        sv.layer.cornerRadius = 1
        sv.layer.masksToBounds = false
        sv.layer.shadowColor = UIColor.black.cgColor
        sv.layer.shadowOpacity = 0.4
        sv.layer.shadowOffset = CGSize(width: 0, height: 4)
        sv.layer.shadowRadius = 4
        return sv
    }()
    
    private let allGenderButton: GenderButtonOnMap = {
        let btn = GenderButtonOnMap(text: "전체", isSelected: true)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return btn
    }()
    
    private let maleButton: GenderButtonOnMap = {
        let btn = GenderButtonOnMap(text: "남자")
        return btn
    }()
    
    private let femaleButton: GenderButtonOnMap = {
        let btn = GenderButtonOnMap(text: "여자")
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return btn
    }()
    
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let currentButton: CustomButton = {
        let btn = CustomButton(image: GeneralIcons.place.rawValue)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        addSubview(mapView)
        [verticalStackView, shadowView].forEach { mapView.addSubview($0) }
        shadowView.addSubview(currentButton)
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.directionalHorizontalEdges.equalTo(self.snp.directionalHorizontalEdges)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(48)
            $0.height.equalTo(verticalStackView.snp.width).multipliedBy(3)
        }
        
        shadowView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(verticalStackView.snp.bottom).offset(16)
            $0.width.height.equalTo(48)
        }
        
        currentButton.snp.makeConstraints {
            $0.edges.equalTo(shadowView)
        }
    }
}
