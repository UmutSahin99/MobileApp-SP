# ShipShop

Bu uygulama Software Persona staj çıktısı olarak hazırlanmış mobil bir satın alım uygulamasıdır.

Flutter Versiyon 3.44.2 kullanılarak yazılmıştır.

Uygulama kullanıcıyı bir Login ekranı ardından API ile wantpiden çekilmiş dummy json verilerinin ürün kartları olarak listelendiği bir sayfaya yönlendirir.
Bu sayfada arama çubuğu ile kullanıcı istediği ürünü ismiyle arayabilir.
Kullanıcı bir ürün kartına tıkladıktan sonra o ürünün ayrıntılarının bulunduğu bir sayfaya yönlendirilir.
Bu ayrıntılar ürünün adı,fiyatı,açıklaması ve ürün özellikleri içerir.
Sonrasında kullanıcı Sayfanın sonunda yer alan Purchase veya Finish buttonlarıyla ürünü sepete ekleyebilir veya dilerse alışverişini sonlandırabilir.
Kullanıcı istediği ürünleri sepetine ekleyip Listeleme ekranındaki sepet butonundan veya ürün ayrıntısı sayfasındaki "Finish" butonuyla alışverişini bitirir ve sepet sayfasına yönlendirilir.
Sepet sayfası içerisinde kullanıcı alacağı ürünü almaktan vazgeçerse ürün kutucuğunun yanındaki sil butonuyla ürünü seçilenlerden kaldırabilir.
Ürünleri satın alma işlemini sonlandırmayı seçtiğinde de sepetindeki ürünler temizlenir ve kullanıcıya "Satın Alımınız Başarılı" şeklinde pop up bir geribildirim verilir.
