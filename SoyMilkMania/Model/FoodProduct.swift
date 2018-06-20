//
//  FoodProduct.swift
//  SoyMilkMania
//
//  Created by Christian Riboldi on 5/31/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import UIKit

struct TopLevelData: Codable {
    var code: String
    var product: FoodProduct?
}

struct FoodProduct: Codable {
    var nutrientLevels: NutrientLevels
    var ingredientsImageURL: String?
    var servingSize: String
    var ingredientsIds: [String]
    var productName: String
    var ingredientsText: String
    var codeTags: [String]
    var id: String
    var origins: String?
    var nutritionGrades: String
    var productImageUrl: String
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id, origins
        case nutrientLevels = "nutrient_levels"
        case ingredientsImageURL = "image_ingredients_small_url"
        case servingSize = "serving_size"
        case ingredientsIds = "ingredients_ids_debug"
        case productName = "product_name_en"
        case ingredientsText = "ingredients_text_en"
        case codeTags = "codes_tags"
        case nutritionGrades = "nutrition_grades"
        case productImageUrl = "image_url"
    }
    
    struct NutrientLevels: Codable {
        var sugars: String?
        var salt: String?
        var fat: String?
        var saturatedFat: String?
        
        enum CodingKeys: String, CodingKey {
            case sugars, salt, fat
            case saturatedFat = "saturated-fat"
        }
    }
}
