//
//  UserDataManager.swift
//  SimpleNote
//
//  Created by YunseonChoi on 2021/02/24.
//

import UIKit

class UserDataManager: NSObject {
    
    static let LIST_KEY_DEFAULT = "default"
    
    static let shared = UserDataManager()
    private override init() {
        super.init()
    }
    
    func saveList(with key:String, list:[TimeInterval]) ->Bool {
            UserDefaults.standard.setValue(list, forKey: key)
            
            return UserDefaults.standard.synchronize()
            // 동기화 결과 반환
        }
        
        func getList(with key:String)->[TimeInterval] {
            if let list = UserDefaults.standard.value(forKey: key) as? [TimeInterval] {
                return list
            }
            return []       // 만약 데이터가 없으면 빈 데이터
        }
    func getMemo(with timeStampString:String)->String {
            if let memo = UserDefaults.standard.value(forKey: timeStampString) as? String {
                return memo
            }
            
            return ""
        }
        
        func saveMemo (with timeStampStr:String, memo:String) ->Bool {
            UserDefaults.standard.setValue(memo, forKey: timeStampStr)
            return UserDefaults.standard.synchronize();
        }
}
