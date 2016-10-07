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

class MessagesViewController: MSMessagesAppViewController {
    
    static let once: Int = {
        FIRApp.configure()
        BuddyBuildSDK.setup()
        FIRDatabase.database().persistenceEnabled = true
        return 0
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _ = MessagesViewController.once
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
    
   /* override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        self.increment(answers: .ClapbacksRecieved)
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        self.increment(answers: .ClapbacksSent)
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        self.increment(answers: .ClapbacksCancelled)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

