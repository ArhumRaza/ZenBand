//
//  HeartRateController.swift
//  ZenBand
//
//  Created by Arham Raza on 2018-03-21.
//  Copyright © 2018 Capstone Project. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HeartRateController: UIViewController {
    
    var ref: DatabaseReference!
    
    var ppgSensor = [PPG]()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ZenBandLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let zenBandLabel: UILabel = {
        let labelView = UILabel()
        labelView.text = "ZEN BAND"
        labelView.font = UIFont(name:"Arial Rounded MT Bold", size: 35)
        labelView.textColor = UIColor(red:1, green:1, blue:0.930, alpha:1)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.textAlignment = .center
        return labelView
    }()
    
    let viewTitle: UILabel = {
        let labelView2 = UILabel()
        labelView2.text = "Heart"
        labelView2.font = UIFont(name:"American Typewriter", size: 32.5)
        labelView2.textColor = UIColor(red:0.502, green:0, blue:0.251, alpha:1)
        labelView2.translatesAutoresizingMaskIntoConstraints = false
        labelView2.textAlignment = .left
        return labelView2
    }()
    
    let titleBackground: UIView = {
        let titleColor = UIView()
        titleColor.backgroundColor = UIColor(red:0.502, green:0, blue:0.251, alpha:1)
        titleColor.translatesAutoresizingMaskIntoConstraints = false
        return titleColor
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let heartRateText: UILabel = {
        let hrText = UILabel()
        hrText.text = "Value"
        hrText.font = UIFont(name:"American Typewriter", size: 32.5)
        hrText.translatesAutoresizingMaskIntoConstraints = false
        return hrText
    }()
    
    let calibrateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calibrate", for: .normal)
        button.setTitleColor(UIColor(red:0.502, green:0, blue:0.251, alpha:1), for: .normal)
        button.titleLabel?.font = UIFont(name:"American Typewriter", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBackground()
        setUpLayout()
        fetchData()
    }
    
    func fetchData() {
        
        //var hrLow = 40
        
        ref = Database.database().reference()
        ref.child("Values").observe(.childAdded, with: { (snapshot) in
            
            let dictionary = snapshot.value as? [String: AnyObject]
            let sensor = PPG(bpm: (dictionary!["Heart Rate"] as? Int)!, time: (dictionary!["Time"] as? Int)!)
            let sensor2 = GSR(gsr: (dictionary!["Galvanic Skin Response"] as? Int)!, time: (dictionary!["Time"] as? Int)!)
            print("BPM: ",sensor.getBpm() as Any, "\tTime: ", sensor.getTime() as Any)
            print("GSR: ",sensor2.getGSR() as Any, "\tTime: ", sensor2.getTime() as Any)
//            if sensor.bpm! > hrLow {
//
//            }
            
        }, withCancel: nil)
    }

    private func setUpBackground() {
        
        view.backgroundColor = UIColor(red:1, green:1, blue:0.941, alpha:1)
        
        view.addSubview(titleBackground)
        titleBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleBackground.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    
    // constraints for the view for image views and labels
    private func setUpLayout() {
        
        view.addSubview(zenBandLabel)
        view.addSubview(logoImageView)
        view.addSubview(calibrateButton)

        zenBandLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        zenBandLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        zenBandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        
        
        //Seperating title with content
        view.addSubview(seperatorView)
        seperatorView.topAnchor.constraint(equalTo: titleBackground.bottomAnchor, constant: 70).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        view.addSubview(viewTitle)
        viewTitle.bottomAnchor.constraint(equalTo: seperatorView.topAnchor, constant: -5).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        calibrateButton.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 5).isActive = true
        calibrateButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        calibrateButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        calibrateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        view.addSubview(heartRateText)
        heartRateText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        heartRateText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

}


