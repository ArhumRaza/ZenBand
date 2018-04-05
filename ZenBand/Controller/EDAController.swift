//
//  EDAController.swift
//  ZenBand
//
//  Created by Arham Raza on 2018-03-21.
//  Copyright © 2018 Capstone Project. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Charts

class EDAController: UIViewController {
    
    @IBOutlet weak var chtChart: LineChartView!
    
    var numbers : [Double] = []
    var time : [Double] = []
    let sensor = GSR()
    
    var ref: DatabaseReference!
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
        labelView2.text = "Skin Resistance"
        labelView2.font = UIFont(name:"American Typewriter", size: 32.5)
        labelView2.textColor = UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)
        labelView2.translatesAutoresizingMaskIntoConstraints = false
        labelView2.textAlignment = .left
        return labelView2
    }()
    
    let titleBackground: UIView = {
        let titleColor = UIView()
        titleColor.backgroundColor = UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)
        titleColor.translatesAutoresizingMaskIntoConstraints = false
        return titleColor
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let anxietyLevel: UILabel = {
        let label = UILabel()
        label.text = "Anxiety Level"
        label.font = UIFont(name:"American Typewriter", size: 25)
        label.textColor = UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelNormal: UILabel = {
        let label = UILabel()
        label.text = "Normal"
        label.font = UIFont(name:"American Typewriter", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelModerate: UILabel = {
        let label = UILabel()
        label.text = "Moderate"
        label.font = UIFont(name:"American Typewriter", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelHigh: UILabel = {
        let label = UILabel()
        label.text = "High"
        label.font = UIFont(name:"American Typewriter", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seperatorView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let middleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let middleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)
        label.text = "EDA Threshold:"
        label.font = UIFont(name:"American Typewriter", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:1, green:1, blue:0.941, alpha:1)
        return label
    }()
    
    let midLabelValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)
        label.text = "---"
        label.textAlignment = .center
        label.font = UIFont(name:"American Typewriter", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:1, green:1, blue:0.941, alpha:1)
        return label
    }()
    
    let middleLabel2: UITextView = {
        let label = UITextView()
        label.textColor = UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)
        label.text = "Average Skin Resistance:"
        label.font = UIFont(name:"American Typewriter", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:1, green:1, blue:0.941, alpha:1)
        return label
    }()
    
    let midLabelValue2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)
        label.text = "---"
        label.textAlignment = .center
        label.font = UIFont(name:"American Typewriter", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:1, green:1, blue:0.941, alpha:1)
        return label
    }()
    
    let seperatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackground()
        fetchData()
        setUpLayout()
        setUpChart()
        
    }
    
    func setUpChart() {
        self.chtChart.translatesAutoresizingMaskIntoConstraints = false
        self.chtChart.drawGridBackgroundEnabled = false
        self.chtChart.animate(xAxisDuration: 2.5)
        chtChart.rightAxis.enabled = false
        
    }
    
    func setUpBackground() {
        view.backgroundColor = UIColor(red:1, green:1, blue:0.941, alpha:1)
        
        view.addSubview(titleBackground)
        titleBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleBackground.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    // constraints for the view for image views and labels
    func setUpLayout() {
        
        setUpTopView()
        setUpBottomView()
        setUpMiddleView()
    }
    
    func setUpTopView() {
        view.addSubview(zenBandLabel)
        view.addSubview(logoImageView)
        //        view.addSubview(calibrateButton)
        
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
        
        view.addSubview(chtChart)
        chtChart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chtChart.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 25).isActive = true
        chtChart.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        chtChart.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setUpMiddleView() {
        view.addSubview(seperatorView2)
        seperatorView2.topAnchor.constraint(equalTo: chtChart.bottomAnchor, constant: 5).isActive = true
        seperatorView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperatorView2.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(middleView)
        middleView.topAnchor.constraint(equalTo: seperatorView2.bottomAnchor, constant: 10).isActive = true
        middleView.bottomAnchor.constraint(equalTo: seperatorView3.topAnchor, constant: -10).isActive = true
        middleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        middleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        middleView.addSubview(middleLabel)
        middleView.addSubview(midLabelValue)
        middleLabel.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        middleLabel.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        middleLabel.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.5).isActive = true
        middleLabel.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.7).isActive = true
        midLabelValue.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        midLabelValue.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        midLabelValue.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.5).isActive = true
        midLabelValue.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.3).isActive = true
        
        middleView.addSubview(middleLabel2)
        middleView.addSubview(midLabelValue2)
        middleLabel2.topAnchor.constraint(equalTo: middleLabel.bottomAnchor).isActive = true
        middleLabel2.leftAnchor.constraint(equalTo: middleView.leftAnchor).isActive = true
        middleLabel2.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.5).isActive = true
        middleLabel2.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.7).isActive = true
        midLabelValue2.topAnchor.constraint(equalTo: midLabelValue.bottomAnchor).isActive = true
        midLabelValue2.rightAnchor.constraint(equalTo: middleView.rightAnchor).isActive = true
        midLabelValue2.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.5).isActive = true
        midLabelValue2.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.3).isActive = true
        
    }
    
    func setUpBottomView() {
        view.addSubview(bottomView)
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        bottomView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        bottomView.addSubview(anxietyLevel)
        bottomView.addSubview(labelNormal)
        bottomView.addSubview(labelModerate)
        bottomView.addSubview(labelHigh)
        
        anxietyLevel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        anxietyLevel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10).isActive = true
        labelNormal.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        labelNormal.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        labelModerate.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        labelModerate.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        labelHigh.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        labelHigh.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(seperatorView3)
        seperatorView3.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -5).isActive = true
        seperatorView3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperatorView3.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
    }
    
    func fetchData() {
        let gsrLow = 50
        var cntr = 0
        var gsr = 0
        var gsrCntr = 0
        let num = 1
        
        ref = Database.database().reference()
        ref.child("Values").observe(.childAdded, with: { (snapshot) in
            
            let dictionary = snapshot.value as? [String: AnyObject]
            
            //            let sensor = PPG(bpm: (dictionary!["Heart Rate"] as? Int)!, time: (dictionary!["Time"] as? Int)!, reset:(dictionary!["Sensor Reset"] as? Int)!, -threshold:(dictionary!["HR threshold"] as? Int)!, anxietyLevel:(dictionary!["Anxiety Level"] as? Int)!)
            
            self.sensor.setGsr(gsr:(dictionary!["Galvanic Skin Response"] as? Int)!)
            self.sensor.setTime(time: (dictionary!["Time"] as? Int)!)
            self.sensor.setReset(reset: (dictionary!["Sensor Reset"] as? Int)!)
            self.sensor.setThreshold(threshold: (dictionary!["GSR threshold"] as? Int)!)
            self.sensor.setAnxietyLevel(anxietyLevel: (dictionary!["Anxiety Level"] as? Int)!)
            
            if self.sensor.getThreshold() != 0{
                self.midLabelValue.text = String(self.sensor.getThreshold())
            }
            else {
                self.midLabelValue.text = "---"
            }
            
            if self.numbers.count == 0 {
                self.midLabelValue2.text = String("---")
            }
            else {
                let gsrAvg = (Double(gsrCntr))/(Double(self.numbers.count))
                self.midLabelValue2.text = String(round(10*gsrAvg)/10)
            }
            
            if  self.sensor.getAnxietyLevel() == 0 {
                self.labelNormal.textColor = .green
                self.labelNormal.font = UIFont.boldSystemFont(ofSize: 20)
                self.labelModerate.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelModerate.font = UIFont.systemFont(ofSize: 20)
                self.labelHigh.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelHigh.font = UIFont.systemFont(ofSize: 20)
            }
            if  self.sensor.getAnxietyLevel() == 1 {
                self.labelNormal.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelNormal.font = UIFont.systemFont(ofSize: 20)
                self.labelModerate.textColor = .orange
                self.labelModerate.font = UIFont.boldSystemFont(ofSize: 20)
                self.labelHigh.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelHigh.font = UIFont.systemFont(ofSize: 20)
            }
            if  self.sensor.getAnxietyLevel() == 2 {
                self.labelNormal.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelNormal.font = UIFont.systemFont(ofSize: 20)
                self.labelModerate.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelModerate.font = UIFont.systemFont(ofSize: 20)
                self.labelHigh.textColor = .red
                self.labelHigh.font = UIFont.boldSystemFont(ofSize: 20)
            }
            
            if  self.sensor.isReset() {
                self.numbers.removeAll()
                self.time.removeAll()
                cntr = 0
                gsrCntr = 0
                self.resetGraph()
            }
            
            if  self.sensor.getGsr() > gsrLow {
                gsr =  self.sensor.getGsr()

                self.numbers.append(Double( self.sensor.getGsr()))
                self.time.append(Double(cntr))
                self.updateGraph()
                cntr += num
                gsrCntr += gsr
            }
            else {
                if gsr > gsrLow {
                    self.numbers.append(Double(gsr))
                    self.time.append(Double(cntr))
                    self.updateGraph()
                }
                print("Value was nil")
                cntr += num
                gsrCntr += gsr
            }
            
            print("GSR: ", self.sensor.getGsr() as Any, "\tTime: ",  self.sensor.getTime() as Any, "\tReset: ",  self.sensor.isReset() as Any)
            
        }, withCancel: nil)
    }
    
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        //here is the for loop
        for i in 0..<numbers.count {
            
            let value = ChartDataEntry(x: Double(time[i]), y: Double(numbers[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)] //Sets the colour
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = false
        line1.drawIconsEnabled = false
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart.chartDescription?.text = " "
        
        //        chtChart.chartDescription?.text = "Heart Rate" // Here we set the description for the graph
    }
    
    func resetGraph(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        //here is the for loop
        for i in 0..<numbers.count {
            
            let value = ChartDataEntry(x: Double(time[i]), y: Double(numbers[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)] //Sets the colour
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = false
        line1.drawIconsEnabled = false
        line1.notifyDataSetChanged()
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        data.notifyDataChanged()
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart.notifyDataSetChanged()
        chtChart.chartDescription?.text = "Data is being reset"
        //        chtChart.chartDescription?.text = "Heart Rate" // Here we set the description for the graph
    }

}

