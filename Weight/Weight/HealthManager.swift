//
//  HealthManager.swift
//  Weight
//
//  Created by Jonathan Berthet on 5/17/18.
//  Copyright © 2018 DevFright.com. All rights reserved.
// Git Comment

import Foundation
import HealthKit
import CloudKit

class HealthManager {
    public let healthStore = HKHealthStore()
    

    
    public func requestPermissions() {
        
       //List All HK datatypes to ask for permission
        let readDataTypes : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
                                   HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                                   HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!]
        
        healthStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: { (success, error) in
            if success {
                print("Auth compete")
//                self.fetchWeightData()
//                self.fetchHeightData()
                self.fetchTheData(TypeIdentifier: HKQuantityTypeIdentifier.bodyMass.rawValue, NotificationName: "BodyMassDataAvailable")
                self.fetchTheData(TypeIdentifier: HKQuantityTypeIdentifier.height.rawValue, NotificationName: "HeightDataAvailable")
                self.fetchTheData(TypeIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage.rawValue, NotificationName: "BodyFatPercentageDataAvailable")
            } else {
                print("Auth error: \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
//    func fetchWeightData() {
//        print("Fetching weight data")
//
//        let quantityType : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!]
//
//        let startDate = Date.init(timeIntervalSinceNow: -7*24*60*60)
//        let endDate = Date()
//
//        let predicate = HKQuery.predicateForSamples(withStart: startDate,
//                                                    end: endDate,
//                                                    options: .strictStartDate)
//
//
//        //FI
//        let sampleQuery = HKSampleQuery.init(sampleType: quantityType.first!,
//                                             predicate: predicate,
//                                             limit: HKObjectQueryNoLimit,
//                                             sortDescriptors: nil,
//                                             resultsHandler: { (query, results, error) in
//                                                DispatchQueue.main.async(execute: {
//                                                    NotificationCenter.default.post(name:
//                                                        NSNotification.Name(rawValue: "BodyMassDataAvailable"),
//                                                                                    object:results as! [HKQuantitySample],
//                                                                                    userInfo: nil)
//                                                })
//        })
//        self.healthStore .execute(sampleQuery)
//    }
//
//
//    func fetchHeightData() {
//        print("Fetching heart rate data")
//
//        let quantityType : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!]
//
//        let startDate = Date.init(timeIntervalSinceNow: -7*24*60*60)
//        let endDate = Date()
//
//        let predicate = HKQuery.predicateForSamples(withStart: startDate,
//                                                    end: endDate,
//                                                    options: .strictStartDate)
//
//        let sampleQuery = HKSampleQuery.init(sampleType: quantityType.first!,
//                                             predicate: predicate,
//                                             limit: HKObjectQueryNoLimit,
//                                             sortDescriptors: nil,
//                                             resultsHandler: { (query, results, error) in
//                                                DispatchQueue.main.async(execute: {
//                                                    NotificationCenter.default.post(name:
//                                                        NSNotification.Name(rawValue: "HeightDataAvailable"),
//                                                                                    object:results as! [HKQuantitySample],
//                                                                                    userInfo: nil)
//                                                })
//        })
//        self.healthStore .execute(sampleQuery)
//    }
    
    
    
    func fetchTheData(TypeIdentifier: String, NotificationName: String) {
        print("Fetching BodyFatPercentage data")
        
        let quantityType : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier(rawValue: TypeIdentifier))!]
        
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
                                                        NSNotification.Name(rawValue: NotificationName),
                                                                                    object:results as! [HKQuantitySample],
                                                                                    userInfo: nil)
                                                })
        })
        self.healthStore .execute(sampleQuery)
    }
    
    
    
    
    
    
    
    
    
}
