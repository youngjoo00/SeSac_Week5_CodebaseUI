//
//  AssignmentTabBarController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/26/24.
//

import UIKit

class AssignmentTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstTab = UINavigationController(rootViewController: HomeViewController())
        let firstTabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        firstTab.tabBarItem = firstTabBarItem
        
        let secondTab = UINavigationController(rootViewController: NewANDHotViewController())
        let secondTabBarItem = UITabBarItem(title: "NEW&HOT", image: UIImage(systemName: "play.rectangle.on.rectangle.fill"), tag: 1)
        secondTab.tabBarItem = secondTabBarItem
        
        let thirdTab = UINavigationController(rootViewController: SavedContentViewController())
        let thirdTabBarItem = UITabBarItem(title: "저장할 콘텐츠 목록", image: UIImage(systemName: "arrow.down.circle.fill"), tag: 2)
        thirdTab.tabBarItem = thirdTabBarItem

        self.viewControllers = [firstTab, secondTab, thirdTab]
    }

}
