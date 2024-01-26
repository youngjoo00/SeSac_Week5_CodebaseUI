//
//  CustomTableViewCell.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/26/24.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {

    let label = UILabel()
    let btn = UIButton()
    
    // 코드로 구성할 때 실행되는 초기화 구문으로, awakeFromNib에서 작성되는 코드도 함께 작성!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // override 해서 가져왔으니 super 로 자기를 사용하게끔 함
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 셀의 콘텐츠 뷰 색상 변경은 왜 하지 않는것이지?
        // 게다가 하면 오류나는데..?
        contentView.backgroundColor = .black
        
        // 셀은 콘텐츠 뷰가 최상단 뷰임
        contentView.addSubview(label)
        contentView.addSubview(btn)
        
        // 이거 써도 레이아웃은 잘 잡히는데 사용자의 액션을 못받음
        //self.addSubview(label)
        
        label.backgroundColor = .yellow
        btn.backgroundColor = .blue
        
        btn.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerX.trailingMargin.equalTo(contentView)
        }
        
        label.snp.makeConstraints { make in
            make.top.leadingMargin.bottom.equalTo(contentView)
            make.trailing.equalTo(btn.snp.leading).inset(8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Nib => Xib 를 만들거나 스토리보드 기반으로 구성된 셀일 때만 실행되는 메서드
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//    }
}
