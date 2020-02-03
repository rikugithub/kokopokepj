//
//  review.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/21.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation

//口コミモデル
class Review {
    //訪れた場所
    private var visitedPlaceName:String
    //投稿者
    private var postUserName:String
    //年齢
    private var postUserAge:String
    //性別
    private var postUserGender:Bool
    //訪問日時
    private var visitedTimestamp:String
    //投稿日時
    private var postTimestamp:String
    //評価
    private var rating:Int
    //ジャンル
    private var visitedPlaceGenre:Int
    //誰と一緒に
    private var withWho:Int
    //誰と一緒に(その他)
    private var withWhoElse:String
    //画像パス
    private var imgURL:String
    //口コミ内容
    private var reviewContent:String
    //メモ
    private var memo:String
    
    //DBからモデル生成
    init(dic:[String:Any]) {
        let visitedPlaceName = dic["visitedPlaceName"] as? String
        self.visitedPlaceName = visitedPlaceName!
        
        let postUserName = dic["postUserName"] as? String
        self.postUserName = postUserName!
        
        let postUserAge = dic["postUserAge"] as? String
        self.postUserAge = postUserAge!
        
        let postUserGender = dic["postUserGender"] as? Bool
        self.postUserGender = postUserGender!
        
        let visitedTimestamp = dic["visitedTimestamp"] as? String
        self.visitedTimestamp = visitedTimestamp!
        
        let postTimestamp = dic["postTimestamp"] as? String
        self.postTimestamp = postTimestamp!
        
        let rating = dic["rating"] as? Int
        self.rating = rating!
        
        let visitedPlaceGenre = dic["visitedPlaceGenre"] as? Int
        self.visitedPlaceGenre = visitedPlaceGenre!
        
        let withWho = dic["withWho"] as? Int
        self.withWho = withWho!
        
        let withWhoElse = dic["withWhoElse"] as? String
        self.withWhoElse = withWhoElse!
        
        let imgURL = dic["imgURL"] as? String
        self.imgURL = imgURL!
        
        let reviewContent = dic["reviewContent"] as? String
        self.reviewContent = reviewContent!
    
        let memo = dic["memo"] as? String
        self.memo = memo!
    }
    
    //Viewからモデル生成
    init(vPN:String,pUN:String,pUA:String,pUG:Bool,vT:String,pT:String,rt:Int,vPG:Int,wW:Int,wWE:String,iURL:String,rC:String,memo:String) {
        self.visitedPlaceName = vPN
        self.postUserName = pUN
        self.postUserAge = pUA
        self.postUserGender = pUG
        self.visitedTimestamp = vT
        self.postTimestamp = pT
        self.rating = rt
        self.visitedPlaceGenre = vPG
        self.withWho = wW
        self.withWhoElse = wWE
        self.imgURL = iURL
        self.reviewContent = rC
        self.memo = memo
    }
    
    public func getVisitedPlaceName() -> String {
        return self.visitedPlaceName
    }
    
    public func getPostUserName() -> String {
        return self.postUserName
    }
    
    public func getPostUserAge() -> String {
        return self.postUserAge
    }
    
    public func getPostUserGender() -> Bool {
        return self.postUserGender
    }
    
    public func getVisitedTimestamp() -> String {
        return self.visitedTimestamp
    }
    
    public func getPostTimestamp() -> String {
        return self.postTimestamp
    }
    
    public func getRating() -> String {
        return self.convertRating(i: self.rating)
    }
    
    public func getVisitedPlaceGenre() -> Int {
        return self.visitedPlaceGenre
    }
    
    public func getWithWho() -> Int {
        return self.withWho
    }
    
    public func getWithWhoElse() -> String {
        return self.withWhoElse
    }
    
    public func getImgURL() -> String {
        return self.imgURL
    }
    
    public func getReviewContent() -> String {
        return self.reviewContent
    }
    
    public func getMemo() -> String {
        return self.memo
    }
    
    //辞書型変換(DB格納時用)
    func toDictionary() -> [String:Any] {
        return [
            "visitedPlaceName":visitedPlaceName,
            "postUserName":postUserName,
            "postUserAge":postUserAge,
            "postUserGender":postUserGender,
            "visitedTimestamp":visitedTimestamp,
            "postTimestamp":postTimestamp,
            "rating":rating,
            "visitedPlaceGenre":visitedPlaceGenre,
            "withWho":withWho,
            "withWhoElse":withWhoElse,
            "imgURL":imgURL,
            "reviewContent":reviewContent,
            "memo":memo
        ]
    }
    
    //数値を評価に変換
    private func convertRating(i:Int) -> String {
        switch i {
        case 0:
            return "☆☆☆☆☆"
        case 1:
            return "★☆☆☆☆"
        case 2:
            return "★★☆☆☆"
        case 3:
            return "★★★☆☆"
        case 4:
            return "★★★★☆"
        case 5:
            return "★★★★★"
        default:
            //ここに来ることはない
            return "評価なし"
        }
    }
}
