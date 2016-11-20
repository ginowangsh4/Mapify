//
//  HomeScreenViewController.swift
//  Wildhacks2016
//
//  Created by Wyatt Mufson on 11/19/16.
//  Copyright © 2016 WMG. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "logo.png")!
        imageView.image = image
        
        
        titleLabel.textColor = UIColor().colorFromHex(hexValue: "F0F0F0", alpha: 1)
        mapButton.backgroundColor = UIColor().colorFromHex(hexValue: "F0F0F0", alpha: 1)
        listButton.backgroundColor = UIColor().colorFromHex(hexValue: "F0F0F0", alpha: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

