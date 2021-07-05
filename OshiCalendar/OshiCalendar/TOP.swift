//
//  ViewController.swift
//  OshiCalendar
//
//  Created by 平島峻成 on 2021/07/04.
//  Copyright © 2021 平島峻成. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        makeGradation()
    }
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    func makeGradation(){
        let image = UIImage(named: "BG")
        self.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationBar.isTranslucent = true
    }

}

