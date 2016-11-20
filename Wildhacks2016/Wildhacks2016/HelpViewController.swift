//
//  HelpViewController.swift
//  Wildhacks2016
//
//  Created by Wyatt Mufson on 11/20/16.
//  Copyright © 2016 WMG. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = "Hotspots, Mapified.\n\nAs a driver, being it Uber or Lyft, have you ever run into the situation when you have no idea where the next customer is? As a person who just spent a splendid night, would you wish to get the ride at your fingertips also at your doorstep?\n\nThis is not your everyday map app, we created Mapify to be the ultimate solution to connect our customer driver networks in a beautiful, simplistic and yet easy to navigate user interface.\n\nThe app gets your current locations and shows all popular events that are happening around you. We used the Eventbrite API to extract these events including pop convert, national-wide hackathon, conferences, fairs and many more. You can click on the pins in the Map view to look at the name of each event. Each of the pins is color-coded to provide you with more details about its end time so you can plan your trip better."
        textView.textColor = UIColor().colorFromHex(hexValue: "4e2a84", alpha: 1)
        view.backgroundColor = UIColor().colorFromHex(hexValue: "F0F0F0", alpha: 1)
        textView.backgroundColor = UIColor().colorFromHex(hexValue: "F0F0F0", alpha: 1)
        self.title = "Help"
        
    }
    
    override func viewDidLayoutSubviews() {
        self.textView.contentOffset = CGPoint(x: 0, y: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
