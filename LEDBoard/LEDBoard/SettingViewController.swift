//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by young june Park on 2021/12/30.
//

import UIKit

protocol LEDBoardSettingDelegate : AnyObject {
    func chagedSetting(text : String? , textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    weak var delegate : LEDBoardSettingDelegate?
    var ledText : String?
    var textColor : UIColor = .yellow
    var backgroundColor : UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

    }
    
    private func configureView(){
        if let ledText = ledText {
            self.textField.text = ledText
            
        }
        self.chageTextColor(color: self.textColor)
        self.chageBackgroundColor(color: self.backgroundColor)
    }
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender == self.yellowButton {
            self.chageTextColor(color: .yellow)
            self.textColor = .yellow
        }
        else if sender == self.purpleButton{
            self.chageTextColor(color: .purple)
            self.textColor = .purple
        }else {
            self.chageTextColor(color: .green)
            self.textColor = .green
        }
    }
    
  
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        if sender == self.blackButton {
            self.chageBackgroundColor(color: .black)
            self.backgroundColor = .black
        }
        else if sender == self.blueButton{
            self.chageBackgroundColor(color: .blue)
            self.backgroundColor = .blue
        }else {
            self.chageBackgroundColor(color: .orange)
            self.backgroundColor = .orange
        }
        
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.delegate?.chagedSetting(text: self.textField.text, textColor: self.textColor, backgroundColor: self.backgroundColor)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func chageTextColor(color : UIColor){
        self.yellowButton.alpha = color == UIColor.yellow ? 1:0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1:0.2
        self.greenButton.alpha = color == UIColor.green ? 1:0.2
    }
    private func chageBackgroundColor(color : UIColor){
        self.blackButton.alpha = color == UIColor.black ? 1:0.2
        self.blueButton.alpha = color == UIColor.blue ? 1:0.2
        self.orangeButton.alpha = color == UIColor.orange ? 1:0.2
    }
    
    
}
