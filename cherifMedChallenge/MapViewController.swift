import UIKit
import MapKit
import  SwiftyJSON

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapview: MKMapView!
    
    
    
    
    var venues = [Bars]()
    
    func fetchData()
    {
        let fileName = "http://rento.alwaysdata.net/Appartoo/appartoo.json"
        let filePath = URL(string: fileName)
        var data: Data?
        do {
            data = try Data(contentsOf: filePath!, options: Data.ReadingOptions(rawValue: 0))
        } catch let error {
            data = nil
            print("Report error \(error.localizedDescription)")
        }
        
        if let jsonData = data {
            do {
                let json = try JSON(data: jsonData)
                if let venueJSONs = json["bars"].array {
                    for venueJSON in venueJSONs {
                        if let venue = Bars.from(json: venueJSON) {
                            self.venues.append(venue)
                        }
                    }
                }
            }catch let error {
                data = nil
                print("Report error \(error.localizedDescription)")
            }
            
            
        }
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        let lat = venues[0].coordinate.latitude
        let lang = venues[0].coordinate.longitude
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lang)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapview.setRegion(region, animated: true)
        self.mapview.addAnnotations(venues)
        
        
        
    }
    private let regionRadius: CLLocationDistance = 1000 // 1km ~ 1 mile = 1.6km
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.mapview.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}

