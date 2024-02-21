import UIKit

class TabBarController: UITabBarController {

    private let model = HomeCarsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .white
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = [setImage(vC: MyCarsViewController(model: model), image: UIImage(named: "garage")),
                           setImage(vC: MapViewController(), image: UIImage(named: "map"))
        ]
    }
    
    private func setImage(vC: UIViewController, image: UIImage?) -> UIViewController {
        vC.tabBarItem.image = image
        return vC
    }
    

}
