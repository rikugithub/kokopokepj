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
    private var postUserAge:String?
    //性別
    private var postUserGender:Bool?
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
        self.postUserAge = postUserAge
        
        let postUserGender = dic["postUserGender"] as? Bool
        self.postUserGender = postUserGender
        
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
    init(visitedPlaceName:String,
         postUserName:String,
         postUserAge:String,
         postUserGender:Bool,
         visitedTimestamp:String,
         postTimestamp:String,
         rating:Int,
         visitedPlaceGenre:Int,
         withWho:Int,
         withWhoElse:String,
         imgURL:String,
         reviewContent:String,
         memo:String) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
        
        self.visitedPlaceName = visitedPlaceName
        self.postUserName = postUserName
        self.postUserAge = postUserAge
        self.postUserGender = postUserGender
        self.visitedTimestamp = dateFormatter.string(from: date)
        self.postTimestamp = dateFormatter.string(from: date)
        self.rating = rating
        self.visitedPlaceGenre = visitedPlaceGenre
        self.withWho = withWho
        self.withWhoElse = withWhoElse
        self.imgURL = imgURL
        self.reviewContent = reviewContent
        self.memo = memo
    }
    
    public func getVisitedPlaceName() -> String {
        return self.visitedPlaceName
    }
    
    public func getPostUserName() -> String {
        return self.postUserName
    }
    
    public func getPostUserAge() -> String? {
        return self.postUserAge
    }
    
    public func getPostUserGender() -> Bool? {
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
    
    public func getVisitedPlaceGenre() -> String {
        return convertGenreString(i: self.visitedPlaceGenre)
    }
    
    public func getWithWho() -> String {
        return convertWhoWithString(i: self.withWho )
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
    
    public func setVisitedPlaceName(visitedPlaceName:String) {
        self.visitedPlaceName = visitedPlaceName
    }
    
    public func setPostUserName(postUserName:String) {
        self.postUserName = postUserName
    }
    
    public func setPostUserAge(postUserAge:String) {
        self.postUserAge = postUserAge
    }
    
    public func setPostUserGender(postUserGender:Bool) {
        self.postUserGender = postUserGender
    }
    
    public func setVisitedTimestamp(visitedTimestamp:String) {
        self.visitedTimestamp = visitedTimestamp
    }
    
    public func setPostTimestamp(postTimestamp:String) {
        self.postTimestamp = postTimestamp
    }
    
    public func setRating(rating:Int) {
        self.rating = rating
    }
    
    public func setVisitedPlaceGenre(visitedPlaceGenre:String) {
        self.visitedPlaceGenre = convertGenre(s: visitedPlaceGenre)
    }
    
    public func setWithWho(withWho:String) {
        self.withWho = convertWhoWith(s: withWho)
    }
    
    public func setWithWhoElse(withWhoElse:String) {
        self.withWhoElse = withWhoElse
    }
    
    public func setImgURL(imgURL:String) {
        self.imgURL = imgURL
    }
    
    public func setReviewContent(reviewContent:String) {
        self.reviewContent = reviewContent
    }
    
    public func setMemo(memo:String) {
        self.memo = memo
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
    
    private func convertGenre(s:String) -> Int {
        switch s {
        case " ":
            return 1
        case "飲食":
            return 2
        case "娯楽":
            return 3
        case "ショッピング":
            return 4
        case "交通":
            return 5
        case "生活":
            return 6
        case "ゲーム":
            return 7
        case "その他":
            return 8
        default:
            return 0
        }
    }
    
    private func convertWhoWith(s:String) -> Int {
        switch s {
        case " ":
            return 1
        case "１人":
            return 2
        case "家族":
            return 3
        case "恋人":
            return 4
        case "その他":
            return 5
        default:
            return 0
        }
        
    }
    
    private func convertWhoWithString(i:Int) -> String {
        switch i {
        case 1:
            return " "
        case 2:
            return "１人"
        case 3:
            return "家族"
        case 4:
            return "恋人"
        case 5:
            return "その他"
        default:
            return ""
        }
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
    private func convertGenreString(i:Int) -> String {
        switch i {
        case 1:
            return " "
        case 2:
            return "飲食"
        case 3:
            return "娯楽"
        case 4:
            return "ショッピング"
        case 5:
            return "交通"
        case 6:
            return "生活"
        case 7:
            return "ゲーム"
        case 8:
            return "その他"
            
        default:
            return "none"
        }
    }
}
