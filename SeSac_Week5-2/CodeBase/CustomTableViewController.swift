//
//  CustomTableViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/26/24.
//

import UIKit
import SnapKit

class CustomTableViewController: UIViewController {

    let testTextField = UITextField()
    let tableView = UITableView()
    let profileImage = UIImageView()
    
    // 얘는 테이블뷰랑 다르게 동작함
    let collectionView = UICollectionView()
    
    // 이렇게 써보래요
//    let collectionView = UICollectionView(frame: <#T##CGRect#>, collectionViewLayout: )
//
//    func layout() -> UICollectionViewLayout {
//        let a = UICollectionViewFlowLayout()
//        a.itemSize
//        a.minimumLineSpacing
//        a.sectionInset
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    func configureHierarchy() {
        view.addSubview(testTextField)
        view.addSubview(tableView)
        view.addSubview(profileImage)
    }
    
    func configureView() {
        testTextField.borderStyle = .none
        testTextField.placeholder = "제목을 입력해보세요"
        testTextField.textAlignment = .center
        testTextField.font = .boldSystemFont(ofSize: 15)
        testTextField.backgroundColor = .yellow
        
        tableView.delegate = self
        tableView.dataSource = self

        // delegate = self, self.myLabel => 클래스의 인스턴스를 의미
        // shopping.self, Lotto.self => 메타 타입(Swift Meta Type)
        
        struct User {
            static let name = "고래밥"
        }
        
        // .self 는 얘네임 (사실 줄여서 쓰고있던겨)
//        User.self.name.self.count
//        User.name.count
//        UserDefaults.standard
//        UserDefaults.self.standard
        
        // 시스템 셀은 이렇게 클래스를 불러버림
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        profileImage.backgroundColor = .black
        profileImage.image = UIImage(systemName: "pencil")
        
    }
    
    func configureConstraints() {
        testTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.leading.top.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(300)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.label.text = "테스트"
        cell.btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        return cell
    }
}
