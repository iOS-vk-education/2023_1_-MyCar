import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private var contentView = MapView()
    
    let searchRequest = MKLocalSearch.Request()
   
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        takeLocation()
    }
    
    private func takeLocation() {
        LocationManager.shareLocation.getLocation { [weak self] location in DispatchQueue.main.async {
            guard let strongSelf = self else {
                return
            }
            let pin = MKPointAnnotation()
            pin.coordinate = location.coordinate
            strongSelf.contentView.map.setRegion(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 0.7, longitudinalMeters: 0.7), animated: true)
            strongSelf.contentView.map.addAnnotation(pin)
        }
      }        
    }
    
    
    


    
}
