

import UIKit
import PhotosUI

class AddController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var releaseTF: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var libraryBtn: UIButton!
    @IBOutlet weak var publishBtn: UIButton!
    
    
    var categories : [Category] = []
    var imagePicker = UIImagePickerController()
    var libraryPicker: PHPickerViewController?
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        updatePicker()
        checkCamera()
        setupLibrary()
        setupTF()

       
    }
  
    @IBAction func addCategoryAction(_ sender: UIButton) {
        
        AlertHelper().alertAddCategory(self) { str in
            if let newCategory = str {
                CoreDataHelper.shared.addCategory(newCategory) { success in
                    if success {
                        self.updatePicker()
                    }
                }
            }
        }
        
        
    }
    
    
    @IBAction func openCamera(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openLibrary(_ sender: UIButton) {
        present(libraryPicker!, animated: true, completion: nil)
    }
    
    
    
    @IBAction func publishAction(_ sender: Any) {
        
    }
    
}

extension AddController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func setupPicker() {
        picker.delegate = self
        picker.dataSource = self
    }
    
    func updatePicker() {
        CoreDataHelper.shared.getCategories { categories in
            self.categories = categories
            self.picker.reloadAllComponents()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
}

extension AddController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setupCamera() {
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    func checkCamera() {
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            setupCamera()
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddController:  PHPickerViewControllerDelegate {
    
    func setupLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .automatic
        libraryPicker = PHPickerViewController(configuration: configuration)
        libraryPicker!.delegate = self
    }
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        if let first = results.first {
            let newItem = first.itemProvider
            if newItem.canLoadObject(ofClass: UIImage.self) {
                newItem.loadObject(ofClass: UIImage.self) { image, error in
                    if let newImage = image as? UIImage {
                        DispatchQueue.main.async {
                            self.imageView.image = newImage
                        }
                    }
                }
            }
        }
    }
}

extension AddController: UITextFieldDelegate {
    
    func setupTF() {
        nameTF.delegate = self
        releaseTF.delegate = self
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

