
import UIKit

class CarCardViewController: UIViewController {
    
    private var contentView: CarCardView {
        view as! CarCardView
    }
    
    override func loadView() {
        view = CarCardView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   


}
