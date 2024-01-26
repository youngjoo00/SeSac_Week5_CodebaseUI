//
//  HomeViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/26/24.
//

import UIKit
import SnapKit
import Then

class HomeViewController: UIViewController {
    
    let mainImageView = UIImageView()
    let popularContentLabel = UILabel()
    
    // 이렇게 위에서 한번에 정의를 하기도 하고,
    // 다른 뷰처럼 뷰 인스턴스만 만들어놓고 아래에서 속성을 설정해주기도 하는데
    // 뭐가 더 좋은건지는 모르겠습니다.
    let popularStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    } // then 쓰면 확실히 코드가 더 깔끔해진다.
    
    // then 라이브러리 안쓰고 한번에 정의할때
//    let popularStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.spacing = 12
//        stackView.distribution = .fillEqually
//        return stackView
//    }()
    
    let popularFirstImageView = UIImageView()
    let popularSecondImageView = UIImageView()
    let popularThirdImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
}

extension HomeViewController {
    
    func configureHierarchy() {
        view.addSubview(mainImageView)
        
        [mainImageView,
         popularContentLabel,
         popularStackView,
        ].forEach { view.addSubview($0) }
        
        [popularFirstImageView,
         popularSecondImageView,
         popularThirdImageView,
        ].forEach { popularStackView.addArrangedSubview($0) }
        // StackView 에 추가할때는 addArrangedSubview 를 써야함
    }
    
    func configureView() {
        view.backgroundColor = .black
        self.navigationItem.title = "고래밥님"
        
        popularContentLabel.text = "지금 뜨는 콘텐츠"
        popularContentLabel.textColor = .white
        popularContentLabel.font = .boldSystemFont(ofSize: 18)
        
        configureImageView(mainImageView, name: "노량", cornerRadius: 16)
        configureImageView(popularFirstImageView, name: "밀수", cornerRadius: 8)
        configureImageView(popularSecondImageView, name: "더퍼스트슬램덩크", cornerRadius: 8)
        configureImageView(popularThirdImageView, name: "범죄도시3", cornerRadius: 8)
    }
    
    func configureConstraints() {
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            
            // .dividedBy() : 어떤 뷰를 기준으로 나누기
            // .multipliedBy() : 어떤 뷰를 기준으로 곱하기
            make.bottom.equalTo(popularContentLabel.snp.top).offset(-8)
        }
        
        popularContentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(popularStackView.snp.top).offset(-8)
            make.leading.equalTo(16)
            make.height.equalTo(20)
        }
        
        popularStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            
            // 탭바가 있을때는 safeArea 기준으로 잡아야한다.
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            
            make.height.equalTo(view.snp.height).multipliedBy(0.2)
        }
    }
    
    func configureImageView(_ imageView: UIImageView, name: String, cornerRadius: CGFloat) {
        imageView.image = UIImage(named: name)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = cornerRadius
    }
}

#Preview {
    HomeViewController()
}
