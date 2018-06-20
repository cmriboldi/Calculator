//
//  DetailViewController.swift
//  SoyMilkMania
//
//  Created by Christian Riboldi on 5/31/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nutrientGradeTextField: UITextField!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var nutrientLevels: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let product = ProductSearchModelController.foodProduct {
            updateViews(product)
        }
    }
    
    func updateViews(_ product: FoodProduct) {
        self.nameTextField.text = product.productName
        self.idTextField.text = product.id
        self.nutrientGradeTextField.text = product.nutritionGrades.capitalized
        self.ingredients.text = product.ingredientsText
        self.imageView.image = product.image
    }
    
}
