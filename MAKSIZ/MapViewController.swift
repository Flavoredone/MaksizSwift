import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    var mapView: MKMapView!
    
    let locations = [
        ("Восток сервис - Москва", "Большая Переяславская, 11 строение 1, 129272"),
        ("Техноавиа - Магазин", "ул. Красноармейская, 12 (р-н Аэропорт)"),
        ("Арбат Бизнес Центр", "Карманицкий пер, д. 9, офис 707")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupMapView()
        addPinsToMap()
        view.backgroundColor = .darkGray

    }
    
    
    
    
    func setupMapView() {
        mapView = MKMapView()
        mapView.delegate = self  // Установить self в качестве делегата
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1), // Добавлен отступ в 5 точек
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
        
    }

    
    func addPinsToMap() {
        var annotations = [MKPointAnnotation]() // Массив для хранения аннотаций
        
        for location in locations {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(location.1) { [weak self] (placemarks, error) in
                if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate {
                    let annotation = MKPointAnnotation()
                    annotation.title = location.0
                    annotation.subtitle = location.1 // Устанавливаем полный адрес в качестве подзаголовка
                    annotation.coordinate = coordinate
                    self?.mapView.addAnnotation(annotation)
                    annotations.append(annotation)
                    
                    // Проверяем, добавлены ли все аннотации
                    if annotations.count == self?.locations.count {
                        self?.mapView.showAnnotations(annotations, animated: true)
                    }
                }
            }
        }
    }

}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
        }
        return view
    }
}
