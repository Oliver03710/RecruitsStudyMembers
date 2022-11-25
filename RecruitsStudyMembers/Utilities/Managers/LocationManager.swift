//
//  LocationManager.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/25.
//

import Foundation

final class LocationManager {
    
    // MARK: - Properties
    
    static let shared = LocationManager()
    var currentPosition: (lat: Double, lon: Double) = (0.0, 0.0)
    
    
    // MARK: - Init
    
    private init() { }
    
    
    // MARK: - Helper Functions
    
    
    
}
