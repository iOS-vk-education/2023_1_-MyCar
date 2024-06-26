import UIKit
import SwiftUI

class TabBarController: UITabBarController {

    private let model = HomeCarsModel()
    
    private let hostingMapVC = UIHostingController(rootView: MapView())
    private let hostingDocumentsVC = UIHostingController(rootView: DocumentsView())
    private let hostingTutorialVC = UIHostingController(rootView: TutorialView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .white
        
        // Установка цвета фона и тинта таббара
        tabBar.barTintColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1)
        tabBar.backgroundColor = UIColor(red: 31 / 255.0, green: 37 / 255.0, blue: 41 / 255.0, alpha: 1)
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        setupTabBar()
    }

    
    private func setupTabBar() {
        viewControllers = [setImage(vC: MyCarsViewController(model: model), image: UIImage(named: "garage"), title: "Гараж"),
                           setImage(vC: hostingMapVC, image: UIImage(named: "maps"), title: "Карта"),
                           setImage(vC: hostingDocumentsVC, image: UIImage(named: "doc"), title: "Документы"),
                           setImage(vC: hostingTutorialVC, image: UIImage(named: "info"), title: "Руководство")
        ]
    }
    
    private func setImage(vC: UIViewController, image: UIImage?, title: String) -> UIViewController {
        vC.tabBarItem.image = image
        vC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 2, right: 0)
        vC.tabBarItem.title = title
        return vC
    }
    

}
