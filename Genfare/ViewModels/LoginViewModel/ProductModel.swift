//
//  ProductModel.swift
//  Genfare
//
//  Created by omniwyse on 30/01/19.
//  Copyright © 2019 Omniwyse. All rights reserved.
//

import Foundation

class ProductModel {
    
    var productDescription : String!
    var ticketTypeDescription : String!
    var displayOrder : Int!
    
   convenience init(dictionary: [String:Any])
    {
        self.init()
        productDescription = dictionary["productDescription"] as? String
        ticketTypeDescription = dictionary["ticketTypeDescription"] as? String
        displayOrder = dictionary["displayOrder"] as? Int
    }
   convenience init(productDescription: String, ticketTypeDescription: String, displayOrder: Int)
    {
        self.init()
        self.productDescription = productDescription
        self.ticketTypeDescription = ticketTypeDescription
        self.displayOrder = displayOrder
    }
}
