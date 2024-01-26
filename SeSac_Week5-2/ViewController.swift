//
//  ViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/23/24.
//

import UIKit
import CoreLocation // 1. 위치 임포트
import MapKit

/*
 Enum
 - case
 - rawValue
 - CaseIterable
 - Unfrozen Enum -> @unKnown : 모든 케이스를 처리했음에도 불구하고, 추후에 멤버가 추가 될 가능성이 있는 열거형 (다른 케이스 또 생기면 그거 처리해줘야 함)
 - 그렇다면, frozen Enum 도 존재한다. -> @frozen : 옵셔널은 옵셔널인 것과 아닌 것 2가지만 있으므로 frozen Enum 이다.
 
 TMI: 프로퍼티/메서드/클래스 앞에 붙어서 특정 기능을 수행하게끔 도와주는 것 -> @ (Swift Attribute)
 - @unknow
 - @frozen
 - @available vs #available
 - @outlet
 - @action
 - @discardableResult : 리턴 안해도 되는거
 - @escaping
 - @objc
 */


class ViewController: UIViewController {
    
    @IBOutlet var nasaImageView: UIImageView!
    @IBOutlet var mapView: MKMapView!
    
    // 2. 위치 매니저 생성: 위치에 대한 대부분 담당
    let locationManager = CLLocationManager() // CLLocationManager 인스턴스를 만드는 순간 자동으로 한번 실행된다고 함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4. 위치 프로토콜 연결
        locationManager.delegate = self
        
        // 근데 navi, tabbar 이런게 달려있는 순간 실행이 안된다..
        // 그래서 중복되게 실행되는거 같아도 일단 화면에 띄워질때 실행되도록 하자
        checkDeviceLocationAuthorization()
        
        print("A")
        print("B")
        test()
        print("C")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        showLocationSettingAlert()
    }
    
    func test() {
        print("1")
        print("2")
    }
    
    @IBAction func didImageBtnTapped(_ sender: UIButton) {
        
        // 1. 우리가 codable 을 이용할 떄
        // String -> Data -> Struct
        // 2. 직접 URL을 가져와서 이미지로 바꿔줄 때
        // URL -> Data -> UIImage
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2401/SeagullToCalifornia_Symon_2000.jpg")!
        
        // 다른 알바생 소환
        DispatchQueue.global().async {
            do {
                // UI Freezing : 코드의 동작시간이 너무 길어져서 다른 UI 들을 사용하지 못하는 현상
                let data = try Data(contentsOf: url)
                
                // 일반적으로 뷰와 UI 를 동작하는 친구는 메인 쓰레드라고 한다.
                DispatchQueue.main.async {
                    self.nasaImageView.image = UIImage(data: data)
                }
            } catch {
                DispatchQueue.main.async {
                    self.nasaImageView.image = UIImage(systemName: "star.fill")
                }
            }
        }
        
        
    }
    
}

extension ViewController {
    
    // 1) 사용자에게 권한 요청을 하기 위해, iOS 위치 서비스 활성화 여부 체크
    // 즉, 아이폰의 설정 -> 위치 탭에 활성화가 되어있는지 아닌지 확인하는거임
    func checkDeviceLocationAuthorization() {
        
        // 위치권한은 메인쓰레드가 하면 안된대서 다른 쓰레드한테 시킴
        DispatchQueue.global().async {
            // 타입 메서드라서 인스턴스 메서드로는 접근을 못해서 만든 인스턴스 대신에 이걸로 사용함
            if CLLocationManager.locationServicesEnabled() {
                
                // 현재 사용자의 위치 권한 상태 확인 - 허용, 거부, 한번만 허용, 앱 사용중에만 허용 등 다양한 케이스가 있어서 체크 필요
                let authorization: CLAuthorizationStatus
                
                // 아이폰 버전마다 locationManager 가 다르게 존재
                if #available(iOS 14.0, *) {
                    // 14 이상일때
                    authorization = self.locationManager.authorizationStatus
                } else {
                    // 14 미만일때
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    // 이제 상태에 맞게 각 상태를 대응해주는 함수를 locationManager 를 넣어서 실행해주면 됨
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                // Alert 띄워서 설정으로 보내버리기
                print("위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없어요.")
            }
        }
        
    }
    
    // 2) 사용자 위치 권한 상태 확인 후, 앱에 대한 권한 요청
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined: // 아직 권한 결정을 한번도 안해본 상태 => 권한 문구 띄우기
            print("notDetermined")
            
            // 얼마나 자주 위치 업데이트를 해줄 것인가?
            // 단위를 기준으로 어떻게 가져올지 핸들링 가능
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // best 는 각 플랫폼마다 애플이 지정한 위치마다 업데이트하도록 함
            
            // Info.plist 에 있는 WhenInUse 권한을 꺼내서 그 문구를 사용
            locationManager.requestWhenInUseAuthorization()
            
        case .denied: // 사용자가 허용 안함을 체크 했을 때
            print("denied")
            showLocationSettingAlert()
        case .authorizedWhenInUse: // 앱을 사용하는 동안 허용
            print("authorizedWhenInUse")
            // didUpdateLocation 메서드 실행
            locationManager.startUpdatingLocation()
            
        default:
            print("Error")
        }
        
        //        switch status {
        //        case .notDetermined: // 아직 권한 결정을 한번도 안해본 상태 => 권한 문구 띄우기
        //            print("notDetermined")
        //        case .restricted: // 자녀 보호 기능 등으로 앱의 위치 권한 상태를 변경할 수 없는 경우 (굉장히 드문 케이스)
        //            print("restricted")
        //        case .denied: // 사용자가 허용 안함을 체크 했을 때
        //            print("denied")
        //        case .authorizedAlways: // 항상 허용. 앱 사용 여부랑 상관없이 위치 이벤트 수신 가능
        //            // 사용자가 앱을 사용하는 동안 허용하고 어느 정도 시점이 지난 후에 사용 가능
        //            // (애플에서는 유저 입장에서 굉장히 크리티컬하다고 생각함)
        //            print("authorizedAlways")
        //        case .authorizedWhenInUse: // 앱을 사용하는 동안 허용
        //            print("authorizedWhenInUse")
        //        case .authorized: // 옛날꺼 지금 안씀 (deprecated)
        //            print("authorized")
        //        @unknown default: // 미래에 새로운 권한이 생길 수 있으니 미리 만들어둔다.
        //            <#fatalError()#>
        //        default:
        //            print("Error")
        //        }
    }
    
    // 3) 설정으로 이동 Alert
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호' 에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            // 아이폰 설정으로 이동 (앱 내에서 바로 권한 설정을 바꾸는건 안됨, 설정페이지로 보내버려야 함)
            // 설정 화면에 갈지, 앱 상세 페이지까지 유도해줄지는 몰라요,,
            
            // 그냥 설정화면까지만 가는 경우,,
            // 한번도 직접 설정에서 사용자가 앱 설정 상세 페이지까지 들어간적이 없다면
            // 막 다운 받은 앱이라서 설정 상세 페이지까지 갈 준비가 시스템적으로 안되어 있거나
            
            // 설정화면으로 보내버리기
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            } else {
                print("설정으로 직접 가주세요")
            }
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    // 1. 설정에서 위치 서비스 체크
    // 2. 앱에 대한 사용자 권한 상태 체크
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        // 얘는 위도, 경도에 대한 값이 들어있음
        //        CLLocationCoordinate2D(latitude: , longitude: )
        
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        
        // 맵뷰에 얻어온 region 값 띄우기
        mapView.setRegion(region, animated: true)
    }
}

// 3. 위치 프로토콜
extension ViewController: CLLocationManagerDelegate {
    
    // 5. 사용자의 위치 설정이 업데이트 된 경우 실행
    // didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        // 위치 설정이 업데이트 됐는데, 위도 경도 값이 있다면 가져옴
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            print(coordinate.latitude)
            print(coordinate.longitude)
            
            // 위도와 경도 값을 가져왔다면, 여기서 날씨 API 같은걸 호출하게 됨
            setRegionAndAnnotation(center: coordinate)
        }
        
        // 위치 정보를 더이상 안가져오는 함수
        locationManager.stopUpdatingLocation()
    }
    
    // 6. 사용자의 위치를 가지고 오지 못한 경우
    // didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    // 4) 사용자 권한 상태가 바뀔 때를 알려줌
    // 거부했다가 설정에서 허용으로 바꾸거나,
    // notDetermined에서 허용을 했거나,
    // 허용해서 위치를 갖고오는 도중에 다시 설정에서 거부를 하거나 등등등...
    // iOS14 이상부터 가능...
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        
        // 값이 변동됐으면 어떻게 돼있을지 모르니까 다시 맨 처음부터 확인하고, 그에 맞게 실행함
        checkDeviceLocationAuthorization()
    }
    
    // 4) 사용자 권한 상태가 바뀔 때를 알려줌
    // iOS14 미만,,
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    // 7. Info 확인 . Privacy - Location When In Use Usage Description
}
