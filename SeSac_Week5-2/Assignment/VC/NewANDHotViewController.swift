//
//  NewANDHotViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/26/24.
//

import UIKit
import SnapKit
import Then

class NewANDHotViewController: UIViewController {

    let navTitle = UILabel().then {
        $0.configureLabel(text: "NEW & HOT 검색", textColor: .white, backgroundColor: .clear, font: .boldSystemFont(ofSize: 25), textAlignment: .center)
    }
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "게임, 시리즈, 영화를 검색하세요"
        $0.searchBarStyle = .minimal
        $0.searchTextField.backgroundColor = .lightGray
    }
    
    let contentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fill
    }
    
    let upcomingReleaseBtn = UIButton()
    let popularContentBtn = UIButton()
    let top10SeriesBtn = UIButton()
    
    let noSearchTitleLabel = UILabel()
    let noSearchSubLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
}

extension NewANDHotViewController: ViewProtocol {
    
    func configureHierarchy() {
        
        [
            searchBar,
            contentStackView,
            noSearchTitleLabel,
            noSearchSubLabel,
        ].forEach { view.addSubview($0)}
        
        [
            upcomingReleaseBtn,
            popularContentBtn,
            top10SeriesBtn,
        ].forEach { contentStackView.addArrangedSubview($0) }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        self.navigationItem.titleView = navTitle
        
        upcomingReleaseBtn.configureBtn(image: UIImage(named: "blue"), title: "공개 예정", backgroundColor: .white, textColor: .black, font: .systemFont(ofSize: 14), cornerRadius: 8)
        
        popularContentBtn.configureBtn(image: UIImage(named: "turquoise"), title: "모두의 인기 콘텐츠 ", backgroundColor: .white, textColor: .black, font: .systemFont(ofSize: 14), cornerRadius: 8)
        
        top10SeriesBtn.configureBtn(image: UIImage(named: "pink"), title: "Top 10 시리즈 ", backgroundColor: .white, textColor: .black, font: .systemFont(ofSize: 14), cornerRadius: 8)
        
        noSearchTitleLabel.configureLabel(text: "이런! 찾으시는 작품이 없습니다.", textColor: .white, backgroundColor: .clear, font: .boldSystemFont(ofSize: 25), textAlignment: .center)
        
        noSearchSubLabel.configureLabel(text: "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해 보세요.", textColor: .systemGray3, backgroundColor: .clear, font: .boldSystemFont(ofSize: 15), textAlignment: .center)
    }
    
    func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        noSearchTitleLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        noSearchSubLabel.snp.makeConstraints { make in
            make.top.equalTo(noSearchTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

#Preview {
    NewANDHotViewController()
}
