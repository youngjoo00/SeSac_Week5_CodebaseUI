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
    
    let navTitleLabel = UILabel().then {
        $0.configureLabel(text: "고래밥님", textColor: .white, backgroundColor: .clear, font: .boldSystemFont(ofSize: 25), textAlignment: .center)
    }
    
    let mainImageView = UIImageView()
    let mainStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }
    
    let mainPlayBtn = UIButton()
    let mainLikeListBtn = UIButton()
    let mainContentLabel = UILabel()
    
    let popularContentLabel = UILabel()
    
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
    
    let top10ImageView = UIImageView()
    
    // 이런 고정적으로 정해진 콘텐츠가 있을 경우에는 뷰를 생성하면서 속성을 정의하는게 좋을듯 하다.
    let signatureImageView = UIImageView().then {
        $0.image = UIImage(named: "single-badge")
    }
    
    let popularSecondSubStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fillEqually
    }
    
    let newEpisodeSecondLabel = UILabel().then {
        $0.configureLabel(text: "새로운 에피소드", textColor: .white, backgroundColor: .red, font: .boldSystemFont(ofSize: 12), textAlignment: .center)
    }

    let nowPlaySecondLabel = UILabel().then {
        $0.configureLabel(text: "지금 시청하기", textColor: .black, backgroundColor: .white, font: .boldSystemFont(ofSize: 12), textAlignment: .center)
    }

    let newSeriesSecondLabel = UILabel().then {
        $0.configureLabel(text: "새로운 시리즈", textColor: .white, backgroundColor: .red, font: .boldSystemFont(ofSize: 12), textAlignment: .center)
        $0.isHidden = true
    }
    
    let popularThirdSubStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fillEqually
    }
    
    let newEpisodeThirdLabel = UILabel().then {
        $0.configureLabel(text: "새로운 에피소드", textColor: .white, backgroundColor: .red, font: .boldSystemFont(ofSize: 12), textAlignment: .center)
        $0.isHidden = true
    }

    let nowPlayThirdLabel = UILabel().then {
        $0.configureLabel(text: "지금 시청하기", textColor: .black, backgroundColor: .white, font: .boldSystemFont(ofSize: 12), textAlignment: .center)
        $0.isHidden = true
    }

    let newSeriesThirdLabel = UILabel().then {
        $0.configureLabel(text: "새로운 시리즈", textColor: .white, backgroundColor: .red, font: .boldSystemFont(ofSize: 12), textAlignment: .center)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
}

extension HomeViewController: ViewProtocol {
    
    func configureHierarchy() {
        view.addSubview(mainImageView)
        
        [mainImageView,
         popularContentLabel,
         popularStackView,
         mainStackView,
         mainContentLabel,
         top10ImageView,
         signatureImageView,
         popularSecondSubStackView,
         popularThirdSubStackView,
        ].forEach { view.addSubview($0) }
        
        [popularFirstImageView,
         popularSecondImageView,
         popularThirdImageView,
        ].forEach { popularStackView.addArrangedSubview($0) }
        // StackView 에 추가할때는 addArrangedSubview 를 써야함
        
        [mainPlayBtn,
         mainLikeListBtn,
        ].forEach { mainStackView.addArrangedSubview($0) }
        
        [newEpisodeSecondLabel,
         nowPlaySecondLabel,
         newSeriesSecondLabel,
        ].forEach { popularSecondSubStackView.addArrangedSubview($0) }
        
        [newEpisodeThirdLabel,
         nowPlayThirdLabel,
         newSeriesThirdLabel,
        ].forEach { popularThirdSubStackView.addArrangedSubview($0) }
    }
    
    func configureView() {
        view.backgroundColor = .black
        self.navigationItem.titleView = navTitleLabel
        
        popularContentLabel.text = "지금 뜨는 콘텐츠"
        popularContentLabel.textColor = .white
        popularContentLabel.font = .boldSystemFont(ofSize: 18)
        
        mainImageView.configureImageView(name: "노량", cornerRadius: 16)
        popularFirstImageView.configureImageView(name: "밀수", cornerRadius: 8)
        popularSecondImageView.configureImageView(name: "더퍼스트슬램덩크", cornerRadius: 8)
        popularThirdImageView.configureImageView(name: "범죄도시3", cornerRadius: 8)
        
        mainPlayBtn.setTitle("  재생", for: .normal)
        mainPlayBtn.setImage(UIImage(named: "play"), for: .normal)
        mainPlayBtn.backgroundColor = .white
        mainPlayBtn.tintColor = .black
        mainPlayBtn.setTitleColor(.black, for: .normal)
        mainPlayBtn.layer.cornerRadius = 4
        mainPlayBtn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        mainLikeListBtn.setTitle("  내가 찜한 리스트", for: .normal)
        mainLikeListBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        mainLikeListBtn.backgroundColor = .darkGray
        mainLikeListBtn.tintColor = .white
        mainLikeListBtn.setTitleColor(.white, for: .normal)
        mainLikeListBtn.layer.cornerRadius = 4
        mainLikeListBtn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        mainContentLabel.text = "배고픈 · 노량진 · 회먹고싶은 · 권영주 작품"
        mainContentLabel.font = .systemFont(ofSize: 13)
        mainContentLabel.textColor = .white
        mainContentLabel.textAlignment = .center
        
        top10ImageView.image = UIImage(named: "top10 badge")
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
        
        mainStackView.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.bottom).offset(-12)
            make.horizontalEdges.equalTo(mainImageView.snp.horizontalEdges).inset(16)
            make.height.equalTo(35)
        }
        
        mainContentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mainStackView.snp.top).offset(-16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        top10ImageView.snp.makeConstraints { make in
            make.top.trailing.equalTo(popularSecondImageView)
        }
        
        signatureImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(popularThirdImageView).offset(5)
        }
        
        popularSecondSubStackView.snp.makeConstraints { make in
            make.bottom.equalTo(popularSecondImageView)
            make.horizontalEdges.equalTo(popularSecondImageView).inset(16)
        }
        
        popularThirdSubStackView.snp.makeConstraints { make in
            make.bottom.equalTo(popularThirdImageView)
            make.horizontalEdges.equalTo(popularThirdImageView).inset(16)
        }
    }
}

#Preview {
    HomeViewController()
}
