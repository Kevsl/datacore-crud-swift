
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
    
    func getCategories(_ completion: (([Category])->Void )?) {
        let request : NSFetchRequest<Category> =
        Category.fetchRequest()
        
        let sort: NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sort]
        
        do {
            let categories = try context.fetch(request)
            completion?(categories)
            
        } catch{
            print(error.localizedDescription)
            completion?([])
            
        }
        
        
        
        
        
        
        
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
