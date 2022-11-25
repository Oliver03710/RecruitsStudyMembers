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
    
    func removeAnnotations() {
        myView.mapView.annotations.forEach { (annotation) in
            if let annotation = annotation as? MKPointAnnotation {
                myView.mapView.removeAnnotation(annotation)
            }
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
                guard let self = self else { return }
                self.checkUserDeviceLocationServiceAuthorization()
                if !(self.myView.locationManager.authorizationStatus == .denied) || !(self.myView.locationManager.authorizationStatus == .restricted) {
                    LocationManager.shared.currentPosition = (self.myView.mapView.region.center.latitude, self.myView.mapView.region.center.longitude)
                    self.searchStudyMembers()
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        output.memberDriver
            .drive { [weak self] dataArr in
                guard let self = self else { return }
                self.removeAnnotations()
                dataArr.forEach { data in
                    let anno = SeSacAnnotation()
                    anno.coordinate = CLLocationCoordinate2D(latitude: data.lat, longitude: data.long)
                    anno.image = data.sesac
                    self.myView.mapView.addAnnotation(anno)
                }
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
                guard let errCode = SeSacUserError(rawValue: errors) else { return }
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
    
    func searchStudyMembers() {
        NetworkManager.shared.request(QueueData.self, router: SeSacApiQueue.search)
            .subscribe(onSuccess: { [weak self] response in
                dump(response)
                self?.viewModel.members.accept(response.fromQueueDB)
                
            }, onFailure: { [weak self] error in
                let errors = (error as NSError).code
                print(errors)
                guard let errCode = SeSacUserError(rawValue: errors) else { return }
                switch errCode {
                    
                case .firebaseTokenError:
                    NetworkManager.shared.fireBaseError {
                        self?.searchStudyMembers()
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
        LocationManager.shared.currentPosition = (mapView.region.center.latitude, mapView.region.center.longitude)
        searchStudyMembers()
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            mapView.isUserInteractionEnabled = true
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? SeSacAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "\(annotation.uuid)")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "\(annotation.uuid)")
        } else {
            annotationView?.annotation = annotation
        }
        
        switch annotation.image {
        case 0: annotationView?.image = FaceImages(rawValue: 0)?.images
        case 1: annotationView?.image = FaceImages(rawValue: 1)?.images
        case 2: annotationView?.image = FaceImages(rawValue: 2)?.images
        case 3: annotationView?.image = FaceImages(rawValue: 3)?.images
        case 4: annotationView?.image = FaceImages(rawValue: 4)?.images
        default: break
        }

        return annotationView
    }

}


// MARK: - Extension: CLLocationManagerDelegate

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            LocationManager.shared.currentPosition = (coordinate.latitude, coordinate.longitude)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
            myView.mapView.setRegion(region, animated: true)
        }
        
        myView.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        view.makeToast("위치 이동에 실패")
    }
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
        LocationManager.shared.currentPosition = (myView.mapView.region.center.latitude, myView.mapView.region.center.longitude)
        searchStudyMembers()
    }
    
}
