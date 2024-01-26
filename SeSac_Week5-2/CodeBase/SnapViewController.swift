//
//  SnapViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/26/24.
//

import UIKit
import SnapKit

class SnapViewController: UIViewController {

    let redView = UIView()
    let blackView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(redView)
        view.addSubview(blackView)
        
        redView.addSubview(blueView)
        
        redView.backgroundColor = .red
        blackView.backgroundColor = .black
        
        // 스냅킷 쓰니까 코드량이 어마어마하게 줄었다
        redView.snp.makeConstraints { make in
            // 이들은 다 똑같은 의미의 사용법
            // 편한대로 씁시다.
            // 1.
            make.width.equalTo(200)
            make.height.equalTo(200)
            // 2.
            // make.width.height.equalTo(200)
            //3.
            // make.size.equalTo(200)
            
            // 1.
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            // 2.
            // make.centerX.centerY.equalTo(view)
        }
        
        blackView.snp.makeConstraints { make in
            // 1.
            //make.leading.equalTo(view.safeAreaLayoutGuide)
            //make.trailing.equalTo(view.safeAreaLayoutGuide)
            // 2.
            //make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            // 3. 수평
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            // 4. 수직
            //make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            
            // >=
            make.height.greaterThanOrEqualTo(100)
            // <=
            //make.height.lessThanOrEqualTo(200)
        }
        
        //blueView : redView 내부에 있는거라 redView 위의 계층인 블랙뷰는 계속 보이는거임
        blueView.backgroundColor = .blue
        blueView.snp.makeConstraints { make in
            // 수평 사이즈
            //make.horizontalEdges.equalTo(redView)
            // 수직 사이즈
            //make.verticalEdges.equalTo(redView)
            
            // 2. 이런 방법도
            //make.leading.trailing.top.bottom.equalTo(redView)
            // 3. 아예 모든 크기를 한번에 지정하는 것도 가능
            //make.edges.equalTo(view.safeAreaLayoutGuide)
            // 4. 내 모든 사이즈(4가지 모서리)를 부모뷰를 기준으로 따라가기, 이런거도 되네
            make.edges.equalToSuperview().inset(-20)
            // .inset(20) 무조건 안쪽으로 빼지는 개념 // .offset(20) : 무조건 더하는 개념
            // 그럼 반대로 .inset(-20) or .offset(-20) 이런거도 되겠지요?
            
            // left, right 와 leading, trailing 의 차이는 (RTL 의 특성때문입니다.)
            // 아랍쪽은 리딩이 오른쪽 기준이 되버려서 그쪽으로 시스템을 바꿔버리면 모든 뷰가 우리랑은 정 반대로 나오게됨 ㅋㅋㅋㅋㅋ
        }
    }
    

}
