//
//  HealthKit.swift
//  HealthTest
//
//  Created by TechCampus on 8/19/20.
//  Copyright © 2020 TechCampus. All rights reserved.
//

import Foundation
import HealthKit

class HealthKit {
    
   //to store health data
    var healthStore: HKHealthStore?
    //gets the user biological data (gender)
    var bioSexCharacteristicType: HKCharacteristicType? = HKCharacteristicType.characteristicType(forIdentifier: .biologicalSex)
    var dOBCharacteristicType: HKCharacteristicType? = HKCharacteristicType.characteristicType(forIdentifier: .dateOfBirth)
    
    let multipleCharacteristics: Set<HKCharacteristicType>?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = HKHealthStore()
            if let bioSex = bioSexCharacteristicType, let dob = dOBCharacteristicType {
                multipleCharacteristics = [bioSex, dob]
                healthStore?.requestAuthorization(toShare: nil, read: multipleCharacteristics, completion: { (isSuccess, error) in
                    if isSuccess {
                        print("successful result")
                        self.readCharacteristics()
                    } else {
                        print(error?.localizedDescription ?? "error occured but nil localized description")
                    }
                })
            } else {
                self.healthStore = nil
                multipleCharacteristics = nil
            }
        } else {
            self.healthStore = nil
            multipleCharacteristics = nil
        }
    }
    
    func readCharacteristics() {
        do {
            let gender = try self.healthStore?.biologicalSex()
            let dob = try self.healthStore?.dateOfBirthComponents()
            print(dob?.date ?? "")
            if gender?.biologicalSex == .female {
                print("gender is female")
            } else {
                print("gender is male")
            }
        } catch {
            print("error while getting data for gender")
        }
    }
}
