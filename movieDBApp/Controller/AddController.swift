

import UIKit

class AddController: UIViewController {

    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var releaseTF: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var libraryBtn: UIButton!
    
    
    @IBOutlet weak var publishBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func openCamera(_ sender: UIButton) {
    }
    
    @IBAction func openLibrary(_ sender: UIButton) {
    }
    
    @IBAction func publishAction(_ sender: Any) {
    }
    
}
