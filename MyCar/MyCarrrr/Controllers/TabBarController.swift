//
//  TabBarController.swift
//  MyCarrrr
//
//  Created by tearsoverbeers on 31.10.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .white
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = [setImage(vC: MyCarsViewController(), image: UIImage(named: "garage")), setImage(vC: MapViewController(), image: UIImage(named: "map")) ]
    }
    
    private func setImage(vC: UIViewController, image: UIImage?) -> UIViewController {
        vC.tabBarItem.image = image
        return vC
    }
    

}
