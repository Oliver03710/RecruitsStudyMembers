# 새싹스터디

- **앱 이미지**   
<p align="left">
<img src="https://user-images.githubusercontent.com/105812328/209213584-44d1f0aa-2fde-45b2-8aa9-c15c30b24fbe.PNG" width="15%" height="30%">
<img src="https://user-images.githubusercontent.com/105812328/209213618-50f843a6-1eb8-449a-b4ef-abf2a8fa9048.PNG" width="15%" height="30%">
<img src="https://user-images.githubusercontent.com/105812328/209213622-a6f5d20b-2d6a-4a72-8478-ff8d806ac25a.PNG" width="15%" height="30%">
<img src="https://user-images.githubusercontent.com/105812328/209213626-6eadaeef-0730-46f0-bd34-b9cbcf70dff6.PNG" width="15%" height="30%">
<img src="https://user-images.githubusercontent.com/105812328/209213630-ee0e88e4-a20b-4dcd-860a-1a40510029fb.PNG" width="15%" height="30%">
<img src="https://user-images.githubusercontent.com/105812328/209213644-b72dd953-675e-4aed-b053-193ea0ac5521.PNG" width="15%" height="30%">
</p>
<br/> 

## 앱 소개
- 원하는 스터디를 등록 후, 지도에서 스터디 멤버를 찾아 연결시켜주는 앱   
<br/>

## 앱의 주요 기능
- On Boarding 화면을 이용하여 앱의 사용방법에 대해 설명
- Firebase Auth를 통해 핸드폰 번호 인증을 이용한 회원가입 로직 구현
- 이메일 및 닉네임 등 개인정보 입력시 정규식으로 Validation 분기 처리 구현
- MapKit으로 이동 시, 유저에게 위치 권한 요청하여 유저의 Current Location 호출
- 웹소켓 통신으로 매칭된 상대방과의 실시간 채팅 기능 구현
- CompositionalLayout, DiffableDataSource로 생성한 Collection View와 esimate, intrinsicSize를 활용하여 Self-Sizing 스터디 화면 구성
- FirebaseMessaging을 이용한 Push 알림 구현
- StoreKit을 Singleton으로 활용하여 InAppPurchase 기능 구현
<br/>

## 프로젝트 진행기간
- 22\. 11. 17. ~ 22. 12. 18 (약 1개월)
<br/>

## 프로젝트에 사용한 기술스택
| 카테고리 | 내용 |
| ----- | ----- |
| 개발 언어 | Swift | 
| 애플 프레임워크 | CoreLocation, Foundation, MapKit, StoreKit, UIKit |
| 의존성 관리 도구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Swift Pakage Manager |
| 디자인 | AutoLayout |
| 디자인 패턴 | Delegate, Input/OutPut, MVC, MVVM, Repository, Singleton |
| 오픈 라이브러리 | Alarmofire, FirebaseAuth, FirebaseMessaging, Realm, RxRealm, RxSwift, RxDataSource, SnapKit, |
|  | Socket.I.O, Toast |
| 기타 | ATSSettings, AttributeContainer, AttributedString, @available, Calendar, CaseIterable, Codable, |
|  | CompositionalLayout, CustomFont, CustomView, Date, DateFormatter, DiffableDataSource, |
|  | DispatchQueue, Hashable, Locale, NumberFormatter, NSMutableParagraphStyle, |
|  | NSPredicate, @PropertyWrapper, Timer, TimeZone, NotificationCenter, UserDefaults, UUID |
| 기타 툴 | Confluence, Jandi, Postman, Swagger |
| 소스관리 | Git, GitHub |
<br/>

## 트러블슈팅
<p align="center">
<img src="https://user-images.githubusercontent.com/105812328/208724532-a9bc7d4d-e903-4100-8fa1-e9c18740f298.PNG" width="30%" height="40%">
</p>

- 커스텀 어노테이션 이미지의 재사용 문제
1~50까지의 Int값을 가진 이미지를 어노테이션을 생성하며 해당 목적지 순번에 맞게 mapView에 AddOverlay했지만, mapView의 region을 이동시켰다가 다시 어노테이션 있는 곳으로 region을 이동시킬 경우, 모두 같은 Int값을 가지는 이미지로 교체되는 문제 발생

<br/>

\-> 커스텀 어노테이션을 만들고 각 이미지마다 Int타입의 ID를 생성, 해당 ID마다 같은 Int값을 가지는 이미지 할당
```swift
// 커스텀 어노테이션 생성
final class Annotation: MKPointAnnotation {
    var identifier: Int
    
    init(_ identifier: Int) {
        self.identifier = identifier
    }
}

// 뷰컨트롤러의 어노테이션 생성하는 부분에서 ID에 맞는 이미지를 지정 및 생성
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "\(annotation.identifier)")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "\(annotation.identifier)")
        } else {
            annotationView?.annotation = annotation
        }
        let currentTrip = TripHistoryRepository.standard.fetchTrips(.current)
        
        viewModel.isExecutedFunc(identifier: annotation.identifier, taskOrder: currentTrip[0].trips.count - 1, annotationView: annotationView, annotation: annotation)

        return annotationView
    }
```
<br/>

- 경로를 계산하고 배열에 담는 과정에서 배열의 순번이 꼬여 mapView에 addOverlay했을 때, 목적지 간의 경로가 뒤엉키는 문제
<br/>

\-> 경로를 딕셔너리 타입으로 변경 후, Key값에 목적지 순번을, Value값에 경로를 배치하여 맵뷰에 addOverlay시 경로 순서가 꼬이지 않도록 수정
```swift
func createPath(_ mapView: MKMapView, sourceLat: CLLocationDegrees, sourceLon: CLLocationDegrees, destinationLat: CLLocationDegrees, destinationLon: CLLocationDegrees, turn: Int, status: TripStatus) {
	    // 여행 경로를 계산
        let direction = MKDirections(request: directionRequest)
        direction.calculate { response, error in
            guard let response = response else {
                if let error = error {
                    print("Error Found: \(error.localizedDescription)")
                }
                return
            }
            
			// 계산한 여행 경로를 경로를 관리하는 딕셔너리에 업데이트
            switch status {
            case .current:
                self.routes.updateValue(response.routes[0], forKey: turn)
            case .past:
                self.historyRoutes.updateValue(response.routes[0], forKey: turn)
            }
        }
    }
```
<br/>

- 배열을 가지고 있는 Realm 데이터를 json으로 변환하여 데이터 백업 및 복구 기능 구현 문제
Realm Object를 json으로 Encoding하여 외부로 Export할 때는 Realm의 List타입을 Array나 Dictionary처럼 애플 Framework에 있는 Collection타입으로 변경하고 json으로 Encoding해야 하는 것으로 잘못이해
<br/>

\-> superEncoder 및 nestedContainer 키워드를 사용하여 json으로 내보내고 복구하는 기능 구현
```swift
    // 데이터를 json 인코딩해서 외부로 내보낼 때 superEncoder 활용
    func encode(to encoder: Encoder) throws {

		// superEncoder를 통해 배열을 만들어주고 내부에 데이터 삽입
        let tripsContainer = container.superEncoder(forKey: .trips)
        try trips.encode(to: tripsContainer)
    }
    
	// json으로 저장한 데이터를 불러올 때 nestedContainer 활용
    required convenience init(from decoder: Decoder) throws {
    
		// nestedUnkeyedContainer로 배열 데이터에 접근
        var companiesContainer = try container.nestedUnkeyedContainer(forKey: .companions)
        
		// 반복문을 통해 json데이터 배열을 decoding한 후 빈 배열에 저장
        var compArray = [(companion: String, isBeingDeleted: Bool)]()
        while !companiesContainer.isAtEnd {
            let itemCountContainer = try companiesContainer.nestedContainer(keyedBy: CompanionsCodingKeys.self)
            let companion = try itemCountContainer.decode(String.self, forKey: .companion)
            let isBeingDeleted = try itemCountContainer.decode(Bool.self, forKey: .isBeingDeleted)
            compArray.append((companion, isBeingDeleted))
        }
        
		// decoding한 데이터를 저장하려는 Realm Object 타입으로 변환하여 저장
        compArray.forEach {
            self.companions.append(Companions(companion: $0.companion, isbeingDeleted: $0.isBeingDeleted))
        }
    }
```
<br/>

<p align="center">
<img src="https://user-images.githubusercontent.com/105812328/208724532-a9bc7d4d-e903-4100-8fa1-e9c18740f298.PNG" width="30%" height="40%">
<img src="https://user-images.githubusercontent.com/105812328/208724779-4b7df0f0-8d82-441e-9638-7ce36d565c0f.PNG" width="30%" height="40%">
</p>

- 데이터 복구하는 과정에서 기존 데이터 삭제시, mapView에 add된 데이터 삭제 순서에 따른 오류    
더보기 탭에서 복구셀을 tap했을 때, 기존에 mapView에 올라간 overlay들을 모두 삭제하고 외부에 저장한 json 백업 파일을 덮어써야 했습니다.
이 과정에서 mapView 인스턴스를 전달하여 더보기 탭에서 mapView Overlay데이터를 삭제해야 하는데, 인스턴스를 성공적으로 전달하기 위해서는 반드시 맵뷰가 있는 뷰컨트롤러의 transition이 필요하여 복구기능이 부자연스럽게 진행되었습니다.
NotificationCenter를 활용해보았지만, 유저가 앱을 최초에 실행하고 바로 더보기 탭으로 이동할 경우 Notification Center에 인스턴스가 전달되지 않았습니다. 반드시 지도 탭을 클릭했을 때, 인스턴스가 전달하는 것을 확인했습니다.
<br/>

\-> Delegate와 PanModal 라이브러리를 활용하여 인스턴스를 전달하고 뷰를 transition할 때, safeArea 바깥쪽으로 Present하도록하여 뷰 컨트롤러가 화면에 보이지 않게 하면서 인스턴스를 전달하여 해결했습니다.
```swift
// Delegate패턴을 활용하여 mapView Instance 전달
protocol TransferMapViewDelegate: AnyObject {
    func passMapView(_ mapView: MKMapView)
}

final class MapViewController: BaseViewController {

		// Delegate패턴을 활용하여 mapView Instance 전달
		weak var delegate: TransferMapViewDelegate?

		override func configureUI() {
		// Delegate패턴을 활용하여 mapView Instance 전달
        delegate?.passMapView(self.mapView)
    }
}

// 복구시 MapViewController의 Present Setting
extension MapViewController: PanModalPresentable {

    // Present할 때 safeArea 안쪽으로 보이지 않도록 높이 조절
    var shortFormHeight: PanModalHeight {
        return .contentHeightIgnoringSafeArea(0)
    }

    var longFormHeight: PanModalHeight {
        return shortFormHeight
    }
}

extension BackupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertMessageWithCancel(title: "해당 데이터로 복구하시겠습니까?") {
            do {
                // '복구'셀을 클릭했을 때 MapViewController 생성 후, delegate 세팅 및 뷰컨트롤러 present
                let mv = MapViewController()
                mv.delegate = self
                self.presentPanModal(mv)
            } catch {
                print(error)
            }
        }
    }
}

// 전달받은 mapView Instance를 통해서 mapView Overlay 모두 삭제
extension BackupViewController: TransferMapViewDelegate {
    func passMapView(_ mapView: MKMapView) {
        LocationHelper.standard.removeAnnotations(mapView, status: .current)
        LocationHelper.standard.routes.removeAll()
        mapView.removeOverlays(mapView.overlays)
    }
}
```
<br/>

## 회고
- **상기한 기술을 사용한 이유**   
ㅁㅇㄴ리ㅏㅁㄴㅇ림ㄴㅇ륌ㄴ우라ㅣㅁㄴㅇㄹ
<br/>

- **느낀 점**   
ㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ
<br/>
