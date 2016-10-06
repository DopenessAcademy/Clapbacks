//
//  FileManager.swift
//  Clapbacks
//
//  Created by Martin Otyeka on 2016-10-06.
//  Copyright © 2016 Dopeness Academy. All rights reserved.
//

public func tempFilePath(stickerName: String) -> URL {
    
    let tempPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(stickerName).appendingPathExtension("png").absoluteString
    if FileManager.default.fileExists(atPath: tempPath) {
        do {
            try FileManager.default.removeItem(atPath: tempPath)
        } catch { }
    }
    
    return URL(string: tempPath)!
}

public func imageToURL(stickerName: String, image: UIImage) -> URL {
    
    let url: URL = tempFilePath(stickerName: stickerName)
    let imageData = UIImagePNGRepresentation(image)
    
    do {
        try imageData?.write(to: url)
    } catch { }
    
    return url
}

public func imageFromURL(url: URL) -> UIImage {
    
    var data = Data()
    
    do {
        try data = Data(contentsOf: url)
    } catch { }
    
    return UIImage(data: data)!
}

