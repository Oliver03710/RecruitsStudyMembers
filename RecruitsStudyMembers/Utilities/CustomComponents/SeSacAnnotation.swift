//
//  SeSacAnnotation.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/19.
//

import MapKit

final class SeSacAnnotation: MKPointAnnotation {
    var identifier: Int
    
    init(_ identifier: Int) {
        self.identifier = identifier
    }
}
