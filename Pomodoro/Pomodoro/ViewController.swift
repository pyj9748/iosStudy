//
//  ViewController.swift
//  Pomodoro
//
//  Created by young june Park on 2022/01/03.
//

import UIKit
import AudioToolbox
enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    var duration = 60
    var timerStatus :TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }

    func stopTimer(){
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        self.timer?.cancel()
        self.timer = nil
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity
        })
        self.toggleButton.isSelected = false
        
    }
    
    func startTimer(){
        if self.timer == nil {
            
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else {return}
                
                self.currentSeconds -= 1
                
                let hour = self.currentSeconds / 3600
                let min = (self.currentSeconds  % 3600 ) / 60
                let sec = (self.currentSeconds % 60)
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour,min,sec)
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                UIView.animate(withDuration: 0.5, delay: 0,animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                })
                UIView.animate(withDuration: 0.5, delay: 0.5,animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
                })
                if self.currentSeconds <= 0 {
               
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                }
                
            })
            self.timer?.resume()
        }
        
        
    }
    func setTimerInfoViewVisable( isHidden : Bool){
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
        
    }
    func configureToggleButton(){
        
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    }

    @IBAction func tacCancelButton(_ sender: UIButton) {
        switch self.timerStatus{
        case .start , .pause:
          
            self.stopTimer()
        default :
            break
            
        }
    }
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration)
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
          
            UIView.animate(withDuration: 0.5, animations: {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            })
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true
            self.startTimer()
        case .start :
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            self.timer?.suspend()
        case .pause :
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
            
        
        }
        
    }
}

