//
//  GFTicketCardSeletionViewController.swift
//  Genfare
//
//  Created by omniwyse on 05/02/19.
//  Copyright © 2019 Omniwyse. All rights reserved.
//

import UIKit

class GFTicketCardSeletionViewController: UIViewController {
    
    var productsCartArray = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.productsCartArray.count > 0{
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
 

}
