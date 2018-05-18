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
        
        
        
        //add an observer that listens out for BodyMassDataAvaialble. When triggered, it calls updateGraph(notification:) selector
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateGraph(notification:)),
                                               name: NSNotification.Name(rawValue: "BodyMassDataAvailable"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateGraph(notification:)),
                                               name: NSNotification.Name(rawValue: "HeightDataAvailable"),
                                               object: nil)
        
        //New datq
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateGraph(notification:)),
                                               name: NSNotification.Name(rawValue: "BodyFatPercentageDataAvailable"),
                                               object: nil)
        
        if HKHealthStore.isHealthDataAvailable() {
            print("Yes, HK is available")
            let healthManager = HealthManager()
            healthManager.requestPermissions()
        } else {
            print("darn, HK is NOT available. Problem accessing it")
        }
        
        
        
        
    }
    
    

    func updateGraph(notification: Notification) {
        print("Name: \(notification.name)")
//        print("Here's my data: \(notification.object!)")
        let weightArray = notification.object as! Array<HKQuantitySample>
        
        //Send weightArray to cloud
        print("2nd bunch of data: \(weightArray)")
        
//        // Find the HKQuantitySample with the largest quantity.
//        let maxSample = weightArray.max { a, b in a.quantity.doubleValue(for: HKUnit.init(from: .pound)) < b.quantity.doubleValue(for: HKUnit.init(from: .pound)) }
//
//        lineView.height = CGFloat.init(100 * ceil((maxSample?.quantity.doubleValue(for: HKUnit.init(from: .pound)))!/100))
//        lineView.point0 = CGFloat.init(weightArray[0].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point1 = CGFloat.init(weightArray[1].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point2 = CGFloat.init(weightArray[2].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point3 = CGFloat.init(weightArray[3].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point4 = CGFloat.init(weightArray[4].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point5 = CGFloat.init(weightArray[5].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.point6 = CGFloat.init(weightArray[6].quantity.doubleValue(for: HKUnit.init(from: .pound)))
//        lineView.setNeedsDisplay()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

