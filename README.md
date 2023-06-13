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
- **Firebase Auth**를 통해 핸드폰 번호 인증을 이용한 회원가입 로직 구현
- 유저가 개인정보 입력할 때, UITextField의 canPerformAction을 이용하여 **붙여넣기 방지** 구현
- 로그인시, firebase의 **ID Token을 확인 후, 만료시 재등록** 처리
- 로그인 시점에 서버의 유저 fcmTocken과 앱에 저장된 **fcmToken 비교 및 필요시 교체** 기능 구현
- 통신 에러 발생 시, **AuthErrorCode 및 CustomError**를 이용한 **Error Handling**
- Custom Annotation에 ID를 할당하여 불필요한 **이미지 재사용 방지** 및 지도에 상대방 이미지 구현
- 유저가 Map View의 화면 이동시, 0.8초 간격으로 User Interaction을 막아 **과도한 서버호출** 방지
- CompositionalLayout, DiffableDataSource로 생성한 Collection View와 **preferredLayoutAttributesFitting**, **estimated** 및 **intrinsicSize**를 활용하여 Self-Sizing View 구현
- 매칭 대기 상태 중, 매 5초마다 API 호출하여 내 매칭 상태 체크 기능 구현
- **WebSocket** 통신을 통한 실시간 채팅 내용을 **Realm**에 저장
- 채팅화면 진입 시, 마지막 채팅 일자를 서버에 송신 후 채팅 데이터 불러옴으로써 **과도한 서버호출 방지**
- **WebSocket** 통신을 통한 실시간 채팅 내용을 **Realm**에 저장채팅화면 진입 시, 마지막 채팅 일자를 서버에 송신 후 채팅 데이터 불러옴으로써 과도한 서버호출 방지
- 채팅화면에서 더보기 버튼을 탭했을 때, **CGAffineTransform**을 이용하여 상단에서 내려오는 **View의 animation** 구현
- 채팅입력 textView가 길어질 경우, **SnapKit**의 **Constraint Class**를 이용하여 Layout 업데이트하여 텍스트의 길이에 맞게 View Self-Sizing 구현
- StoreKit을 **Singleton**으로 활용하여 **InAppPurchase** 기능 구현
- 제품 구매 시, Receipt를 서버에 송신하여 **영수증 검증** 후, 검증 성공 및 실패에 따른 로직 구현
- 제품 구매 중, 투명한 ViewController를 present하여 사용자의 **event입력 일시 중단 기능** 추가
<br/>

## 프로젝트 진행기간
- 22\. 11. 17. ~ 22. 12. 18 (약 1개월)
<br/>

## 프로젝트에 사용한 기술스택
| 카테고리 | 내용 |
| :---: | ----- |
| 개발 언어 | Swift | 
| 디자인 | AutoLayout, Code Based UI |
| 디자인 패턴 | MVC, MVVM, Singleton, Input/OutPut, Delegate |
| 애플 프레임워크 | UIKit, StoreKit, MapKit, CoreLocation |
| 네트워크 | Alamofire |
| 의존성 관리도구 | Swift Pakage Manager |
| 오픈 라이브러리 | SnapKit, Socket.I.O, RxSwift, FirebaseAuth, Realm, RxDataSource, RxRealm, |
|  |  FirebaseMessaging, Toast |
| 기타 | DispatchQueue, CustomView, CompositionalLayout, DiffableDataSource, @PropertyWrapper, |
|  | CGAffineTransform, CustomFont, NotificationCenter, NSPredicate |
| 소스관리 | Git |
<br/>

## 트러블슈팅
<p align="center">
<img src="https://user-images.githubusercontent.com/105812328/209336576-83b3a19a-34ec-4db0-8bb3-02d727593a39.PNG" width="30%" height="40%">
<img src="https://user-images.githubusercontent.com/105812328/209336585-d9e48267-a657-4984-96dc-ef98d6ef4375.PNG" width="30%" height="40%">
</p>

- **CompositionalLayout을 이용한 Collection View의 데이터 갱신 시, Layout이 깨지는 문제**   
  * 스터디 목록(각각의 Cell)을 등록하는 화면에서 self-sizing을 활용하여 그린 뷰에서 Collection View의 item 배열에 데이터를 추가 후, snapshot을 DataSource에 apply할 때 각 item의 레이아웃이 깨지면서 겹쳐 그려지는 문제가 발생

### 해결 방안   
> UICollectionViewCell 내부에서 preferredLayoutAttributesFitting 메서드를 오버라이드하고 Label의 intrinsicContentSize와 Label의 Leading 및 Trailing insetSize를 활용.  
> 데이터를 추가 후, snapshot으로 뷰 갱신했을 때, 해당 메서드가 호출되며 지정해놓은 Size에 맞춰 Layout이 깨지지 않도록 구현.
```swift
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: sections == 0 ? studyLabel.intrinsicContentSize.width + 36 : studyLabel.intrinsicContentSize.width + 60, height: 50)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
```
<br/>

<p align="center">
<img src="https://user-images.githubusercontent.com/105812328/209213630-ee0e88e4-a20b-4dcd-860a-1a40510029fb.PNG" width="30%" height="40%">
<img src="https://user-images.githubusercontent.com/105812328/209337827-1263f41e-be44-4359-b537-79129f7ebf68.PNG" width="30%" height="40%">
</p>

- **뷰 컨트롤러가 아닌 뷰에서 새로운 뷰 컨트롤러를 present해야 하는 문제**   
  * UICollectionReusableView에 생성한 버튼의 tap action을 통해 Custom Alert View Controller를 호출해야 하는 상황에 직면.

### 해결 방안   
> UIApplication을 Extension하여 현재 뷰의 최상단 뷰컨트롤러를 호출하는 메서드를 만들고 호출.
> keyWindow?.rootViewController를 이용.
```swift
final class HeaderImageCollectionReusableView: UICollectionReusableView {
    @objc func buttonTapped() {
        let vc = CustomAlertViewController()
        let currentVC = UIApplication.getTopMostViewController()
        vc.modalPresentationStyle = .overFullScreen
        currentVC?.present(vc, animated: true)
    }
}

extension UIApplication {
    class func getTopMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .filter { $0.isKeyWindow }.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
}
```
<br/>

<p align="center">
<img src="https://user-images.githubusercontent.com/105812328/209213618-50f843a6-1eb8-449a-b4ef-abf2a8fa9048.PNG" width="30%" height="40%">
<img src="https://user-images.githubusercontent.com/105812328/209357211-7afe3a2a-c7c2-43c5-879b-87c571ba5b25.PNG" width="30%" height="40%">
</p>

- **재사용된 뷰의 분기처리 과정에서 발생한 문제**   
  * Segmented Control을 커스텀하면서 뷰컨트롤러 두 개에 Enum을 이용하여 하나의 뷰를 재사용.
  * 뷰 내부에 Enum Property를 만들고 이를 활용하여 Collection View의 Layout을 분기처리.
  * 하지만 뷰가 생성되는 시점에 대한 이해 부족으로 오류 발생(하나의 케이스만 계속 적용).

### 해결 방안   
> 뷰 convenience init의 parameter로 enum case를 전달.   
> 전달받은 parameter를 이용하여 collection view의 레이아웃과 dataSource 및 snapshot을 세팅.
```swift
final class ShopSharedView: BaseView {
    convenience init(state: ShopViewSelected) {
        self.init()
        configureHierarchy(state: state)
        configureDataSource(state: state)
    }
}

extension ShopSharedView {
    private func configureHierarchy(state: ShopViewSelected) {
        switch state {
        case .face:
            collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout(state: .face))
        case .background:
            collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout(state: .background))
        }
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
        }
    }
    
    func configureDataSource(state: ShopViewSelected) {
        switch state {
        case .face:
            let cellRegistration = UICollectionView.CellRegistration<FaceCollectionViewCell, FaceImages> { (cell, indexPath, item) in
                cell.ConfigureCells(item: item)
            }
            
            faceDataSource = UICollectionViewDiffableDataSource<Int, FaceImages>(collectionView: collectionView) {
                (collectionView, indexPath, item) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
            updateUI(state: state)
            
        case .background:
            let cellRegistration = UICollectionView.CellRegistration<BackgroundCollectionViewCell, BackgroundImages> { (cell, indexPath, item) in
                cell.ConfigureCells(item: item)
            }
            
            backgroundDataSource = UICollectionViewDiffableDataSource<Int, BackgroundImages>(collectionView: collectionView) {
                (collectionView, indexPath, item) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
            updateUI(state: state)
        }
    }
}
```
<br/>

## 회고   
[새싹스터디에 대한 상세 회고록 보기](https://jjhios.tistory.com/18)   
- **상기한 기술을 사용한 이유**   
  - Alarmofire & URLRequestConvertible
    > 새싹스터디 프로젝트에서는 네트워크 통신이 많아, 상황별로 네트워크 API case를 구분하는 것이 추후 코드 리팩토링 및 사용성 측면에서 좋다고 판단되어 사용하게 되었습니다.
  - RxDataSource & RxRealm
    > 채팅화면을 구현할 때 사용해보았습니다. 실시간 웹소켓통신을 구현하다보니, reloadData를 해야하는 지점이 많아 해당 라이브러리를 이용하여 Realm의 데이터가 변경될 때마다 반영되도록 구현해보았습니다.
  - MVVM & Input/Output패턴
    > 코드를 기능별로 구별해보기 위하여 ViewModel 생성 후, Input/Output패턴을 이용하여 ViewModel내부에서 로직을 구현하였습니다.
<br/>

- **느낀 점**    
  &nbsp;새싹스터디를 하면서 느꼈던 점은 사소한 지점에서도 어려움을 느꼈습니다. 예를 들면, imageView에 button을 addSubview를 한 후, addTarget으로 tap Action을 설정했는데, 작동이 되지 않아 알고보니 imageView는 기본적으로 유저와의 인터렉션이 막혀있다는 것이 있었습니다. 이처럼 한정된 기간 내에 새로운 기술을 이용하여 구현하려고 하다보니 기본적인 부분을 많이 놓치는 것 같다는 것을 느끼게 되었습니다.
  <br/>
  <br/>
&nbsp;반면, 프로젝트를 진행하면서 주차별로 개발일지([새싹스터디 개발일지 상세보기](https://fluffy-comte-126.notion.site/9fbdc10d4244491aa8c281501ce9dc78?v=1b644af5941247ac8d9b1fe0f16a410a))를 작성하였는데, 이 덕분에 프로젝트 도중에는 계획에 맞춰서 개발을 진행할 수 있었습니다. 프로젝트가 종료된 뒤에는 일지를 보면서 개선해야할 지점을 점검할 수 있어서 많은 도움이 되었습니다. 그리고 git commit 내용도 기능 구현이나 파일의 추가 및 삭제, 객체의 생성 등 기준을 세분화해서 작성해보았습니다. 돌아보니 프로젝트의 규모보다 너무 많은 commit이 생성된 것 같지만 언제 어떤 작업을 수행하였는지 세부적으로 확인할 수 있어서 좋은 경험이었습니다.
  <br/>
  <br/>
&nbsp;추후에는 프로젝트 진행시, 개발일지를 통해 좀 더 자세하게 문제 발생했던 지점을 기록하고 오류가 났던 부분을 사진 및 영상과 코드를 같이 남길 예정입니다. 이와 더불어 애플 프레임워크 및 기본 문법과 새로운 기술의 비중을 약 7:3정도로 정하여 공부하면서 발전해나가도록 하겠습니다.
<br/>
