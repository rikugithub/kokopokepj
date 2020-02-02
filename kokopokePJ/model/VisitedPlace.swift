//
//  visitedPlace.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/21.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation

//訪れた場所モデル
class VisitedPlace : NSObject, NSCoding{
    

    //訪れた場所
    private var name:String
    //訪問日時
    private var timestamp:String
    //緯度
    private var latitude:Double
    //経度
    private var longitude:Double
    //ジャンル
    private var genre:Int
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.timestamp = aDecoder.decodeObject(forKey: "timestamp") as! String
        self.latitude = aDecoder.decodeDouble(forKey: "latitude")
        self.longitude = aDecoder.decodeDouble(forKey: "longitude")
        self.genre = aDecoder.decodeInteger(forKey: "genre")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(timestamp, forKey: "timestamp")
        coder.encode(latitude, forKey: "latitude")
        coder.encode(longitude, forKey: "longitude")
        coder.encode(genre, forKey: "genre")
    }
    //DBからモデル生成
    init(dic:[String:Any]) {
        let name = dic["name"] as? String
        self.name = name!
        
        let timestamp = dic["timestamp"] as? String
        self.timestamp = timestamp!
        
        let latitude = dic["latitude"] as? Double
        self.latitude = latitude!
        
        let longitude = dic["longitude"] as? Double
        self.longitude = longitude!
        
        let genre = dic["genre"] as? Int
        self.genre = genre!
    }
    
    //Viewからモデル生成
    init(n:String, t:String, la:Double, lo:Double, g:Int) {
        self.name = n
        self.timestamp = t
        self.latitude = la
        self.longitude = lo
        self.genre = g
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getTimestamp() -> String {
        return self.timestamp
    }
    
    public func getLatitude() -> Double {
        return self.latitude
    }
    
    public func getLongitude() -> Double {
        return self.longitude
    }
    
    public func getGenre() -> Int {
        return self.genre
    }
    
    //辞書型変換(DB格納時用)
    func toDictionary() -> [String:Any] {
        return [
            "name":name,
            "timestamp":timestamp,
            "latitude":latitude,
            "longitude":longitude,
            "genre":genre,
        ]
    }
}
