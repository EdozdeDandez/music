//
//  LoginViewController.swift
//  Music
//
//  Created by Shape on 20/02/2018.
//  Copyright © 2018 Shape. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class LoginViewController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {

    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    
    // MARK: Variables
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingLabel.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.updateAfterFirstLogin), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup () {
        let redirectURL = "music-app-login://callback"
        let clientID = "66b642b927494c468a4c8ffd4a835305"
        auth.redirectURL     = URL(string: redirectURL)
        auth.clientID        = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }
    
//    func initializaPlayer(authSession:SPTSession){
//        if self.player == nil {
//
//            self.player = SPTAudioStreamingController.sharedInstance()
//            self.player!.playbackDelegate = self
//            self.player!.delegate = self
//            try! player?.start(withClientId: auth.clientID)
//            self.player!.login(withAccessToken: authSession.accessToken)
//
//        }
//
//    }
    
    @objc func updateAfterFirstLogin () {
        
        loadingLabel.isHidden = false
        loginButton.isHidden = true
        let userDefaults = UserDefaults.standard
        
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            self.session = firstTimeSession
            
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Menu")
            self.present(viewController, animated: true, completion: nil)
//            initializaPlayer(authSession: session)
            self.loginButton.isHidden = true
        }
        
    }
    
//    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
//        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
//        print("logged in")

//
//    }
    
    // MARK: Actions
    
    @IBAction func loginViaSpotify(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            if UIApplication.shared.canOpenURL(loginUrl!) && auth.canHandle(auth.redirectURL){
                UIApplication.shared.open(loginUrl!, options: [:], completionHandler: nil)
                
                    // To do - build in error handling
            }
        }
        else {
            if UIApplication.shared.openURL(loginUrl!) {
                
                if auth.canHandle(auth.redirectURL) {
                    // To do - build in error handling
                }
            }
        }
    }
}

