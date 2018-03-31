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
    
    init (bpm: Int, time: Int){
        self.bpm = bpm
        self.time = time
    }
    
    func getBpm () -> Int {
        return self.bpm
    }
    
    func getTime () -> Int {
        return self.time
    }

}

class GSR: NSObject {
    
    var gsr: Int
    var time: Int
    
    init (gsr: Int, time: Int){
        self.gsr = gsr
        self.time = time
    }
    
    func getGSR () -> Int {
        return self.gsr
    }
    
    func getTime () -> Int {
        return self.time
    }

    
}

class Thermistor: NSObject {
    
    var temp: Int
    var time: Int
    
    init (temp: Int, time: Int){
        self.temp = temp
        self.time = time
    }
    
    func getTemp () -> Int {
        return self.temp
    }
    
    func getTime () -> Int {
        return self.time
    }

}

class Accel: NSObject {
    
    var accelerometer: String
    var time: Int
    
    init (accelerometer: String, time: Int){
        self.accelerometer = accelerometer
        self.time = time
    }
    
    func getAccelerometer () -> String {
        return self.accelerometer
    }
    
    func getTime () -> Int {
        return self.time
    }

}

