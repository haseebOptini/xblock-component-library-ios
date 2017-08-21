//
//  ViewController.swift
//  MRQClient
//
//  Created by Shafqat Muneer on 8/16/17.
//  Copyright © 2017 Salman Jamil. All rights reserved.
//

import UIKit
import MckinseyXBlocks

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let detailController = CourseCatalogDetailViewController(environment: environment, courseID: courseID)
//        fromController.navigationController?.pushViewController(detailController, animated: true)

        
        let bundle = Bundle(identifier: "com.arbisoft.MckinseyXBlocks")
        let mrqViewController = MRQViewController(nibName: "MRQViewController", bundle: bundle)
        addChildViewController(mrqViewController)
        view.addSubview(mrqViewController.view)
        mrqViewController.view.translatesAutoresizingMaskIntoConstraints = false
        mrqViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        testViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        testViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mrqViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mrqViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        mrqViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mrqViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true


        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

