//
//  GFProductsService.swift
//  Genfare
//
//  Created by omniwyse on 29/01/19.
//  Copyright © 2019 Omniwyse. All rights reserved.
//

import Foundation
import Alamofire
import CoreData
class GFProductsService{
    
    init(){}
    
    func fetchConfigurationValues(completionHandler:@escaping (_ success:Bool?,_ error:Any?) -> Void) {
        let endpoint = GFEndpoint.GetProductForWallet()
        
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: URLEncoding.default, headers: endpoint.headers)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print(JSON)
                self.saveData(datas:JSON as! [[String : Any]])
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completionHandler(false,error)
                }
        }
    }
    func saveData(datas:[[String:Any]]) {
        //Delete existing records if any before saving products details
        GFDataService.deleteAllRecords(entity: "Product")
        let managedContext = GFDataService.context
        let product = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)
        
        for data in datas{
   let proObj:Product = NSManagedObject(entity: product!, insertInto: managedContext) as! Product

       proObj.barcodeTimer = data["barcodeTimer"] as? NSNumber
        proObj.designator = data["designator"] as? String
        proObj.displayOrder = data["displayOrder"] as? NSNumber
        proObj.fareCode = data["fareCode"] as? String
        proObj.isActivationOnly = data["isActivationOnly"] as? NSNumber
        proObj.isBonusRideEnabled = data["isBonusRideEnabled"] as? NSNumber
        proObj.isCappedRideEnabled = data["isCappedRideEnabled"] as? NSNumber
        proObj.offeringId = data["offeringId"] as? NSNumber
        proObj.price = String(describing: data["price"]!) as? String
        proObj.productDescription = data["productDescription"] as? String
        proObj.ticketId = data["ticketId"] as? NSNumber
        proObj.ticketSubTypeId = data["ticketSubTypeId"] as? String
        proObj.ticketTypeDescription = data["ticketTypeDescription"] as? String
        proObj.ticketTypeId = data["ticketTypeId"] as? String
        GFDataService.saveContext()
    }
    }
   
}
