//
//  ViewController.swift
//  OyalaPlayerClient
//
//  Created by Salman Jamil on 8/10/17.
//  Copyright © 2017 Salman Jamil. All rights reserved.
//

import UIKit
import MckinseyXBlocks

class ViewController: UIViewController {

    var vc: OyalaPlayerViewController?
    let player = OyalaPlayer(domain: "https://secure-cf-c.ooyala.com", playerCode: "5zdHcxOlM7fQJOMrCdwnnu16WP-d", contentID: "l2Mzh5dDoUsZQX0mx1ntvgqMnnCK9Kw-")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // let player = OyalaPlayer(domain: "https://secure-cf-c.ooyala.com", playerCode: "5zdHcxOlM7fQJOMrCdwnnu16WP-d", contentID: "l2Mzh5dDoUsZQX0mx1ntvgqMnnCK9Kw-")
        player.play()
        view.addSubview(player.view)
        player.view.translatesAutoresizingMaskIntoConstraints = false
        player.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        player.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        player.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        player.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

