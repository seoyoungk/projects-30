//
//  ViewController.swift
//  StopWatch
//
//  Created by Seoyoung on 10/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    let mainStopWatch: StopWatch = StopWatch()
    let lapStopWatch: StopWatch = StopWatch()
    var isPlay = false
    var lap = [String]()
    

    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var startPauseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapResetButton.isEnabled = false
    }

    @IBAction func lapReset(_ sender: Any) {
        if !isPlay {
            mainResetTimer()
            lapResetTimer()
            lapResetButton.setTitle("Lap", for: .normal)
            lapResetButton.isEnabled = false
        }else {
            if let timeLabelText = timerLabel.text{
                lap.append(timeLabelText)
            }
            // tableView.reloadData()
            lapResetTimer()
            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(lapUpdateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func startPause(_ sender: AnyObject) {
        lapResetButton.isEnabled = true
        lapResetButton.setTitle("Lap", for: .normal)
        
        if !isPlay{
            mainStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(mainUpdateTimer), userInfo: nil, repeats: true)
            
            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(lapUpdateTimer), userInfo: nil, repeats: true)
            
            RunLoop.current.add(mainStopWatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoop.Mode.common)

            isPlay = true
            startPauseButton.setTitle("Stop", for: .normal)
        }else {
            mainStopWatch.timer.invalidate()
            lapStopWatch.timer.invalidate()
            
            isPlay = false
            startPauseButton.setTitle("Start", for: .normal)
            lapResetButton.setTitle("Reset", for: .normal)
        }
    }
    
    @objc func mainUpdateTimer() {      //main Timer 업데이트 !!
        mainStopWatch.count += 0.01
        timerLabel.text = String(format: "%.2f", mainStopWatch.count)
    }
    
    @objc func lapUpdateTimer() {
        lapStopWatch.count += 0.01
        lapTimerLabel.text = String(format: "%.2f", lapStopWatch.count)
        
    }
    
    func mainResetTimer(){
        mainStopWatch.count = 0.0
        mainStopWatch.timer.invalidate()
        lap.removeAll()
        tableView.reloadData()
        timerLabel.text = "00:00:00"
        lapTimerLabel.text = "00:00:00"
        
    }
    func lapResetTimer(){
        lapStopWatch.count = 0.0
        lapStopWatch.timer.invalidate()
        lapTimerLabel.text = "00:00:00"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
}

