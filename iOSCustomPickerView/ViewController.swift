//
//  ViewController.swift
//  iOSCustomPickerView
//
//  Created by Anupam Chugh on 15/08/18.
//  Copyright © 2018 JournalDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    let picker1 = UIPickerView()
    var arrayOfCountries = ["India","USA","Germany","China", "France","Japan", "Australia", "Greece"]
    var arrayOfColors = ["Red","Orange","Yellow","Green", "Blue","Black"]
    var activeTextField = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField1.delegate = self
        textField2.delegate = self
        createPickerView()
        createToolbar()
    }
    
    func createPickerView()
    {
        picker1.delegate = self
        picker1.delegate?.pickerView?(picker1, didSelectRow: 0, inComponent: 0)
        textField1.inputView = picker1
        textField2.inputView = picker1
        picker1.backgroundColor = UIColor.brown
    }
  

    
    func createToolbar()
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.red
        toolbar.backgroundColor = UIColor.blue
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textField1.inputAccessoryView = toolbar
        textField2.inputAccessoryView = toolbar
    }
    
    @objc func closePickerView()
    {
        view.endEditing(true)
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch activeTextField
        {
        case 1:
            return arrayOfCountries.count
        case 2:
            return arrayOfColors.count
        default:
            return arrayOfColors.count
        
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch activeTextField{
        case 1:
            return arrayOfCountries[row]
        case 2:
            return arrayOfColors[row]
        default:
            return arrayOfColors[row]
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch activeTextField{
        
        case 1:
            textField1.text =  arrayOfCountries[row]
            break
            
        case 2:
            textField2.text = arrayOfColors[row]
            break

        default:
            textField1.text =  arrayOfCountries[row]
            break
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        switch activeTextField{
        case 1:
        var label:UILabel
        
        if let v = view as? UILabel{
            label = v
        }
        else{
            label = UILabel()
        }
        
        label.textColor = UIColor.yellow
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 16)
        
        label.text = arrayOfCountries[row]
        
        return label
         
        case 2:
            
            let parentView = UIView()
            let label = UILabel(frame: CGRect(x: 60, y: 0, width: 80, height: 50))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height:50))
            imageView.image = UIImage(named: "ic_launcher")
            label.text = arrayOfColors[row]
            parentView.addSubview(label)
            parentView.addSubview(imageView)
            
            return parentView
            
        default:
            return UILabel()
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
        case textField1:
            activeTextField = 1
            picker1.reloadAllComponents()
        case textField2:
            activeTextField = 2
            picker1.reloadAllComponents()
        default:
            activeTextField = 0
        }
        
    }
}

