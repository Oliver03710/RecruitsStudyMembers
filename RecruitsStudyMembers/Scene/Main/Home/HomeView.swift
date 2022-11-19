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
        sv.backgroundColor = SSColors.white.color
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 0
        sv.clipsToBounds = true
        sv.layer.cornerRadius = 8
        
        return sv
    }()
    
    private let allGenderButton: GenderButtonOnMap = {
        let btn = GenderButtonOnMap(text: "전체", isSelected: true)
        return btn
    }()
    
    private let maleButton: GenderButtonOnMap = {
        let btn = GenderButtonOnMap(text: "남자")
        return btn
    }()
    
    private let femaleButton: GenderButtonOnMap = {
        let btn = GenderButtonOnMap(text: "여자")
        return btn
    }()
    
    private let currentButton: CustomButton = {
        let btn = CustomButton(image: GeneralIcons.place.rawValue)
        return btn
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        addSubview(mapView)
        [verticalStackView, currentButton].forEach { mapView.addSubview($0) }
        
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
        
        currentButton.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(verticalStackView.snp.bottom).offset(16)
            $0.width.height.equalTo(48)
        }
    }
}
