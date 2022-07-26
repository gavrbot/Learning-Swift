//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Александр Гаврилов on 23.06.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = NSManagedObjectContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }


}

