//
//  CodeViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/25/24.
//

import UIKit

// 1. 뷰 객체 프로퍼티 선언(클래스 인스턴스 생성) + addSubView
// 2. 크기와 위치 정의
// 3. 속성 설정
// AutoResizingMask
// - 부모뷰에 따라 자식뷰 크기 위치를 조정
// - AutoResizingMask 설정한 레이아웃들이 Constraints 형태로 변환
// - 이미 Constraints 가 설정된 상태이기 때문에, 이후에 제약 조건을 추가 수정하는 것이 불가능!
// AutoLayout
// NSLayoutConstraints
// - isActive
// - addConstraints
// NSLayoutAnchor

class CodeViewController: UIViewController {

    let emailTextField = UITextField()
    let redView = UIView()
    let blueView = UIView()
    let yellowView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 뷰는 원래 백그라운드 컬러를 지정해줘야함
        view.backgroundColor = .lightGray
        
        // 뷰에 서브뷰 띄우기
        view.addSubview(emailTextField)
        view.addSubview(blueView)
        view.addSubview(redView)
        
        blueView.addSubview(yellowView)
        
        print("CodeViewController ViewDidLoad")
        
        // 스크린의 가로크기에서 100을 빼면 자동으로 프레임을 잡아줌
        emailTextField.frame = CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 50)
        emailTextField.backgroundColor = .black
        emailTextField.keyboardType = .emailAddress
        emailTextField.placeholder = "이메일을 입력해주세요"
        emailTextField.borderStyle = .none
        
        redView.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        redView.backgroundColor = .red
        
        blueView.frame = CGRect(x: 200, y: 200, width: 150, height: 150)
        blueView.backgroundColor = .blue
        
        yellowView.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        yellowView.backgroundColor = .yellow
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
}
