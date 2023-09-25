
import UIKit


class AlertHelper{
   
    func alertAddCategory(_ controller: UIViewController,_ completion: ((String) -> Void)?){
        
        let alert = UIAlertController(title: "Catégorie", message:"Catégorie a ajouter" , preferredStyle: .alert)
        alert.addTextField{
            textfield in textfield.placeholder = "Catégorie"
            
            let cancel = UIAlertAction(title: "Annuler", style: .destructive){
                action in completion?("nil")
            }
            
            let ok = UIAlertAction(title: "Valider", style: .default) { action in
                if let newCategory = alert.textFields?.first?.text {
                    completion?(newCategory)
                } else {
                    completion?("nil")
                }
            }
            alert.addAction(ok)
            alert.addAction(cancel)
            controller.present(alert, animated: true, completion: nil)
        }
        
        }
   
}
