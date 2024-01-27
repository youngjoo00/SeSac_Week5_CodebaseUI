//
//  SavedContentViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/26/24.
//

import UIKit

class SavedContentViewController: UIViewController {

    let navTitle = UILabel().then {
        $0.configureLabel(text: "저장한 콘텐츠 목록", textColor: .white, backgroundColor: .clear, font: .boldSystemFont(ofSize: 25), textAlignment: .center)
    }
    
    let titleLabel = UILabel()
    let subLabel = UILabel()
    let centerImage = UIImageView()
    
    let saveSettingBtn = UIButton()
    let contentListBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
}

extension SavedContentViewController: ViewProtocol {
    
    func configureHierarchy() {
        
        [
            titleLabel,
            subLabel,
            centerImage,
            saveSettingBtn,
            contentListBtn,
        ].forEach { view.addSubview($0)}
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        self.navigationItem.titleView = navTitle
        
        titleLabel.configureLabel(text: "'나만의 자동 저장' 기능", textColor: .white, backgroundColor: .clear, font: .boldSystemFont(ofSize: 20), textAlignment: .center)
        
        subLabel.configureLabel(text: "취향에 맞는 영화와 시리즈를 자동으로 저장해 드립니다. 디바이스에 언제나 시청할 콘텐츠가 준비되니 지루할 틈이 없어요.", textColor: .systemGray3, backgroundColor: .clear, font: .systemFont(ofSize: 15), textAlignment: .center)
        subLabel.numberOfLines = 0
        
        centerImage.configureImageView(name: "dummy", cornerRadius: 0)
        
        saveSettingBtn.configureBtn(image: nil, title: "설정하기", backgroundColor: .blue, textColor: .white, font: .boldSystemFont(ofSize: 17), cornerRadius: 4)
        
        contentListBtn.configureBtn(image: nil, title: "저장 가능한 콘텐츠 살펴보기", backgroundColor: .white, textColor: .black, font: .boldSystemFont(ofSize: 17), cornerRadius: 4)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subLabel.snp.top).offset(-16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        subLabel.snp.makeConstraints { make in
            make.bottom.equalTo(centerImage.snp.top).offset(-12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        centerImage.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        saveSettingBtn.snp.makeConstraints { make in
            make.top.equalTo(centerImage.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(44)
        }
        
        contentListBtn.snp.makeConstraints { make in
            make.top.equalTo(saveSettingBtn.snp.bottom).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
            make.width.equalTo(saveSettingBtn).multipliedBy(0.8)
        }
    }
    
    
}

#Preview {
    SavedContentViewController()
}
