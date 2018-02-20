//  Converted to Swift 4 by Swiftify v4.1.6613 - https://objectivec2swift.com/
//
//  PVRecentGame+TopShelf.m
//  Provenance
//
//  Created by David Muzi on 2015-12-15.
//  Copyright © 2015 James Addyman. All rights reserved.
//

import TVServices

// Top shelf extensions
extension PVRecentGame {
    public func contentItem(with containerIdentifier: TVContentIdentifier) -> TVContentItem? {
        guard let game = game else {
            return nil
        }
        
        guard let identifier = TVContentIdentifier(identifier: game.md5Hash, container: containerIdentifier),
        let item = TVContentItem(contentIdentifier: identifier) else {
            return nil
        }
        
        item.title = game.title
        item.imageURL = URL(string: game.customArtworkURL.isEmpty ? game.originalArtworkURL : game.customArtworkURL)
        item.imageShape = imageType
        item.displayURL = self.displayURL
        item.lastAccessedDate = lastPlayedDate
        return item
    }
    
    var displayURL : URL {
        var components = URLComponents()
        components.scheme = PVAppURLKey
        components.path = PVGameControllerKey
        components.queryItems = [URLQueryItem(name: PVGameMD5Key, value: game!.md5Hash)]
        return (components.url)!
    }
    
    var imageType : TVContentItemImageShape {
        guard let game = game, let system = game.system else {
            return .square
        }
        
        switch system {
        case .NES, .Genesis, .SegaCD, .MasterSystem, .SG1000, .Sega32X, .Atari2600, .Atari5200, .Atari7800, .Lynx, .WonderSwan, .WonderSwanColor, .Saturn:
            return .poster
        case .GameGear, .GB, .GBC, .GBA, .NGP, .NGPC, .PSX, .VirtualBoy, .PCE, .PCECD, .PCFX, .SGFX, .FDS, .PokemonMini:
            return .square
        case .N64, .SNES:
            return .HDTV
        }
    }
}
