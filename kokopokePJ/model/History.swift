//
//  History.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/23.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation

//履歴管理
class History : NSObject, NSCoding {
    
    //履歴保存用ストレージの配列
    public var todayHistoryWord:[searchWord]
    
    public var yesHistoryWord:[searchWord]
    
    public var lastWeekHistoryWord:[searchWord]
    
    public var masterHistoryWord:[searchWord]
    
    override init() {
        self.todayHistoryWord = []
        self.yesHistoryWord = []
        self.lastWeekHistoryWord = []
        self.masterHistoryWord = []
    }
    
    required init?(coder aDecorder: NSCoder) {
        self.todayHistoryWord = []
        self.yesHistoryWord = []
        self.lastWeekHistoryWord = []
        self.masterHistoryWord = aDecorder.decodeObject(forKey: "masterHistoryWord") as! [searchWord]
        
        super.init()
        self.sortHistory()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(masterHistoryWord, forKey: "masterHistoryWord")
    }
    
    public func append(searchWord:searchWord){
        self.masterHistoryWord.append(searchWord)
    }

    public func getTodayHistoryWord() -> [searchWord] {
        return self.todayHistoryWord
    }
    
    public func getYesHistoryWord() -> [searchWord] {
        return self.yesHistoryWord
    }
    
    public func getLastWeekHistoryWord() -> [searchWord] {
        return self.lastWeekHistoryWord
    }
    
    public func clear() {
        self.masterHistoryWord = []
    }
    
    private func sortHistory() {
        let now = Date()
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy年MM月dd日"
        for word in masterHistoryWord {
            let searchedDate = word.getTimestamp()
            let dayInterval = (Calendar.current.dateComponents([.day], from: now, to: searchedDate)).day
            
            if dayInterval == 0 {
                todayHistoryWord.insert(word, at: 0)
            } else if dayInterval! < 2 {
                yesHistoryWord.insert(word, at: 0)
            }else if dayInterval! < 8 {
                lastWeekHistoryWord.insert(word, at: 0)
            } else {
                //do nothing..
            }
        }
    }
}
