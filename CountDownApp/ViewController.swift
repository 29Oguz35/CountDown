
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timeTF: UITextField!
    
    var myTimer = Timer()
    var counter : Int = 0
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        createDatePicker()
        resetButton.isEnabled = false
    }
    func createDatePicker()
    {
       let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(doneButtonClicked))
        toolBar.setItems([doneButton], animated: true)
        
        timeTF.inputAccessoryView = toolBar
        timeTF.inputView = datePicker
        
        datePicker.datePickerMode = .countDownTimer
    }
    @objc func doneButtonClicked()
    {
       let formatter = NumberFormatter()
        
        timeTF.text = formatter.string(from: NSNumber(value: datePicker.countDownDuration))
        
        self.view.endEditing(true)
    }
    @IBAction func startButtonClicked(_ sender: Any)
    {
        if timeTF.text == "" {
            alertAction(message: "Please Selected Time")
        }else
        {
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
            counter = Int(timeTF.text!)!
            timeLabel.text = String(counter)
            startButton.isEnabled = false
            resetButton.isEnabled = true
        }
    }
    @objc func countDown()
    {
        if counter == 0
        {
            myTimer.invalidate()
            alertAction(message: "Time is Out !")
            counter = Int(timeTF.text!)!
            startButton.isEnabled = true
        }else
        {
           counter -= 1
            timeLabel.text = String(counter)
        }
    }
    @IBAction func resetButtonClicked(_ sender: Any)
    {
        myTimer.invalidate()
        counter = Int(timeTF.text!)!
        timeLabel.text = String(counter)
        startButton.isEnabled = true
    }
    @IBAction func exitButtonClicked(_ sender: Any)
    {
        UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
    }
    func alertAction(message: String)
    {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

