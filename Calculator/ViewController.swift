//
//  ViewController.swift
//  Calculator
//
//  Created by Daiyu Zhang on 4/13/17.
//  Copyright © 2017 Daiyu Zhang. All rights reserved.
//

import UIKit
import Amplitude_iOS

class ViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tipThree: UIButton!
    @IBOutlet weak var tipTwo: UIButton!
    @IBOutlet weak var tipOne: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!

    var tipsSelection = 0.12
    var numberOfClicks = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func confirmClick(_ sender: Any) {
        
        let clicksData = ["numsOfClicks":numberOfClicks]
        let percentageData = ["percentage":tipsSelection]

        Amplitude.instance().logEvent("average clicks", withEventProperties: clicksData)
        Amplitude.instance().updateLocation()
        Amplitude.instance().logEvent("average percentage", withEventProperties: percentageData)

        numberOfClicks = 0
    }
    
    @IBAction func tipThreeClick(_ sender: Any) {
        numberOfClicks += 1
        tipOne.layer.borderColor = UIColor.lightGray.cgColor
        tipTwo.layer.borderColor = UIColor.lightGray.cgColor
        tipThree.layer.borderColor = UIColor.orange.cgColor
        tipsSelection = 0.18
        caculateTotal()
    }
    @IBAction func tipTwoClick(_ sender: Any) {
        numberOfClicks += 1
        tipOne.layer.borderColor = UIColor.lightGray.cgColor
        tipTwo.layer.borderColor = UIColor.orange.cgColor
        tipThree.layer.borderColor = UIColor.lightGray.cgColor
        tipsSelection = 0.15
        caculateTotal()
    }
    
    @IBAction func tipOneClick(_ sender: Any) {
        numberOfClicks += 1
        tipOne.layer.borderColor = UIColor.orange.cgColor
        tipTwo.layer.borderColor = UIColor.lightGray.cgColor
        tipThree.layer.borderColor = UIColor.lightGray.cgColor
        tipsSelection = 0.12
        caculateTotal()
    }
    func initViews() {
        tipOne.layer.cornerRadius = 5
        tipOne.layer.borderWidth = 0.5
        tipOne.layer.borderColor = UIColor.lightGray.cgColor
        tipTwo.layer.cornerRadius = 5
        tipTwo.layer.borderWidth = 0.5
        tipTwo.layer.borderColor = UIColor.lightGray.cgColor
        tipThree.layer.cornerRadius = 5
        tipThree.layer.borderWidth = 0.5
        tipThree.layer.borderColor = UIColor.lightGray.cgColor
        confirmButton.layer.cornerRadius = 5
        confirmButton.layer.borderWidth = 0.5
        confirmButton.layer.borderColor = UIColor.lightGray.cgColor

        textField.delegate = self
    }
    
    func caculateTotal() {
        let amount = Double(textField.text!)
        if amount != nil {
            summaryLabel.text = "Tips: \(tipsSelection * amount!)     Totla: \(amount! + tipsSelection * amount!)"
        } else {
            summaryLabel.text = "Tips:      Totla:    "
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        numberOfClicks += 1
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        let amount = Double(newString!)
        if amount != nil {
            tipOne.setTitle("12%  \(amount! * 0.12)", for: UIControlState.normal)
            tipTwo.setTitle("15%  \(amount! * 0.15)", for: UIControlState.normal)
            tipThree.setTitle("18%  \(amount! * 0.18)", for: UIControlState.normal)
        } else {
            tipOne.setTitle("12%", for: UIControlState.normal)
            tipTwo.setTitle("15%", for: UIControlState.normal)
            tipThree.setTitle("18%", for: UIControlState.normal)
        }
       
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
