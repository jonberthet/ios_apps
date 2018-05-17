//
//  HealthManager.swift
//  Weight
//
//  Created by Jonathan Berthet on 5/17/18.
//  Copyright © 2018 DevFright.com. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager {
    public let healthStore = HKHealthStore()
    
    public func requestPermissions() {
        let readDataTypes : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!]
        
        healthStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: { (success, error) in
            if success {
                print("Auth compete")
                self.fetchWeightData()
            } else {
                print("Auth error: \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
    func fetchWeightData() {
        print("Fetching weight data")
        
        let quantityType : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!]
        
        let startDate = Date.init(timeIntervalSinceNow: -7*24*60*60)
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                    end: endDate,
                                                    options: .strictStartDate)
        
        let sampleQuery = HKSampleQuery.init(sampleType: quantityType.first!,
                                             predicate: predicate,
                                             limit: HKObjectQueryNoLimit,
                                             sortDescriptors: nil,
                                             resultsHandler: { (query, results, error) in
                                                DispatchQueue.main.async(execute: {
                                                    NotificationCenter.default.post(name:
                                                        NSNotification.Name(rawValue: "BodyMassDataAvailable"),
                                                                                    object:results as! [HKQuantitySample],
                                                                                    userInfo: nil)
                                                })
        })
        self.healthStore .execute(sampleQuery)
    }
    

    
}
