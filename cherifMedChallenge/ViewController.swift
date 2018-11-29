import UIKit
import CoreLocation
import MapKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController {
    
    @IBOutlet weak var likepic: UIImageView!
    @IBOutlet weak var baradress: UILabel!
    @IBOutlet weak var barpos: MKMapView!
    @IBOutlet weak var barname: UILabel!
    var barnom = ""
    var lang = 0.0
    var lat = 0.0
    var barimg = ""
    var barlien = ""
    var tagbar = ""
     var adressbar = ""
    @IBOutlet weak var imagebar: UIImageView!
    
    @IBOutlet weak var barlink: UILabel!
    @IBOutlet weak var bartag: UILabel!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        //Double click gesture
        let gesturtaprecognized = UITapGestureRecognizer(target: self, action: #selector(ViewController.imagetapped(_:)))
        
        gesturtaprecognized.numberOfTapsRequired = 2
        imagebar.isUserInteractionEnabled = true
        imagebar.addGestureRecognizer(gesturtaprecognized)
        let targetbar = MKPointAnnotation()
        //show barname in a marker
        targetbar.title = barnom
        targetbar.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lang)
        barpos.addAnnotation(targetbar)
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lang)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.barpos.setRegion(region, animated: true)
        barname.text = barnom
        imagebar?.af_setImage(withURL: URL(string: barimg)!)
        bartag.text = tagbar
        baradress.text = adressbar
        barlink.text = barlien
    }
//when image is tapped twice
    @objc func imagetapped(_ sender: UITapGestureRecognizer) {
        if likepic.image == #imageLiteral(resourceName: "like") {
            print("from like to dislike")
            self.likepic.image = Image(named: "dislike")
        }
        else {
            print("from dislike to like")
            self.likepic.image = #imageLiteral(resourceName: "like")
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    //navigation in map
    @IBAction func startnavigationclicked(_ sender: UIButton) {
        
       // performSegue(withIdentifier: "navigate", sender: self)
        
        
        //Defining destination
        let latitude:CLLocationDegrees = lat
        let longitude:CLLocationDegrees = lang
        
        
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = barnom
        mapItem.openInMaps(launchOptions: options)
    }

    
    @IBAction func hyperclicked(_ sender: UIButton) {
        if let url = NSURL(string: "https://www.appartoo.com" ) {
           // UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            UIApplication.shared.open(url as URL, options: [:])
            
        }
    }
    
}

