//
//  TracksTableViewController.swift
//  Music
//
//  Created by Shape on 28/02/2018.
//  Copyright © 2018 Shape. All rights reserved.
//

import UIKit

class TracksTableViewController: UITableViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    var player: SPTAudioStreamingController?
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var state: SPTPlaybackState?
    
    //Mark:variables
    var selected = [Int:AnyObject]()
    var tracks = [Int:AnyObject]()
    @IBOutlet var trackTable: UITableView!
    
    func getSession () {
        let userDefaults = UserDefaults.standard
        
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let sessionData = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = sessionData
        }
    }
    func setup () {
        let redirectURL = "music-app-login://callback"
        let clientID = "66b642b927494c468a4c8ffd4a835305"
        auth.redirectURL     = URL(string: redirectURL)
        auth.clientID        = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        getSession()
    }
    
    func initializaPlayer(authSession:SPTSession){
        if self.player == nil {
            
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            if player?.loggedIn == false {
                try! player?.start(withClientId: auth.clientID)
                self.player!.login(withAccessToken: authSession.accessToken)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        initializaPlayer(authSession: session)

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
        return tracks.count
    }

    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        let playList = selected[0]
        if let playlist = playList as? SPTPartialPlaylist {
            let stringFromUrl =  playlist.uri.absoluteString
            let uri = URL(string: stringFromUrl)
            SPTPlaylistSnapshot.playlist(withURI: uri, accessToken: session.accessToken) { (error, snap) in
                if let shot = snap as? SPTPlaylistSnapshot {
                    // get the tracks for each playlist
                    var num:Int = 0
                    let shots = shot.firstTrackPage.tracksForPlayback()
                    for track in shots! {
                        if let thistrack = track as? SPTPlaylistTrack {
                            self.tracks.updateValue(thistrack, forKey: num)
                            num += 1
                        }
                    }
                    if self.tracks.count>0 {
                        self.trackTable.reloadData()
                        self.player?.queueSpotifyURI(stringFromUrl, callback: { (error) in
                            if (error != nil) {
                                print("playing!")
                            }
                        })
                    }
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TracksTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as? TracksTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TracksTableViewCell.")
        }
        print(self.tracks)
        // Fetches the appropriate setting for the data source layout.
        let track = tracks[indexPath.row]
        
        // Configure the cell...
        let album = track!.album as SPTPartialAlbum
        let imagePath: URL? = album.smallestCover.imageURL
        let loadedImageData = NSData(contentsOf: imagePath!)
        DispatchQueue.main.async {
            if let imageData = loadedImageData  {
                cell.albumImage.image = UIImage(data: imageData as Data)
            }
        }
        cell.nameLabel.text = track!.name
        cell.albumLabel.text = album.name
        
        return cell
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
    }
    // MARK: - Actions
    
    @IBAction func goToNext(_ sender: UIButton) {
        self.player?.skipNext({ (error) in
            if (error != nil) {
                print("playing next!")
            }
        })
    }
    
    @IBAction func previous(_ sender: UIButton) {
        self.player?.skipPrevious({ (error) in
            if (error != nil) {
                print("playing previous!")
            }
        })
    }

    @IBAction func pausePlay(_ sender: UIButton) {
        if self.state?.isPlaying == true {
            self.player?.setIsPlaying(false, callback: nil)
        }else{
            self.player?.setIsPlaying(true, callback: nil)
        }
    }
}
