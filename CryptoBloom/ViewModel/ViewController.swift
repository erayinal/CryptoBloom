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


//Bunun MVVM ile bir alakası yok. Sadece bu yapacağımız uygulamada ihtiyaç duyduğumuz bir şey
//2 RxSwift Nedir: Reaktif Programming dediğimiz bir kütüphanedir. Mesela ViewModal'da bir değişiklik yapıldığında View'ı otomatik olarak güncelleme yapar. Bir nevi youtube'da bir kanala abone olmuşuz ve video yüklediğinde size bildirim gelir gibi düşünebiliriz, burada da ViewModal'da yapılan bir değişiklik View'a bildirilir. Bunun alternatifi olan Apple'ın kendi çıkarmış olduğu Combine kütüphanesi de var

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //...3
        tableView.delegate = self
        tableView.dataSource = self
        
        //4 Şimdi yandan Proje dosyasına sağ tıklayıp 'New Group' diyerek, 3 tane grup açalım: Model, View, ViewModel
        //.4 MVVM gruplama yapmak değildir ama gruplama yapmak bize daha düzenli bir kod sağlar.
        //5 Şimdi Model'a sağ tıklayıp New File'dan 'Crypto' adında bir class açalım ve Model'i oluşturmaya başlayalım
    }

    
    //3
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //.3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "Crypto"
        content.secondaryText = "price"
        cell.contentConfiguration = content
        return cell
    }

}

