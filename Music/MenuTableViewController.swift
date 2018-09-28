//
//  MenuTableViewController.swift
//  Music
//
//  Created by Shape on 26/02/2018.
//  Copyright © 2018 Shape. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    // MARK: Variables
    var items = [String]()
    var valueToPass:String!
    
    //MARK: Private Methods
    
    private func loadItems() {
//        let item1 = "Albums"
        let item2 = "Playlists"
//        let item3 = "Artists"
        
        items += [item2]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "MENU"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        loadItems()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MenuTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as? MenuTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LanguageTableViewCell.")
        }
        
        // Fetches the appropriate setting for the data source layout.
        let item = items[indexPath.row]
        
        // Configure the cell...
        cell.itemLabel.text = item

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let indexPathOne = tableView.indexPathForSelectedRow
//        let currentCell = tableView.cellForRow(at: indexPathOne!) as UITableViewCell!
//        valueToPass = currentCell?.textLabel?.text
        
        if indexPath.row == 1 {
            //THE SEGUE
            self.performSegue(withIdentifier: "albums", sender: self)
        }
        if indexPath.row == 0 {
            //THE SEGUE
            self.performSegue(withIdentifier: "playlists", sender: self)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if segue.identifier == "albums" {
//            let album = segue.destination as UIViewController
//            let selectedRow = tableView.indexPathForSelectedRow!.row
//            album.passedValue = items[selectedRow]
//            album.navigationItem.title = valueToPass
//            album.navigationItem.title = "Albums"
//
//        }
        navigationItem.title = nil
    }

}
