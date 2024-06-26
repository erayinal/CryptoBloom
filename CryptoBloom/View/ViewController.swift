//
//  ViewController.swift
//  CryptoBloom
//
//  Created by Eray İnal on 3.04.2024.
//

//1 Modal-View-ViewModel(MVVM) nedir?: Bir yazılım geliştirme mimarisidir. Sadece mobil için değil web'de de kullanılan bir mimaridir.
//.1 Biz şu ana kadar elimizde ne kod varsa hepsini ViewContoller içerine yazdık bu çok mantıklı değil. Çünkü bir değişiklik yapılacaksa her şeyi baştan sona değiştirmek demek. Aslında bizim kodumuz ne kadar dağınık olursa,  her fonksiyonun sadece kendi işini yaptığı bir kodlama olursa o kadar iyi olur, hem test etmek için hem de değişiklik için.
//.1 View içerisinde: Kullanıcının göreceği şeyler olacak
//..1 ViewModal içerisinde: Mesela internetten veri mi çekilecek ya da o veri işlenecek mi... bunları ViewModal içerisinde yaparız


//RxSwift'in MVVM ile bir alakası yok. Sadece bu yapacağımız uygulamada ihtiyaç duyduğumuz bir şey
//2 RxSwift Nedir: Reaktif Programming dediğimiz bir kütüphanedir. Mesela ViewModal'da bir değişiklik yapıldığında View'ı otomatik olarak güncelleme yapar. Bir nevi youtube'da bir kanala abone olmuşuz ve video yüklediğinde size bildirim gelir gibi düşünebiliriz, burada da ViewModal'da yapılan bir değişiklik View'a bildirilir. Bunun alternatifi olan Apple'ın kendi çıkarmış olduğu Combine kütüphanesi de var

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!  //.13 şimdi setupBinding methodu içerisine gidelim
    
    var cryptoList = [Crypto]() //9:

    
    let cryptoVM = CryptoViewModal() //.11 Bunu yaptıktan sonra viewDidLoad methodu içerisinde cryptoVM.requestData() yazarsak veri indirilecektir.
    let disposeBag = DisposeBag() //.12 bunu yaparak bu tuttuğumuz verilerin hafızada çok yer tutmamasını sağlayacağız. Bu yüzden setupBindings içerisinde observe yaptığımız şeyden sonra disposed(by: disposeBag) yazmalıyız.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //..3
        //tableView.delegate = self     //....14
        //tableView.dataSource = self   //.....14 bunlara da gerek yok
        
        //4 Şimdi yandan Proje dosyasına sağ tıklayıp 'New Group' diyerek, 3 tane grup açalım: Model, View, ViewModel
        //.4 MVVM gruplama yapmak değildir ama gruplama yapmak bize daha düzenli bir kod sağlar.
        //5 Şimdi Model'a sağ tıklayıp New File'dan 'Crypto' adında bir class açalım ve Model'i oluşturmaya başlayalım
        
        setupBindings()  //.12
        cryptoVM.requestData() //..11 Şimdi bu değişknelerde değişiklik oluesa ne olacağını belirtmemiz için setupBindings adında bir method açalım
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    //12:
    private func setupBindings(){
        cryptoVM.loading.bind(to: self.indicatorView.rx.isAnimating).disposed(by: disposeBag) //..13
        
        
        cryptoVM.error.observe(on: MainScheduler.asyncInstance).subscribe { errorString in
            print(errorString)
        }.disposed(by: disposeBag)
        
        
        /*
        cryptoVM.cryptos.observe(on: MainScheduler.asyncInstance).subscribe { cryptos in
            self.cryptoList = cryptos
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
         */ //...13 Burayı artık kullanmayacağız
        //.14 Bunun yerine şunu yapmalıyız:
        cryptoVM.cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "cryptoProtCell", cellType: CryptoTableViewCell.self)){ row,item,cell in
            cell.item = item
        }.disposed(by: disposeBag)
        
        //13 Şimdi main içerisine gidip + tuşuna basıp 'Medium Activity Indicator' ekleyelim ve attributes kısmından 'Hides when stopped' işaretleyelim. Ve sonrasında bu class'a gelip tanımlayalım
    }

    
    
    //..14 Bunu da artık kaldıracağız çünkü artık bunun görevini rx üstleniyor artık
    /*
    //3
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    //.3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        
        content.text = cryptoList[indexPath.row].currency           //.9
        content.secondaryText = cryptoList[indexPath.row].price     //..9
        
        cell.contentConfiguration = content
        return cell
    }
     */
    //...14 Bu class artık UITableViewDataSource olmayacak onu da siliyorum

}

