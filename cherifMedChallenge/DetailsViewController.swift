import UIKit
import AlamofireImage
import Alamofire
class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
//table view and clicked cell class
    var BarsArray = [AnyObject]()
   // 10 images that i uploaded in always data
    var barsimg = ["http://rento.alwaysdata.net/Appartoo/bars/bar1.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar2.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar3.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar4.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar5.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar6.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar7.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar8.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar9.jpg","http://rento.alwaysdata.net/Appartoo/bars/bar10.jpeg"]
    
    @IBOutlet weak var barstab: UITableView!
    let url = "http://rento.alwaysdata.net/Appartoo/appartoo.json"
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAllBars( flag: true,completionHandler: { success in
            print("compdone")
            self.barstab.reloadData()
        })        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BarsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = barstab.dequeueReusableCell(withIdentifier: "barscell")
        let barLbl = cell?.viewWithTag(2) as? UILabel
        let barimg = cell?.viewWithTag(1)as? UIImageView
         var bar = BarsArray[indexPath.row] as! Dictionary<String , Any>
        barLbl?.text = bar["name"] as? String
        //mod 10 to never get out of index of image array that contains 10 pic
        barimg?.af_setImage(withURL: URL(string: barsimg[indexPath.row % 10])!)
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "info", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info" {
            //send parametre when we perform segue to details of the bar
            let barinfo = segue.destination as? ViewController
            let indexPath = barstab.indexPathForSelectedRow?.row
            var bar = BarsArray[indexPath!] as! Dictionary<String , Any>
            barinfo?.barimg = barsimg[indexPath! % 10]
            barinfo?.barlien = (bar["url"] as? String)!
            barinfo?.barnom = (bar["name"] as? String)!
             barinfo?.tagbar =  (bar["tags"] as? String)!
            barinfo?.adressbar =  (bar["address"] as? String)!
          barinfo?.lat =  (bar["latitude"] as? Double)!
            print((bar["latitude"] as? Double)!)
          barinfo?.lang =  (bar["longitude"] as? Double)!
        }
        }
    
    
    
    
    
    
    func GetAllBars( flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        Alamofire.request(url).responseJSON
            {
                response  in
                
                
                //getting the json value from the server
                
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    
                    if let innerdict = dict["bars"]{
                        self.BarsArray = innerdict as! [AnyObject]
                        // let val = jsonData.value(forKey: "") as! [[String:Any]]
                        
                        
                        
                        
                        
                    }}
                completionHandler(true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
