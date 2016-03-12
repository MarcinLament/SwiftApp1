//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Marcin Lament on 20/02/2016.
//  Copyright © 2016 Marcin Lament. All rights reserved.
//

import Foundation

class RecordedAudio {
    var url: NSURL
    var title: String
    
    init(url: NSURL, title: String) {
        self.url = url;
        self.title = title;
    }
}