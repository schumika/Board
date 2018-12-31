//
//  EditViewController.swift
//  Board
//
//  Created by Anca Julean on 28/12/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class EditViewController : UIViewController {
    
    enum EditResolution {
        case cancel
        case done
        case delete
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = namedItem.name
    }
    
    var editItemCompletion: ((EditResolution) -> ())?
    var namedItem: NamedItem!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        editItemCompletion?(.delete)
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        namedItem.name = nameTextField.text ?? ""
        editItemCompletion?(.done)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        editItemCompletion?(.cancel)
    }
}
