//
//  navigationViewController.swift
//  cherifMedChallenge
//
//  Created by Sam on 28/11/2018.
//  Copyright © 2018 AppartooChallenge. All rights reserved.
//

import UIKit
import AlamofireImage
class navigationViewController: UIViewController {
    @IBOutlet weak var barimg: UIImageView!
    
    @IBOutlet weak var barname: UILabel!
    var barimage = ""
    var barnom = ""
   var lat = 0.0
    var lang = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
barname.text = barnom
        barimg.af_setImage(withURL: URL(string: barimage)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
