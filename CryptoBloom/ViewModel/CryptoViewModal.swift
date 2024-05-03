//
//  CryptoViewModal.swift
//  CryptoBloom
//
//  Created by Eray İnal on 1.05.2024.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModal{
    
    //..10 Şimdi daha önce söylediğimiz gibi RxSwift ile bu bulunduğumuz CryptoViewModal içerisinde yayın yapıcaz(Publish) ve daha sonra bu yayına ViewController içerisinde de bu yayına abone olucaz, böylece CryproViewModal içerisinde bir değişiklik olursa ViewController'dan da bu abone olduğumuz verileri gözlemliyebiliyor olucaz
    
    //11:
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject() //.11 Bunu verilerin o an yğklenip yğklenmediğini kontrol etmek için kullanırız, mesela bir işlemden önce bunu true yapıp bittikten sonra false yaparsak, true ikin ekranda bir dönen bir yüklenme simgesi koyabiliriz. Hatta gidelim ve bunu yapalım. Ama bu işlemi yaparken loading=true yapamıyoruz çünkü bu bir PublishSubject o yüzden self.loading.onNext(true) şeklinde yaparız

    
    func requestData(){
        
        self.loading.onNext(true)
        let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)  //..11 Bu satıra gelebiliyorsa 'result'ı alabilmişiz demektir o yüzden false'a çevirdik.
            
            switch result {
            case.success(let cryptos):
                self.cryptos.onNext(cryptos)
                
            case.failure(let error):
                switch error{
                case.parsingError:
                    self.error.onNext("Paring Error")
                case.serverError:
                    self.error.onNext("Server Error")
                }
                //12 Şimdi ViewController içerisine gidip oraya burada yaptıklarımızı entegre etmemiz lazım 
                
            }
            //10 Şimdi google'a gidip rxswft yazarak github sayfasına gidelim ve readme kısmında Swift Package MAnager ile indirmek için oradaki url'i kopyalayalım
            //.10 Daha sonra File kısmından Add Package Dependencies kısmına tıklayıp linki yapıştıralım ve RxSwift ve RxCocoa'yı seçerek Add Package butonuna basalım. İndirme tamamalndıktan sonra 'Build Phrases' kısmında ikisi dışında herhangi bir tane varsa onları kaldıralım sadece ikisi kalsın. Daha sonra bu class içerisinde RxSwift ve RxCocoa'yı import edelim
        
        }
    }
    
}
