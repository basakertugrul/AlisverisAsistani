import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationArray = [[41.02513437515097, 29.039961120620085],[41.0772587890899, 29.009406339746615],[41.025602596771705, 29.106860592984635]]
    var titleArray = ["Altunizade Koton", "Özdilek Koton", "Canpark Koton"]
    var myLocation = CLLocationCoordinate2D()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.myLocation = location
        self.configureMap(center: location)
        self.placePins()
    }
    
    func configureMap(center: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func placePins() {
        var coords = [self.myLocation]
        for item in locationArray{
            coords.append(CLLocationCoordinate2D(latitude: item[0], longitude: item[1]))
        }
        var titles = ["Buradasınız"]
        for item in titleArray{
            titles.append(item)
        }
        for i in coords.indices {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coords[i]
            annotation.title = titles[i]
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        switch annotation.title!! {
        case "Buradasınız":
            annotationView.markerTintColor = UIColor(red: 0.518, green: 0.329, blue: 0.376, alpha: 1.0)
        
        default:
            annotationView.markerTintColor = UIColor(red: 0.169, green: 0.310, blue: 0.376, alpha: 1.0)
        }
        return annotationView
    }
    
    @IBAction func goBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
