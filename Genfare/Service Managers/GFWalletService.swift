//
//  GFWalletService.swift
//  Genfare
//
//  Created by vishnu on 24/01/19.
//  Copyright © 2019 Omniwyse. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class GFWalletsService {
    
    init(){}
    
    func fetchWallets(completionHandler:@escaping (_ success:Bool?,_ error:Any?) -> Void) {
        let endpoint = GFEndpoint.CheckWalletService()
        
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: URLEncoding.default, headers: endpoint.headers)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print(JSON)
                    let records:[String:Any] = JSON as! [String:Any]
                    if let wallets:Array<Any> = records["result"] as! Array<Any> {
                        print("Wallet length - \(wallets.count)")
                        if wallets.count > 0 {
                            self.saveWalletData(data: wallets.first as! [String:Any])
                        }else{
                            GFDataService.deleteAllRecords(entity: "Wallet")
                        }
                        completionHandler(true,nil)
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completionHandler(false,error)
                }
        }
    }

    func createWallet(nickname:String,completionHandler:@escaping (_ success:Bool?,_ error:Any?) -> Void) {
        let endpoint = GFEndpoint.CreateWallet(wallet: nickname)
        
        Alamofire.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default, headers: endpoint.headers)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print(JSON)
                    self.saveWalletData(data: JSON as! [String : Any])
                    completionHandler(true,nil)
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completionHandler(false,error)
                }
        }
    }
    
    func saveWalletData(data:[String:Any]) {
        print(data)
        GFDataService.deleteAllRecords(entity: "Wallet")
        
        let managedContext = GFDataService.context
        let wallet = NSEntityDescription.entity(forEntityName: "Wallet", in: managedContext)
        let userObj:Wallet = NSManagedObject(entity: wallet!, insertInto: managedContext) as! Wallet
        
        userObj.accMemberId = data["accMemberId"] as? String
        userObj.accTicketGroupId = data["accTicketGroupId"] as? String
        userObj.accountType = data["accountType"] as? String
        userObj.cardType = data["cardType"] as? String
        userObj.deviceUUID = data["deviceUUID"] as? String
        userObj.farecode = data["farecode"] as? NSNumber
        userObj.farecode_expiry = data["farecode_expiry"] as? NSNumber
        userObj.id = data["id"] as? NSNumber
        userObj.nickname = data["nickname"] as? String
        userObj.personId = data["personId"] as? NSNumber
        userObj.status = data["status"] as? String
        userObj.statusId = data["statusId"] as? NSNumber
        userObj.walletId = data["walletId"] as? NSNumber
        userObj.walletUUID = data["walletUUID"] as? String
        
        GFDataService.saveContext()
    }
    
    static func userWallet() -> Wallet? {
        let records:Array<Wallet> = GFDataService.fetchRecords(entity: "Wallet") as! Array<Wallet>
        
        if records.count > 0 {
            return records.first
        }
        
        return nil
    }
    
    static func isWalletAvailable() -> Bool {
        if userWallet() != nil {
            return true
        }else{
            return false
        }
    }
}
