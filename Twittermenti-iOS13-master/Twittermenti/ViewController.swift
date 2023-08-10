//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    let swifter = Swifter(consumerKey: "TmZVYXAteXozY1ZnYWdwckZLNmQ6MTpjaQ", consumerSecret: "Oo5n9BRsGlSHxdPE1pENmPKRMk2mRC697WvXVqY2D2YTF4UfvZ")

    override func viewDidLoad() {
        super.viewDidLoad()
        swifter.searchTweet(using: "@Apple", success: { results, metaData in
            print(results)
        }) { error in
            print("error searching tweet")
        }
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

