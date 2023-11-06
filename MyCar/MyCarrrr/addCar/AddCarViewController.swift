
import UIKit

class AddCarViewController: UIViewController {
    
    private var contentView: AddCarView {
        view as! AddCarView
    }
    
    override func loadView() {
        view = AddCarView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
