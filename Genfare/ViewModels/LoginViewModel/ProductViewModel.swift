//
//  ProductViewModel.swift
//  Genfare
//
//  Created by omniwyse on 30/01/19.
//  Copyright © 2019 Omniwyse. All rights reserved.
//

import Foundation
import RxSwift

class ProductViewModel {
    let model : ProductModel = ProductModel()
    let disposebag = DisposeBag()
    

   public class func modelsFromArray(array:[[String:Any]]) -> [ProductModel]
    {
        var models:[ProductModel] = []
        for item in array
        {
            models.append(ProductModel.init(dictionary: item))
        }
        return models
    }
    
//    let productList:Array<Product>? = GFAccountManager.GetProducts()
//    func singleproduct() -> Product {
//        for i in productList!{
//            return i
//        }
//    }
    
   // let productArray = ProductViewModel.modelsFromArray(array: productList)
   
    
   
}
