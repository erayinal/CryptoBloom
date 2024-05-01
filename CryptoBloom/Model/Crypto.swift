//
//  Crypto.swift
//  CryptoBloom
//
//  Created by Eray İnal on 5.04.2024.
//

import Foundation

struct Crypto : Codable{
    //.5 Bu struct aslında bizim siteden alacağımız JSON verileri tek tek ele alabilmek için ihtiyaç olan struct, biz buna model diyoruz aslında
    //..5 Siteden alacağımız verileri, google'a JSON beaurifier yazıp çıkan herhangi bir sitede görünümünü düzeltelim
    //...5 Baktığımızda bütün verilerin içeriği aynı yani biz bu struct içerisinde bir tanesini ele alırsak diğerlerini de kolaylıkla ele alabiliriz
    
    //6 her iki değer de String olduğu için ikisini de String olarak tanımlıyoruz, eğer sayı şeklinde olsa price'ı Double olarak tanımlardık
    let currency: String
    let price: String
    
    //.6 Bunları da tanımladıktan sonra bu Crypto classını 'Codable' adında bir protocola confirm etmemiz lazım
    //..6 Biz bunları aslında 'https://app.quicktype.io' sitesine giderek nasıl kodlanması gerektiğine bakabiliriz
    
    //7 Şimdi Service altına gidip 'WebService' adında bir swift dosyası açalım ve içeriğini yazalım
    
}
