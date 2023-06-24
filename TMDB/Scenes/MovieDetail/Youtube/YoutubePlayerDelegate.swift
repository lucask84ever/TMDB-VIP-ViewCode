//
//  YoutubePlayerDelegate.swift
//  TMDB
//
//  Created by Lucas on 24/06/23.
//

import Foundation
import youtube_ios_player_helper

final class YoutubePlayerDelegate: NSObject {
    
}

extension YoutubePlayerDelegate: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
