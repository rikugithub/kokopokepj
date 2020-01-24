//
//  searchWord.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2020/01/21.
//  Copyright © 2020 Saki Nakayama. All rights reserved.
//

import Foundation

public class searchWord: NSObject, NSCoding {
    
    private var word:String
    private var timestamp:Date
    
    init(word:String,timestamp:Date) {
        self.word = word
        self.timestamp = timestamp
    }
    
    required public init?(coder aDecorder: NSCoder) {
        
        self.word = aDecorder.decodeObject(forKey: "word") as! String
        self.timestamp = aDecorder.decodeObject(forKey: "timestamp") as! Date
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(word, forKey: "word")
        coder.encode(timestamp, forKey: "timestamp")
    }
    
    public func getWord() -> String {
        return self.word
    }
    
    public func getTimestamp() -> Date {
        return self.timestamp
    }
    
}
