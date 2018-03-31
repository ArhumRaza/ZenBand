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
import Charts

class HeartRateController: UIViewController {
    
    @IBOutlet weak var chtChart: UIView!
    @IBOutlet weak var txtTextBox: UITextField!
    var ref: DatabaseReference!
    
    var sensor = [Sensors]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red:1, green:1, blue:0.941, alpha:1)
        setUpBackground()
        setUpLayout()
        fetchData()
    }
    
    func fetchData() {
        
        ref = Database.database().reference()
//        ref.child("Values").observe(DataEventType.childAdded, with: { (snapshot) in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            print(postDict["Heart Rate"])
//            self.heartRateText.text = String(describing: postDict["Heart Rate"])
//
//        })
        
        ref.child("Values").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let sensor = Sensors()
                sensor.bpmHeart = dictionary["Heart Rate"] as? Int
                sensor.time = dictionary["Time"] as? Int
                print(sensor.bpmHeart as Any, sensor.time as Any)
            }
            
            //print("Sensor Data:")
            //print(snapshot)
        }, withCancel: nil)
    }

    private func setUpBackground() {
        
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
        
        view.addSubview(heartRateText)
        heartRateText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        heartRateText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

    @IBAction func btnbutton(_ sender: Any) {
    }
    
}


