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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.directionalHorizontalEdges.equalTo(self.snp.directionalHorizontalEdges)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
