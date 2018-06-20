//
//  SearchViewController.swift
//  SoyMilkMania
//
//  Created by Christian Riboldi on 5/31/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    struct Constants {
        static let milkOptions = ["Almond Milk Unsweetened" : "0041570054130",
                                  "Black Soy Drink" : "0061954004452",
                                  "Almond milk" : "6870973",
                                  "Blue cheeze dressing" : "87145900905",
                                  "Brighton Falls, Soy Enriched Soy Milk, Original" : "0074807267911",
                                  "Calcium Enriched Soy Milk" : "76544405520",
                                  "Edensoy, Organic Soy Milk, Original" : "0024182025354",
                                  "Edensoy, Soy Milk, Original" : "0024182025057",
                                  "Edensoy, Soy Milk, Vanilla" : "0024182025453",
                                  "Light Soy Milk" : "0099482436223",
                                  "Natural Soy Bean Milk" : "8824808830650",
                                  "Organic Soy Milk, Original" : "0041190037940",
                                  "Organic Soy Milk, Vanilla" : "0093966002010",
                                  "Organic Unsweetened soy milk" : "0074873960150",
                                  "Soy Dream, Organic Soy Milk, Enriched Vanilla" : "0084253260213",
                                  "Soy Milk" : "0008273000253",
                                  "Soy Milk Non-Dairy Frozen Dessert, Mint Chocolate Chip" : "0744473480555",
                                  "Soy Milk, Vanilla" : "0041190037933",
                                  "Soy Milk, Very Vanilla" : "0025293002715",
                                  "Sweetened Condensed Soy Milk" : "0041220246984",
                                  "Sweetened Soy Drink" : "0061954000539",
                                  "Unsweetened Organic Soy Milk" : "0688267064661",
                                  "Vegan Soy Powder, Original" : "0041648078006",
                                  "Westbrae Natural, West Soy, Organic Plus Plain Soy Milk" : "0074873970500",
                                  "White chocolate macadamia" : "0787692838349",
                                  "Yeo's, Soy, Soy Milk" : "0077521335010"]
        static let showDetailSegueID = "showDetailSegue"
    }
    
    @IBOutlet weak var milkPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        milkPickerView.dataSource = self
        milkPickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func pressedSearchButton(_ sender: Any) {
        let selectedRowNumber = milkPickerView.selectedRow(inComponent: 0)
        let selectedProductTitle = Array(Constants.milkOptions.keys)[selectedRowNumber]
        guard let selectedProductID = Constants.milkOptions[selectedProductTitle] else {
            return
        }
        
        ProductSearchModelController.fetchProduct(productNumber: selectedProductID) { (success) in
            if success {
                print("found something")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.showDetailSegueID, sender: nil)
                }
            } else {
                print("nothing found")
            }
        }
    }

}

extension SearchViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.milkOptions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(Constants.milkOptions.keys)[row]
    }
    
}

extension SearchViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected row \(row)")
    }
    
}
