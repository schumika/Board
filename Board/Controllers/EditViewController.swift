//
//  EditPlayerViewController.swift
//  Board
//
//  Created by Anca Julean on 28/12/2018.
//  Copyright © 2018 alarm.com. All rights reserved.
//

import UIKit

class EditPlayerViewController : UIViewController {
    
    enum EditResolution {
        case cancel
        case done
        case delete
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = player.name
    }
    
    var editPlayerCompletion: ((EditResolution) -> ())?
    var player: Player!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        editPlayerCompletion?(.delete)
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        player.name = nameTextField.text ?? ""
        editPlayerCompletion?(.done)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        editPlayerCompletion?(.cancel)
    }
}
