//
//  LocationDetail.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2020/02/05.
//  Copyright © 2020 Saki Nakayama. All rights reserved.
//

import Foundation

class LocationDetail {
    
    //検索ワード
    public var word:String!
    //緯度
    var latitude:Int!
    //経度
    var longitude:Int!
    
    required init(){
        self.word = ""
        self.latitude = 0
        self.longitude = 0
    }
    
    public func setWord(word : String) {
    }
    
    public func getWord() -> String {
        return self.word
    }
    
    public func setLatitude(latitude :Int){
    }
    
    public func getLatitude() -> Int{
        return self.latitude
    }
    
    public func setLongitude(longitude : Int){
    }
    
    public func getLongitude() -> Int{
        return self.latitude
    }
    
}
