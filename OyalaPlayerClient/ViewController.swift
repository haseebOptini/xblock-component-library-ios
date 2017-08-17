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
    /*    player.play()
        view.addSubview(player.view)
        player.view.translatesAutoresizingMaskIntoConstraints = false
        player.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        player.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        player.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        player.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true*/
        
        let exchangeRequestURL = URL(string: "https://courses.qa.mckinsey.edx.org/oauth2/login/")
        var exchangeRequest = exchangeRequestURL.map{
            URLRequest(url: $0)
        }
        exchangeRequest?.httpMethod = "POST"
        exchangeRequest?.setValue("Bearer 239aa8ebefd59934a214db29ccf29f495b80629d", forHTTPHeaderField: "Authorization")
        let requestURL = URL(string: "https://courses.qa.mckinsey.edx.org/xblock/i4x://abc/abc000/html/3c32a671a93546bcbdaf60ff16c5487a")
        let request = requestURL.map {
            URLRequest(url: $0)
        }
        
        let viewController = OyalaPlayerViewController(contentID: "l2Mzh5dDoUsZQX0mx1ntvgqMnnCK9Kw-", domain: "https://secure-cf-c.ooyala.com", pcode: "5zdHcxOlM7fQJOMrCdwnnu16WP-d",exchangeRequest: exchangeRequest, request: request)
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        viewController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewController.play()
        
        //https://courses.qa.mckinsey.edx.org/xblock/i4x://abc/abc000/html/3c32a671a93546bcbdaf60ff16c5487a
        //Bearer 239aa8ebefd59934a214db29ccf29f495b80629d
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

