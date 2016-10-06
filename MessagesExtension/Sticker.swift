//
//  Sticker.swift
//  Clapbacks
//
//  Created by Martin Otyeka on 2016-10-06.
//  Copyright © 2016 Dopeness Academy. All rights reserved.
//

import UIKit
import Messages
import Firebase

struct Sticker {
    
    let name: String
    let downloadURL: String
    var localURL: URL?
    
    init(name: String, downloadURL: String) {
        self.name = name
        self.downloadURL = downloadURL
        self.localURL = tempFilePath(stickerName: name)
    }
}

extension MessagesViewController {
    
    func createSticker(sticker: Sticker) {
        let msSticker: MSSticker
        do {
            try msSticker = MSSticker(contentsOfFileURL: sticker.localURL!, localizedDescription: sticker.name)
            self.browserViewController.stickers.append(msSticker)
            self.browserViewController.stickerBrowserView.reloadData()
        } catch { }
    }
    
    func removeSticker(snapshot: FIRDataSnapshot) {
        for sticker in self.browserViewController.stickers {
            if sticker.localizedDescription == snapshot.key {
                self.browserViewController.stickers.removeObject(object: sticker)
                DataCache.instance.clean(byKey: snapshot.key)
                self.browserViewController.stickerBrowserView.reloadData()
                break
            }
        }
    }
}

extension Array where Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
