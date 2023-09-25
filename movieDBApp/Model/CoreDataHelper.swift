
import Foundation
import UIKit
import CoreData

class CoreDataHelper{
    

    static let shared = CoreDataHelper()

    var successCompletion: ((Bool) -> Void)?
    
    private var _appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var container: NSPersistentContainer{
        
        return _appDelegate.persistentContainer
    }
    
    var context: NSManagedObjectContext{
        return container.viewContext
    }
    
    func addCategory(_ name: String,_ completion: ((Bool) -> Void)? ){
    
        self.successCompletion = completion
        let newCategory = Category(context: context)
        newCategory.name = name
        context.insert(newCategory)
        saveContext()
    }
    
    
    func saveContext(){
        do{
            try context.save()
            successCompletion?(true)
        }catch{
            successCompletion?(false)
        }
        
    }
    
    
    
}
