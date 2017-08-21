//
//  MRQViewController.swift
//  MckinseyXBlocks
//
//  Created by Shafqat Muneer on 8/19/17.
//  Copyright © 2017 Salman Jamil. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        let radius = CGFloat(3)
        let cornerRadius = CGFloat(5)
        
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.cornerRadius = cornerRadius
    }
}

public class MRQViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: Bundle(identifier: "com.arbisoft.MckinseyXBlocks")), forCellReuseIdentifier: "AnswerTableViewCell")
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Tableview DataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answerCell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell") as! AnswerTableViewCell
        //answerCell.selectionStyle = UITableViewCellSelectionStyle.none
        return answerCell
    }
    
//    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 15
//    }
//    
//    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
    
    //MARK: Table view delegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
