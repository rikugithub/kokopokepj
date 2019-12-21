//
//  visitedPlace.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/21.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation

//訪れた場所モデル
class VisitedPlace {
    //訪れた場所
    private var name:String
    //訪問日時
    private var timstamp:Date
    //緯度
    private var latitude:String
    //経度
    private var longitude:String
    //ジャンル
    private var genre:Int
    
    //DBからモデル生成
    init(dic:[String:Any]) {
        let name = dic["name"] as? String
        self.name = name!
        
        let timstamp = dic["timstamp"] as? Date
        self.timstamp = timstamp!
        
        let latitude = dic["latitude"] as? String
        self.latitude = latitude!
        
        let longitude = dic["longitude"] as? String
        self.longitude = longitude!
        
        let genre = dic["genre"] as? Int
        self.genre = genre!
    }
    
    //Viewからモデル生成
    init(n:String, t:Date, la:String, lo:String, g:Int) {
        self.name = n
        self.timstamp = t
        self.latitude = la
        self.longitude = lo
        self.genre = g
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getTimestamp() -> Date {
        return self.timstamp
    }
    
    public func getLatitude() -> String {
        return self.latitude
    }
    
    public func getLongitude() -> String {
        return self.longitude
    }
    
    public func getGenre() -> Int {
        return self.genre
    }
}
