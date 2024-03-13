import UIKit
import MapKit
//new ver
class MapViewController: UIViewController, MKMapViewDelegate {
    
    private var contentView = MapView()
   
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
                
        // Настройка отображения карты
        contentView.map.showsUserLocation = true
        contentView.map.delegate = self
        takeLocation()

    }
    
    //берем геопозицию и в этой же функции запрашиваем автосервисы рядом
    private func takeLocation() {
        LocationManager.shareLocation.getLocation { [weak self] location in DispatchQueue.main.async {
            guard let strongSelf = self else {
                return
            }
            //let userLocationMark = MKPointAnnotation()
            //userLocationMark.coordinate = location.coordinate
            strongSelf.contentView.map.setRegion(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
            //strongSelf.contentView.map.addAnnotation(userLocationMark)
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
                
                let annotations = response.mapItems.map { item -> Place in
                    let annotation = Place(title: item.name, subtitle: item.phoneNumber, phone: item.phoneNumber, coordinate: item.placemark.coordinate)
                            return annotation
                        }
                        
                //self?.contentView.map.removeAnnotations((self?.contentView.map.annotations)!)
                self?.contentView.map.addAnnotations(annotations)
                // маркер для каждого места
                for item in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self?.contentView.map.addAnnotation(annotation)
                    
                }
            }
            
            
        }
    
}
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Place else {
            return nil
        }
        
        let identifier = "PlaceAnnotation"
        var view: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let place = view.annotation as? Place else { return }
        
        let alertController = UIAlertController(title: place.title, message: place.subtitle, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        }*/
        

    /*func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
       // guard let place = view.annotation as? Place else { return }
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
                let alertController = UIAlertController(title: item.name , message: item.phoneNumber, preferredStyle: .alert)
               // annotation.subtitle = item.phoneNumber
                let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self?.present(alertController, animated: true, completion: nil)
                self?.contentView.map.addAnnotation(annotation)
            }
        }
        
        
        
    }*/


