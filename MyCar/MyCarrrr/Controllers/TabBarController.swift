import UIKit
import SwiftUI

class TabBarController: UITabBarController {

    private let model = HomeCarsModel()
    
    private let hostingMapVC = UIHostingController(rootView: MapView())
    private let hostingDocumentsVC = UIHostingController(rootView: DocumentsView())
    private let hostingTutorialVC = UIHostingController(rootView: TutorialView())
    
        super.viewDidLoad()
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .white
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = [setImage(vC: MyCarsViewController(model: model), image: UIImage(named: "garage")),
                           //setImage(vC: MapViewController(), image: UIImage(named: "map")),
                           setImage(vC: hostingTutorialVC, image: UIImage(named: "lesson"))
//                           setImage(vC: MapViewController(), image: UIImage(named: "map")),
                           //setImage(vC: hostingMapVC, image: UIImage(named: "map")),
                           setImage(vC: hostingDocumentsVC, image: UIImage(systemName: "doc"))
                           //setImage(vC: MapViewController(), image: UIImage(named: "map")),
                           setImage(vC: hostingTutorialVC, image: UIImage(named: "lesson"))
        return vC
    }
    

}
