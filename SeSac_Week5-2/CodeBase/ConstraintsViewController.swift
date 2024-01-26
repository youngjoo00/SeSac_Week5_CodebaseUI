//
//  ConstraintsViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/26/24.
//

import UIKit
// NSLayoutConstraints -> NSLayoutAnchor
// isActive
class ConstraintsViewController: UIViewController {

    // 1. view객체 인스턴스 생성
    let nameTextField = UITextField()
    let okBtn = UIButton()
    let helpBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 0.
        view.backgroundColor = .white
        
        // 2. addSubView
        view.addSubview(nameTextField)
        view.addSubview(okBtn)
        view.addSubview(helpBtn)
        
        // 3. 오토리사이징 기능 끄기
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        okBtn.translatesAutoresizingMaskIntoConstraints = false
        helpBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // 4.
        nameTextField.backgroundColor = .yellow
        nameTextField.placeholder = "닉네임을 입력해주세요"
        
        okBtn.setTitle("확인", for: .normal)
        okBtn.backgroundColor = .red
        
        helpBtn.setTitle("도움말", for: .normal)
        helpBtn.backgroundColor = .red
        
        // 5.
        NSLayoutConstraint(item: nameTextField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 24).isActive = true // isActive 를 작동해야함
        
        // item : 누가, attribute: 누구의 어디
        NSLayoutConstraint(item: nameTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 24).isActive = true
        
        NSLayoutConstraint(item: nameTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -24).isActive = true
        
        NSLayoutConstraint(item: nameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50).isActive = true
        
        
        //okBtn
        let leading = NSLayoutConstraint(item: okBtn, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 24)
        
        let traling = NSLayoutConstraint(item: okBtn, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -24)
        
        let top = NSLayoutConstraint(item: okBtn, attribute: .top, relatedBy: .equal, toItem: nameTextField, attribute: .bottom, multiplier: 1, constant: 24)
        
        let height = NSLayoutConstraint(item: okBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        
        // 이게 isActive 대신 한번에 해결하기 위해 나옴
        view.addConstraints([leading, traling, top, height])
        
        //anchor
        NSLayoutConstraint.activate([
            helpBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helpBtn.widthAnchor.constraint(equalToConstant: 300),
            helpBtn.heightAnchor.constraint(equalToConstant: 50),
            // bottom 을 설정할때는 꼭 view.safeArea 기준으로 잡자
            helpBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
