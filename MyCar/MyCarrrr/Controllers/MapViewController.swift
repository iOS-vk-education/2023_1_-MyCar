import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private var contentView = MapView()
   
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        takeLocation()
    }
    
    //берем геопозицию и в этой же функции запрашиваем автосервисы рядом
    private func takeLocation() {
        LocationManager.shareLocation.getLocation { [weak self] location in DispatchQueue.main.async {
            guard let strongSelf = self else {
                return
            }
            let userLocationMark = MKPointAnnotation()
            userLocationMark.coordinate = location.coordinate
            strongSelf.contentView.map.setRegion(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
            strongSelf.contentView.map.addAnnotation(userLocationMark)
            self?.loadNearRepairServices(from: location.coordinate)
        }
      }
        
    }
    
    func loadNearRepairServices(from coordinate: CLLocationCoordinate2D) {
            //запрос для поиска
            let request = MKLocalSearch.Request()         //ПОПРОБУЙ У СЕБЯ ПОЗАПУСКАТЬ ЗАПРОСЫ НИЖЕ
            request.naturalLanguageQuery = "Авто-ремонт" //Станция Технического Обслуживания, Шиномонтаж
            request.region = contentView.map.region
            
            let search = MKLocalSearch(request: request)
            
            //поиск и обработка результатов
            search.start { [weak self] response, _ in
                guard let response = response else { return }
                // маркер для каждого места
                for item in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self?.contentView.map.addAnnotation(annotation)
                }
            }
        }
    
    
    
    
    
    


    
}
