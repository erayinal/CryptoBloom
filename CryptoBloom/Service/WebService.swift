//
//  WebService.swift
//  CryptoBloom
//
//  Created by Eray İnal on 5.04.2024.
//

import Foundation

class WebService {
     
    //.7 Tek bir tane fonksiyon olacak:
    func downloadCurrencies(url: URL, completion: @escaping(Result<[Crypto], CryptoError>)->() ){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //.8:
            if let _ = error{
                completion(.failure(.serverError))
            } 
            else if let data = data{
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList{
                    completion(.success(cryptoList))
                }
                else{
                    completion(.failure(.parsingError))
                }
            }
            
            
        }.resume()
    }
    
    
}


//8 Burada kendi Failure'ımızı yazalım ve downloadCurrencies içerisinde kullanalım. Şimdi tekrar downloadCurrencies methodunun içerisine gidip devam edelim
enum CryptoError: Error {
    
    case serverError
    case parsingError
    
}
