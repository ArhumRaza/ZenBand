//
//  StepsTakenController.swift
//  ZenBand
//
//  Created by Arham Raza on 2018-03-26.
//  Copyright © 2018 Capstone Project. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Charts
import AVFoundation

class StepsTakenController: UIViewController {
    
    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var chtChart2: LineChartView!
    @IBOutlet weak var chtChart3: LineChartView!
    
    var audioPlayer = AVAudioPlayer()
    
    var numbers : [Double] = []
    var time : [Double] = []
    let sensor = PPG()
    
    var numbers2 : [Double] = []
    var time2 : [Double] = []
    let sensor2 = GSR()
    
    var numbers3 : [Double] = []
    var time3 : [Double] = []
    let sensor3 = Thermistor()
    
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
        labelView2.text = "Dashboard"
        labelView2.font = UIFont(name:"American Typewriter", size: 32.5)
        labelView2.textColor = UIColor(red:0.000, green:0.502, blue:0.251, alpha:1)
        labelView2.translatesAutoresizingMaskIntoConstraints = false
        labelView2.textAlignment = .left
        return labelView2
    }()
    
    let titleBackground: UIView = {
        let titleColor = UIView()
        titleColor.backgroundColor = UIColor(red:0.000, green:0.502, blue:0.251, alpha:1)
        titleColor.translatesAutoresizingMaskIntoConstraints = false
        return titleColor
    }()
    
    let bottomSegment: UIView = {
        let segment = UIView()
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
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
        label.textColor = UIColor(red:0.000, green:0.502, blue:0.251, alpha:1)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackground()
        fetchData()
        setUpChart()
        setUpLayout()
        
        do{
            
            audioPlayer = try AVAudioPlayer.init(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "alphaWaves10Hz", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
        
    }
    
    func setUpChart() {
        self.chtChart.translatesAutoresizingMaskIntoConstraints = false
        self.chtChart.drawGridBackgroundEnabled = false
        self.chtChart.animate(xAxisDuration: 2.5)
        chtChart.rightAxis.enabled = false
        chtChart.leftAxis.maxWidth = 35
        
        self.chtChart2.translatesAutoresizingMaskIntoConstraints = false
        self.chtChart2.drawGridBackgroundEnabled = false
        self.chtChart2.animate(xAxisDuration: 2.5)
        chtChart2.rightAxis.enabled = false
        chtChart2.leftAxis.maxWidth = 35
        
        self.chtChart3.translatesAutoresizingMaskIntoConstraints = false
        self.chtChart3.drawGridBackgroundEnabled = false
        self.chtChart3.animate(xAxisDuration: 2.5)
        chtChart3.rightAxis.enabled = false
        chtChart3.leftAxis.maxWidth = 35
//        chtChart3.setVisibleYRangeMaximum(40, axis: YAxis.AxisDependency)
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
        
    }
    
    func setUpMiddleView() {
        view.addSubview(middleView)
        middleView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 10).isActive = true
        middleView.bottomAnchor.constraint(equalTo: seperatorView3.topAnchor, constant: -10).isActive = true
        middleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        middleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        
        middleView.addSubview(chtChart)
        chtChart.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        chtChart.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        chtChart.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        chtChart.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.33).isActive = true
        
        middleView.addSubview(chtChart2)
        chtChart2.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        chtChart2.centerYAnchor.constraint(equalTo: middleView.centerYAnchor).isActive = true
        chtChart2.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        chtChart2.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.33).isActive = true
        
        middleView.addSubview(chtChart3)
        chtChart3.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        chtChart3.bottomAnchor.constraint(equalTo: middleView.bottomAnchor).isActive = true
        chtChart3.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        chtChart3.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.33).isActive = true
    }
    
    func setUpBottomView() {
        view.addSubview(bottomView)
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        bottomView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        bottomView.addSubview(anxietyLevel)
        bottomView.addSubview(labelNormal)
        bottomView.addSubview(labelModerate)
        bottomView.addSubview(labelHigh)
        
        anxietyLevel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        anxietyLevel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 2).isActive = true
        
        labelNormal.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: 10).isActive = true
        labelNormal.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        
        labelModerate.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        labelModerate.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: 10).isActive = true
        
        labelHigh.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: 10).isActive = true
        labelHigh.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(seperatorView3)
        seperatorView3.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -5).isActive = true
        seperatorView3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperatorView3.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    }
    
    func fetchData() {
        var cntr = 0
        var cntr2 = 0
        var cntr3 = 0
        let num = 1
        
        let hrLow = 45
        var bpm = 0
//        var bpmCntr = 0
        
        let gsrLow = 50
        var gsr = 0
//        var gsrCntr = 0
        
        let tempLow = 10.0
        var temp = 0.0
//        var tempCntr = 0
        
        ref = Database.database().reference()
        ref.child("Values").observe(.childAdded, with: { (snapshot) in
            
            let dictionary = snapshot.value as? [String: AnyObject]
            
            //            let sensor = PPG(bpm: (dictionary!["Heart Rate"] as? Int)!, time: (dictionary!["Time"] as? Int)!, reset:(dictionary!["Sensor Reset"] as? Int)!, threshold:(dictionary!["HR threshold"] as? Int)!, anxietyLevel:(dictionary!["Anxiety Level"] as? Int)!)
            
            self.sensor.setBpm(bpm: (dictionary!["Heart Rate"] as? Int)!)
            self.sensor.setTime(time: (dictionary!["Time"] as? Int)!)
            self.sensor.setReset(reset: (dictionary!["Sensor Reset"] as? Int)!)
            self.sensor.setAnxietyLevel(anxietyLevel: (dictionary!["Anxiety Level"] as? Int)!)
            
            self.sensor2.setGsr(gsr:(dictionary!["Galvanic Skin Response"] as? Int)!)
            self.sensor3.setTemp(temp:(dictionary!["Skin temperature"] as? Double)!)

            
            if  self.sensor.isReset() {
                self.numbers.removeAll()
                self.time.removeAll()
                cntr = 0
                self.resetGraph()
                
                self.numbers2.removeAll()
                self.time2.removeAll()
                cntr2 = 0
                self.resetGraph2()
                
                self.numbers3.removeAll()
                self.time3.removeAll()
                cntr3 = 0
                self.resetGraph3()
            }
            
            if  self.sensor.getAnxietyLevel() == 0 {
                self.labelNormal.textColor = .green
                self.labelNormal.font = UIFont.boldSystemFont(ofSize: 20)
                self.labelModerate.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelModerate.font = UIFont.systemFont(ofSize: 20)
                self.labelHigh.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelHigh.font = UIFont.systemFont(ofSize: 20)
                
                self.audioPlayer.stop()
            }
            if  self.sensor.getAnxietyLevel() == 1 {
                self.labelNormal.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelNormal.font = UIFont.systemFont(ofSize: 20)
                self.labelModerate.textColor = .orange
                self.labelModerate.font = UIFont.boldSystemFont(ofSize: 20)
                self.labelHigh.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelHigh.font = UIFont.systemFont(ofSize: 20)
                
                self.audioPlayer.stop()
            }
            if  self.sensor.getAnxietyLevel() == 2 {
                self.labelNormal.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelNormal.font = UIFont.systemFont(ofSize: 20)
                self.labelModerate.textColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
                self.labelModerate.font = UIFont.systemFont(ofSize: 20)
                self.labelHigh.textColor = .red
                self.labelHigh.font = UIFont.boldSystemFont(ofSize: 20)
                
                self.audioPlayer.play()
            }
            
            if  self.sensor.getBpm() > hrLow{
                bpm =  self.sensor.getBpm()
                self.numbers.append(Double(self.sensor.getBpm()))
                self.time.append(Double(cntr))
                self.updateGraph()
                cntr += num
            }
            else {
                if bpm > hrLow {
                    self.numbers.append(Double(bpm))
                    self.time.append(Double(cntr))
                    self.updateGraph()
                }
                print("Value was nil")
                cntr += num
            }
            if self.sensor2.getGsr() > gsrLow {
                gsr =  self.sensor2.getGsr()
                self.numbers2.append(Double(self.sensor2.getGsr()))
                self.time2.append(Double(cntr2))
                self.updateGraph2()
                //gsrCntr += gsr
                cntr2 += num
            }
            else {
                if gsr > gsrLow {
                    self.numbers2.append(Double(gsr))
                    self.time2.append(Double(cntr2))
                    self.updateGraph2()
                }
                print("Value was nil")
                cntr2 += num
            }
            if self.sensor3.getTemp() > tempLow {
                temp =  self.sensor3.getTemp()
                self.numbers3.append(Double(self.sensor3.getTemp()))
                self.time3.append(Double(cntr3))
                self.updateGraph3()
                cntr3 += num
            }
            else {
                if temp > tempLow {
                    self.numbers3.append(Double(temp))
                    self.time3.append(Double(cntr3))
                    self.updateGraph3()
                }
                print("Value was nil")
                cntr3 += num
            }
            
            print("BPM: ", self.sensor.getBpm() as Any, "\tTime: ",  self.sensor.getTime() as Any, "\tReset: ",  self.sensor.isReset() as Any)
            
            print("GSR: ", self.sensor2.getGsr() as Any, "\tTime: ",  self.sensor.getTime() as Any, "\tReset: ",  self.sensor.isReset() as Any)
            
            print("Skin Temp: ", self.sensor3.getTemp() as Any, "\tTime: ",  self.sensor.getTime() as Any, "\tReset: ",  self.sensor.isReset() as Any)
            
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
        line1.colors = [UIColor(red:0.502, green:0, blue:0.251, alpha:1)] //Sets the colour
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
        line1.colors = [UIColor(red:0.502, green:0, blue:0.251, alpha:1)] //Sets the colour
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
    
    func updateGraph2(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        //here is the for loop
        for i in 0..<numbers2.count {
            
            let value = ChartDataEntry(x: Double(time2[i]), y: Double(numbers2[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [UIColor(red:0.000, green:0.251, blue:0.502, alpha:1)] //Sets the colour
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = false
        line1.drawIconsEnabled = false
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
        chtChart2.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart2.chartDescription?.text = " "
        
        //        chtChart.chartDescription?.text = "Heart Rate" // Here we set the description for the graph
    }
    
    func resetGraph2(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        //here is the for loop
        for i in 0..<numbers2.count {
            
            let value = ChartDataEntry(x: Double(time2[i]), y: Double(numbers2[i])) // here we set the X and Y status in a data chart entry
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
        
        chtChart2.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart2.notifyDataSetChanged()
        chtChart2.chartDescription?.text = "Data is being reset"
        //        chtChart.chartDescription?.text = "Heart Rate" // Here we set the description for the graph
    }
    
    func updateGraph3(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        //here is the for loop
        for i in 0..<numbers3.count {
            
            let value = ChartDataEntry(x: Double(time3[i]), y: Double(numbers3[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [UIColor(red:1.000, green:0.800, blue:0.200, alpha:1)] //Sets the colour
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = false
        line1.drawIconsEnabled = false
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
        chtChart3.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart3.chartDescription?.text = " "
        
        //        chtChart.chartDescription?.text = "Heart Rate" // Here we set the description for the graph
    }
    
    func resetGraph3(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        //here is the for loop
        for i in 0..<numbers3.count {
            
            let value = ChartDataEntry(x: Double(time3[i]), y: Double(numbers3[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [UIColor(red:1.000, green:0.800, blue:0.200, alpha:1)] //Sets the colour
        line1.drawCirclesEnabled = false
        line1.drawValuesEnabled = false
        line1.drawIconsEnabled = false
        line1.notifyDataSetChanged()
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        data.notifyDataChanged()
        
        chtChart3.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart3.notifyDataSetChanged()
        chtChart3.chartDescription?.text = "Data is being reset"
        //        chtChart.chartDescription?.text = "Heart Rate" // Here we set the description for the graph
    }
    
}
