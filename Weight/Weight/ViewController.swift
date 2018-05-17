//
//  ViewController.swift
//  Weight
//
//  Created by Matthew Newill on 21/11/2016.
//  Copyright © 2016 DevFright.com. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lineView: LineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add an observer that listens out for BodyMassDataAvaialble. WHen triggered, it calls updateGraph(notification:) selector
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateGraph(notification:)),
                                               name: NSNotification.Name(rawValue: "BodyMassDataAvailable"),
                                               object: nil)
        
        
        if HKHealthStore.isHealthDataAvailable() {
            print("Yes, HK is available")
            let healthManager = HealthManager()
            healthManager.requestPermissions()
        } else {
            print("darn, HK is NOT available. Problem accessing it")
        }
    }
    
//    func updateGraph(notification: Notification) {
//        print(notification.object!)
//        let weightArray = notification.object as! Array<HKQuantitySample>
//
//
//        let maxSample = weightArray.max { a, b in a.quantity.doubleValue(for: <#T##HKUnit#>.init(from: .pound)) < b.quantity.doubleValue(for: HKUnit.init(from: .pound)) }
//
////        We use the .max function of the Array class here to determine which of the HKQuanitySample's contains the highest quantity value. Notice how we need to drill in to each HKQuantitySample to get to the data we need. First, we access the quantity property, but this contains a HKUnit object. There's a property of HKUnit that provides the doubleValue, but we need to specify what we want the doubleValue format to be in. In this instance, I specified the result to be in pounds. This doesn't really matter because we are comparing matching quantity types to each other and with weight, it we compare pounds to pounds or kilos to kilos, the correct answer will be obtained.
////
////        The end result is a double value stored in maxSample.
////
////        The next step is to round up that number:
//
//
//        lineView.height = CGFloat.init(100 * ceil((maxSample?.quantity.doubleValue(for: HKUnit.init(from: .pound)))!/100))
//
//    }

    func updateGraph(notification: Notification) {
        print("Here's my data: \(notification.object!)")
        let weightArray = notification.object as! Array<HKQuantitySample>
        
        //Send weightArray to cloud
        print("Here's WeightArray: \(weightArray)")
        
        // Find the HKQuantitySample with the largest quantity.
        let maxSample = weightArray.max { a, b in a.quantity.doubleValue(for: HKUnit.init(from: .pound)) < b.quantity.doubleValue(for: HKUnit.init(from: .pound)) }
        
        lineView.height = CGFloat.init(100 * ceil((maxSample?.quantity.doubleValue(for: HKUnit.init(from: .pound)))!/100))
        lineView.point0 = CGFloat.init(weightArray[0].quantity.doubleValue(for: HKUnit.init(from: .pound)))
        lineView.point1 = CGFloat.init(weightArray[1].quantity.doubleValue(for: HKUnit.init(from: .pound)))
        lineView.point2 = CGFloat.init(weightArray[2].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point3 = CGFloat.init(weightArray[3].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point4 = CGFloat.init(weightArray[4].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point5 = CGFloat.init(weightArray[5].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point6 = CGFloat.init(weightArray[6].quantity.doubleValue(for: HKUnit.init(from: .pound)))
        lineView.setNeedsDisplay()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        

    }


}

