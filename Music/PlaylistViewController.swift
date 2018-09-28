//
//  PlaylistViewController.swift
//  Music
//
//  Created by Shape on 27/02/2018.
//  Copyright © 2018 Shape. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    // MARK: - Navigation

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var publicSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
