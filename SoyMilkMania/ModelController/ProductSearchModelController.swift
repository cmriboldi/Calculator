//
//  ProductSearchModelController.swift
//  SoyMilkMania
//
//  Created by Christian Riboldi on 5/31/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import UIKit

class ProductSearchModelController {
    
    struct Constants {
        static let baseURL = URL(string: "https://world.openfoodfacts.org/api/v0/product/")
    }
    
    static var foodProduct: FoodProduct?
    
    static func fetchProduct(productNumber: String, completion: @escaping ((Bool)->Void) ) {
        guard let url = Constants.baseURL?.appendingPathComponent(productNumber).appendingPathExtension("json") else {
            print("Error with baseURL")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error with fetching product: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else {
                print("Error no data returned from fetch.")
                completion(false)
                return
            }
            
            do {
                let topLevelData = try JSONDecoder().decode(TopLevelData.self, from: data)
                guard let returnedFoodProduct = topLevelData.product as? FoodProduct else {
                    print("No product key: \(topLevelData.code)")
                    completion(false)
                    return
                }
                self.foodProduct = returnedFoodProduct
                ProductSearchModelController.fetchImage(imgURLString: returnedFoodProduct.productImageUrl, completion: { (image) in
                    if let image = image {
                        self.foodProduct?.image = image
                        print("Product found! Name: \(self.foodProduct?.productName ?? "nil")")
                        completion(true)
                        return
                    } else {
                        print("Error getting image")
                        completion(false)
                        return
                    }
                })
            } catch DecodingError.keyNotFound(let codingKey, let context) {
                print("Error: coding key not found \(codingKey) in \(context)")
                completion(false)
                return
            } catch {
                print("Error decoding the data")
                completion(false)
                return
            }
        }.resume()
    }
    
    static func fetchImage(imgURLString: String, completion: @escaping ((UIImage?)->Void)) {
        guard let url = URL(string: imgURLString) else {
            print("Error making image URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching image")
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("Error with data when fetching data.")
                completion(nil)
                return
            }
            completion(image)
        }.resume()
        
        
    }
    
}

