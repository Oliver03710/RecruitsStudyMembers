//
//  HomeViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit
import CoreLocation
import MapKit

import RxCocoa
import RxSwift
import Toast

final class HomeViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = HomeView()
    private let viewModel = HomeViewModel()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        checkUserDeviceLocationServiceAuthorization()
        setDelegates()
        bindData()
    }
    
    private func setDelegates() {
        myView.mapView.delegate = self
        myView.locationManager.delegate = self
    }
    
    private func setAnnotations(identifier: Int) {
        let annotation = SeSacAnnotation(identifier)
        annotation.coordinate = myView.mapView.region.center
        myView.mapView.addAnnotation(annotation)
    }
    
    private func setCircleOverlay() {
        let radius = 700.0
        let circle = MKCircle(center: myView.mapView.region.center, radius: radius)
        myView.mapView.addOverlay(circle)
    }
    
    private func removeAllFromMap() {
        myView.mapView.annotations.forEach { (annotation) in
            if let annotation = annotation as? MKPointAnnotation {
                myView.mapView.removeAnnotation(annotation)
            }
        }
        
        myView.mapView.overlays.forEach { (overlay) in
            myView.mapView.removeOverlay(overlay)
        }
    }
    
    private func bindData() {
        let input = HomeViewModel.Input(currentButtonTapped: myView.currentButton.rx.tap, seekButtonTapped: myView.seekButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.seekButtonDriver
            .drive { [weak self] _ in
                self?.myView.locationManager.authorizationStatus == .denied || self?.myView.locationManager.authorizationStatus == .restricted ? self?.checkUserDeviceLocationServiceAuthorization() : self?.PresentToSearchVC()
            }
            .disposed(by: viewModel.disposeBag)
        
        output.currentButtonDriver
            .drive { [weak self] _ in
                self?.checkUserDeviceLocationServiceAuthorization()
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func PresentToSearchVC() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func checkMyQueueState() {
        NetworkManager.shared.request(router: SeSacApiQueue.myQueueState)
            .subscribe(onSuccess: { response in
                print(response)
                
            }, onFailure: { [weak self] error in
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacError(rawValue: errors) else { return }
                switch errCode {
                    
                case .firebaseTokenError:
                    NetworkManager.shared.fireBaseError {
                        self?.checkMyQueueState()
                    } errorHandler: {
                        self?.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요.", position: .top)
                    } defaultErrorHandler: {
                        self?.view.makeToast("에러가 발생했습니다. 다시 시도해주세요.", position: .top)
                    }
                    
                case .unsignedupUser, .ServerError, .ClientError:
                    self?.view.makeToast(errCode.errorDescription)
                default: break
                }
            })
            .disposed(by: viewModel.disposeBag)
    }
}


// MARK: - Extension: Authorizations

extension HomeViewController {
    
    private func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            authorizationStatus = myView.locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        self.checkUserCurrentLocationAuthorization(authorizationStatus)
    }
    
    private func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            myView.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            myView.locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            myView.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.517819364682694, longitude: 126.88647317074734), latitudinalMeters: 700, longitudinalMeters: 700), animated: true)
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            myView.locationManager.startUpdatingLocation()
            
        default:
            print("Default")
        }
    }
    
    private func showRequestLocationServiceAlert() {
        
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
        setAnnotations(identifier: 0)
        setCircleOverlay()
        // 스터디 멤버 찾기 메서드 추가
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            mapView.isUserInteractionEnabled = true
        }
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
        checkUserDeviceLocationServiceAuthorization()
    }
    
}
