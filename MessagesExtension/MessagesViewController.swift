//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Martin Otyeka on 2016-10-06.
//  Copyright © 2016 Dopeness Academy. All rights reserved.
//

import UIKit
import Messages
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAnalytics


class MessagesViewController: MSMessagesAppViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FIRApp.configure()
        BuddyBuildSDK.setup()
        FIRDatabase.database().persistenceEnabled = true
    }
    
    var storage: FIRStorage!
    var database: FIRDatabaseReference!
    var browserViewController: ClapbackStickerBrowserViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.database = FIRDatabase.database().reference().child("clapbacks")
        self.database.keepSynced(true)
        self.storage = FIRStorage.storage()
        
        self.browserViewController = ClapbackStickerBrowserViewController(stickerSize: .small)
        self.browserViewController.view.frame = self.view.frame
        
        self.addChildViewController(self.browserViewController)
        self.browserViewController.didMove(toParentViewController: self)
        self.view.addSubview(self.browserViewController.view)
        
        self.observeStickersAdded()
        self.observeStickerRemoved()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        print("viewDidDisappear")
        
    }
    
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        FIRAnalytics.logEvent(withName: "ClapbacksRecieved", parameters: nil)
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        FIRAnalytics.logEvent(withName: "ClapbacksSent", parameters: nil)
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        FIRAnalytics.logEvent(withName: "ClapbacksCancelled", parameters: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
