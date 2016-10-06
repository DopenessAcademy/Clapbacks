//
//  Firebase.swift
//  Clapbacks
//
//  Created by Martin Otyeka on 2016-10-06.
//  Copyright © 2016 Dopeness Academy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

enum Answers: String {
    case ClapbacksSent = "clapbacksSent"
    case ClapbacksRecieved = "clapbacksRecieved"
    case ClapbacksCancelled = "clapbacksCancelled"
}

extension MessagesViewController {
    /*
     Observe all events where a sticker is added in the database
     Get the storage reference from the realtime database
     For each reference, create a sticker object with the snapshot key and value.
     */
    func observeStickersAdded() {
        
        var sticker: Sticker!
        
        self.database.observe(.childAdded, with: { snapshot in
            if let downloadUrl = snapshot.value {
                sticker = Sticker(name: snapshot.key, downloadURL: downloadUrl as! String)
            }
            
            if let cachedImage = DataCache.instance.readImageForKey(key: sticker.downloadURL)  {
                sticker.localURL = imageToURL(stickerName: sticker.name, image: cachedImage)
                self.createSticker(sticker: sticker)
                return
            }
            self.downloadSticker(sticker: sticker)
        })
    }
    
    /*
     Observe all events where a sticker is deleted from the database
     Remove sticker from browserViewDataSource and from the Cache
     */
    func observeStickerRemoved() {
        self.database.observe(.childRemoved, with: { snapshot in
            self.removeSticker(snapshot: snapshot)
        })
    }
    
    /*
     Create a reference to the sticker file in the storage
     Download that file and store it in the sticker localURL
     Cache that Image using DataCache using downloadURL as the key
     */
    func downloadSticker(sticker: Sticker) {
        
        let stickerRef = self.storage.reference(forURL: sticker.downloadURL)
        
        stickerRef.write(toFile: sticker.localURL!) { (url, error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if url != nil {
                    // Create the sticker and cache the image
                    self.createSticker(sticker: sticker)
                    let image = imageFromURL(url: url!)
                    DataCache.instance.write(image: image, forKey: sticker.downloadURL, format: .png)
                }
            }
        }
    }
    
    //  Increment count of these actions in the database by all users
    func increment(answers: Answers) {
        switch answers {
        case .ClapbacksSent:
            self.transaction(action: answers.rawValue)
        case .ClapbacksRecieved:
            self.transaction(action: answers.rawValue)
        case .ClapbacksCancelled:
            self.transaction(action: answers.rawValue)
        }
    }
    
    func transaction(action: String) {
        
        let ref = FIRDatabase.database().reference().child(action)
        
        ref.runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
            var value = currentData.value as? Int
            if value == nil {
                value = 0
            }
            currentData.value = value! + 1
            
            return FIRTransactionResult.success(withValue: currentData)
            
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

