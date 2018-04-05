//
//  Sensors.swift
//  ZenBand
//
//  Created by Arham Raza on 2018-03-26.
//  Copyright © 2018 Capstone Project. All rights reserved.
//

import UIKit

//var anxietyDetection = Int

class PPG: NSObject {
    
    var bpm: Int
    var time: Int
    var reset: Int
    var threshold: Int
    var anxietyLevel: Int
    
//    init (bpm: Int, time: Int, reset: Int, threshold: Int, anxietyLevel: Int) {
//        self.bpm = bpm
//        self.time = time
//        self.reset = reset
//        self.threshold = threshold
//        self.anxietyLevel = anxietyLevel
//    }
    
    override init () {
        self.bpm = 0
        self.time = 0
        self.reset = 0
        self.threshold = 0
        self.anxietyLevel = 0
    }
    
    func getBpm () -> Int {
        return self.bpm
    }
    
    func setBpm(bpm: Int) {
        self.bpm = bpm
    }
    
    func getTime () -> Int {
        return self.time
    }
    
    func setTime(time: Int) {
        self.time = time
    }
    
    func isReset () -> Bool {
        if self.reset == 1 {
            return true
        }
        else {
            return false
        }
    }
    
    func setReset(reset: Int) {
        self.reset = reset
    }
    
    func getThreshold () -> Int {
        return self.threshold
    }
    
    func setThreshold(threshold: Int) {
        self.threshold = threshold
    }
    
    func getAnxietyLevel () -> Int {
        return self.anxietyLevel
    }
    
    func setAnxietyLevel(anxietyLevel: Int) {
        self.anxietyLevel = anxietyLevel
    }

}

class GSR: NSObject {
    
    var gsr: Int
    var time: Int
    var reset: Int
    var threshold: Int
    var anxietyLevel: Int
    
//    init (gsr: Int, time: Int, reset: Int, threshold: Int, anxietyLevel: Int){
//        self.gsr = gsr
//        self.time = time
//        self.reset = reset
//        self.threshold = threshold
//        self.anxietyLevel = anxietyLevel
//    }
    
    override init () {
        self.gsr = 0
        self.time = 0
        self.reset = 0
        self.threshold = 0
        self.anxietyLevel = 0
    }
    
    func getGsr () -> Int {
        return self.gsr
    }
    
    func setGsr(gsr: Int) {
        self.gsr = gsr
    }
    
    func getTime () -> Int {
        return self.time
    }
    
    func setTime(time: Int) {
        self.time = time
    }
    
    func isReset () -> Bool {
        if self.reset == 1 {
            return true
        }
        else {
            return false
        }
    }
    
    func setReset(reset: Int) {
        self.reset = reset
    }
    
    func getThreshold () -> Int {
        return self.threshold
    }
    
    func setThreshold(threshold: Int) {
        self.threshold = threshold
    }
    
    func getAnxietyLevel () -> Int {
        return self.anxietyLevel
    }
    
    func setAnxietyLevel(anxietyLevel: Int) {
        self.anxietyLevel = anxietyLevel
    }
    
}

class Thermistor: NSObject {
    
    var temp: Double
    var time: Int
    var reset: Int
    var threshold: Double
    var anxietyLevel: Int
    
//    init (temp: Int, time: Int, reset: Int, threshold: Int, anxietyLevel: Int){
//        self.temp = temp
//        self.time = time
//        self.reset = reset
//        self.threshold = threshold
//        self.anxietyLevel = anxietyLevel
//    }
    
    override init () {
        self.temp = 0.0
        self.time = 0
        self.reset = 0
        self.threshold = 0
        self.anxietyLevel = 0
    }
    
    func getTemp () -> Double {
        return self.temp
    }
    
    func setTemp(temp: Double) {
        self.temp = temp
    }
    
    func getTime () -> Int {
        return self.time
    }
    
    func setTime(time: Int) {
        self.time = time
    }
    
    func isReset () -> Bool {
        if self.reset == 1 {
            return true
        }
        else {
            return false
        }
    }
    
    func setReset(reset: Int) {
        self.reset = reset
    }
    
    func getThreshold () -> Double {
        return self.threshold
    }
    
    func setThreshold(threshold: Double) {
        self.threshold = threshold
    }
    
    func getAnxietyLevel () -> Int {
        return self.anxietyLevel
    }
    
    func setAnxietyLevel(anxietyLevel: Int) {
        self.anxietyLevel = anxietyLevel
    }
}

class Accel: NSObject {
    
    var activity: Int
    var time: Int
    var reset: Int
    var anxietyLevel: Int
    
//    init (accelerometer: String, time: Int, reset: Int, anxietyLevel: Int){
//        self.accelerometer = accelerometer
//        self.time = time
//        self.reset = reset
//        self.anxietyLevel = anxietyLevel
//    }

    override init () {
        self.activity = 0
        self.time = 0
        self.reset = 0
        self.anxietyLevel = 0
    }
    func getActivity () -> Int {
        return self.activity
    }
    
    func setActivity(activity: Int) {
        self.activity = activity
    }
    
    func getTime () -> Int {
        return self.time
    }
    
    func setTime(time: Int) {
        self.time = time
    }
    
    func isReset () -> Bool {
        if self.reset == 1 {
            return true
        }
        else {
            return false
        }
    }
    
    func setReset(reset: Int) {
        self.reset = reset
    }
    
    func getAnxietyLevel () -> Int {
        return self.anxietyLevel
    }
    
    func setAnxietyLevel(anxietyLevel: Int) {
        self.anxietyLevel = anxietyLevel
    }
    
}

