//
//  APICaller.swift
//  CombineIntro
//
//  Created by photypeta-junha on 2022/12/16.
//

import Foundation
import Combine

class APICaller {
    static let shared = APICaller()
    
    // 기존에는 completionHandler를 주로 사용하였다
    //    func fetchData(completion: ([String]) -> Void) {
    //        completion(["Apple"])
    //    }
    func fetchCompanies() -> Future<[String], Error> {
        return Future { promixe in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promixe(.success(["Apple", "Google", "Microsoft", "Facebook"]))
            }
        }
    }
}
