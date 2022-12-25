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
- CompositionalLayout, DiffableDataSource로 생성한 Collection View와 esimate, intrinsicSize를 활용하여    
  Self-Sizing 스터디 화면 구성
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
| 의존성 관리도구 | Swift Pakage Manager |
| 디자인 | AutoLayout |
| 디자인 패턴 | Delegate, Input/OutPut, MVC, MVVM, Repository, Singleton |
| 오픈 라이브러리 | Alarmofire, FirebaseAuth, FirebaseMessaging, Realm, RxRealm, RxSwift, RxDataSource, |
|  | SnapKit, Socket.I.O, Toast |
| 기타 | ATSSettings, AttributeContainer, AttributedString, @available, Calendar, CaseIterable, |
|  | Codable, CompositionalLayout, CustomFont, CustomView, Date, DateFormatter, |
|  | DiffableDataSource, DispatchQueue, Hashable, Locale, NumberFormatter, |
|  | NSMutableParagraphStyle, NSPredicate, @PropertyWrapper, Timer, TimeZone, |
|  | NotificationCenter, UserDefaults, UUID |
| 기타 툴 | Confluence, Jandi, Postman, Swagger |
| 소스관리 | Git, GitHub |
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
- **상기한 기술을 사용한 이유**   
ㅁㅇㄴ리ㅏㅁㄴㅇ림ㄴㅇ륌ㄴ우라ㅣㅁㄴㅇㄹ
<br/>

- **느낀 점**   
ㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ
<br/>
