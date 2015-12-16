//
//  ViewController.swift
//  weather 2
//
//  Created by Nivardo Ibarra on 12/14/15.
//  Copyright © 2015 Nivardo Ibarra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    // Caracas VEXX0008
    // Paris FRXX0076
    // Grenoble FRXX0153
    
    var cities: Array<Array<String>> = Array<Array<String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cities.append(["Caracas", "VEXX0008"])
        cities.append(["Paris", "FRXX0076"])
        cities.append(["Grenoble", "FRXX0153"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cities.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cities[row][0]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let urls = "https://query.yahooapis.com/v1/public/yql?format=json&q=SELECT%20*%20FROM%20weather.forecast%20WHERE%20u%20=%20%27c%27%20and%20location%20=%20%27"
        let url = NSURL(string: urls + self.cities[row][1] + "%27")
        let data = NSData(contentsOfURL: url!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)
            let dictionary1 = json as! NSDictionary
            let dictionary2 = dictionary1["query"] as! NSDictionary
            let dictionary3 = dictionary2["results"] as! NSDictionary
            let dictionary4 = dictionary3["channel"] as! NSDictionary
            let dictionary5 = dictionary4["location"] as! NSDictionary
            self.lblCity.text = dictionary5["city"] as! NSString as String
            let dictionary6 = dictionary4["item"] as! NSDictionary
            let dictionary7 = dictionary6["condition"] as! NSDictionary
            self.lblTemperature.text = dictionary7["temp"] as! NSString as String
        }catch {
            print("Error")
            return
        }
    }
}

