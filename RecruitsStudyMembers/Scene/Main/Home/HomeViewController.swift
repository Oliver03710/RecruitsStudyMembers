//
//  HomeViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit
import CoreLocation
import MapKit

import Toast

final class HomeViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = HomeView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations()
        setDelegates()
    }
    
    override func setNaigations(naviTitle: String? = nil) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setDelegates() {
        myView.mapView.delegate = self
        myView.locationManager.delegate = self
    }
    
    func setAnnotations() {
        let annotation = SeSacAnnotation(0)
        annotation.coordinate = myView.mapView.region.center
        myView.mapView.addAnnotation(annotation)
        
        let radius = 700.0
        let circle = MKCircle(center: myView.mapView.region.center, radius: radius)
        myView.mapView.addOverlay(circle)
    }
    
    func removeAllFromMap() {
        myView.mapView.annotations.forEach { (annotation) in
            if let annotation = annotation as? MKPointAnnotation {
                myView.mapView.removeAnnotation(annotation)
            }
        }
        
        myView.mapView.overlays.forEach { (overlay) in
            myView.mapView.removeOverlay(overlay)
        }
    }
}


// MARK: - Authorizations

extension HomeViewController {
    
    func showRequestLocationServiceAlert() {
        
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
        
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
        
    }
}


// MARK: - Extension: MKMapViewDelegate

extension HomeViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        removeAllFromMap()
        setAnnotations()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = SSColors.green.color
        circleRenderer.lineWidth = 1.0
        circleRenderer.fillColor = UIColor(red: 0.2862745098, green: 0.862745098, blue: 0.5725490196, alpha: 0.1)
        return circleRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? SeSacAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "\(annotation.identifier)")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "\(annotation.identifier)")
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: GeneralIcons.mapMarker.rawValue)

        return annotationView
    }

}


// MARK: - Extension: CLLocationManagerDelegate

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            myView.mapView.setRegion(region, animated: true)
        }
        
        myView.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        view.makeToast("위치 이동에 실패")
    }
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                myView.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                myView.locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                print("Denied, 아이폰 설정으로 유도")
                showRequestLocationServiceAlert()
            case .authorizedWhenInUse:
                removeAllFromMap()
                myView.locationManager.startUpdatingLocation()
            default:
                break
            }
        }
    }
    
}
