
import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>?
    {
        didSet
        {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>?
    {
        if let fahrenheitValue = fahrenheitValue
        {
            return fahrenheitValue.converted(to: .celsius)
        }
        else
        {
            return nil
        }
    }
    func updateCelsiusLabel()
    {
        if celsiusValue != nil
        {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue!.value))
        }
        else
        {
            celsiusLabel.text = "???"
        }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    @IBAction func farenheitFieldEditingChanged(_ textField: UITextField)
    {
        if let text = textField.text, let number = numberFormatter.number(from: text){
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        }
        else
        {
            fahrenheitValue = nil
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        textField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingTextingHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        if existingTextingHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil
        {
            return false
        }
        if !(string.rangeOfCharacter(from: NSCharacterSet(charactersIn: "-0123456789.,") as CharacterSet) != nil), !string.isEmpty {

            return false
        }
        else
        {
            return true
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
    }
    func viewWillAppear()
    {
        let hour = NSCalendar.current.component(.hour, from: NSDate() as Date)
        switch hour
        {
        case 1..<6: view.backgroundColor = .white
            break
        case 6..<18: view.backgroundColor = .white
            break
        case 18..<25: view.backgroundColor = .gray
            break
        default: view.backgroundColor = .white
        }
    }
}

