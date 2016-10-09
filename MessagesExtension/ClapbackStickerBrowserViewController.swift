//
//  ClapbackStickerBrowserViewController.swift
//  Clapbacks
//
//  Created by Martin Otyeka on 2016-10-06.
//  Copyright © 2016 Dopeness Academy. All rights reserved.
//

import UIKit
import Messages

class ClapbackStickerBrowserViewController: MSStickerBrowserViewController {
    
    var stickers = [MSSticker]()
    
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return self.stickers.count
    }
    
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return self.stickers[index]
    }
    
}

