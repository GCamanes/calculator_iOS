//
//  ViewController.swift
//  Calculator
//
//  Created by formation7 on 28/11/2018.
//  Copyright © 2018 formation7. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelResult: UILabel!
    
    var previousValue: Double = 0.0
    var currentValue: String = ""
    var operatorFunc:((Double, Double) -> (Double))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func printData() {
        print(previousValue)
        print(operatorFunc)
        print(currentValue)
    }
    
    func resolve (newValue: Double) -> Double {
        
        guard let operationToExecute  = operatorFunc else {
            let alertViewController = UIAlertController(title: "error", message: "FATAL ERROR", preferredStyle: .alert)
            self.show(alertViewController, sender: self)
            // Return 0 if no operation
            return 0.0
        }
        // Return the result
        return operationToExecute(previousValue, newValue)
    }

    @IBAction func digitDidTap(_ sender: UIButton) {
        labelResult.text = (labelResult.text ?? "") + (sender.titleLabel?.text ?? "")
        currentValue += (sender.titleLabel?.text ?? "")
    }
    
    @IBAction func cancelDidTap(_ sender: UIButton) {
        labelResult.text = ""
        previousValue = 0.0
        operatorFunc = nil
        currentValue = ""
        printData()
    }
    
    @IBAction func dotDidTap(_ sender: UIButton) {
        if !(labelResult.text ?? "").contains(".") {
            labelResult.text = (labelResult.text ?? "") + "."
        }
        printData()
    }
    
    @IBAction func operatorDidTap(_ sender: UIButton) {
        // Getting user input value
        guard let stringValue = labelResult.text else {
            return
        }
        // Casting to Double
        guard let value = Double(stringValue) else {
            return
        }
        // Here we are sure that value is a double
        if operatorFunc != nil {
            previousValue = resolve(newValue: value)
        } else {
            previousValue = value
        }
        
        printData()
        if let ope = (sender.titleLabel?.text) {
            if ope == "+" {
                operatorFunc = {(a: Double, b: Double) in return a+b}
            } else if ope == "-" {
                operatorFunc = {(a: Double, b: Double) in return a-b}
            } else if ope == "*" {
                operatorFunc = {(a: Double, b: Double) in return a*b}
            } else if ope == "/" {
                operatorFunc = {(a: Double, b: Double) in return a/b}
            }
            print(ope)
            print("\n")
        }
        currentValue = ""
        labelResult.text = ""
    }
    
    @IBAction func equalDidTap(_ sender: UIButton) {
        // Getting user input value
        guard let stringValue = labelResult.text else {
            return
        }
        // Casting to Double
        guard let value = Double(stringValue) else {
            return
        }
        
        previousValue = resolve(newValue: value)
        labelResult.text  = String(previousValue)
        printData()
    }
}

