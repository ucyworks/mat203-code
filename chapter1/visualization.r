
# Temel Veri Görselleştirme Örnekleri




# 1. Histogram
# Satış miktarlarının dağılımını gösterir
sales <- c(5, 8, 12, 7, 9, 10, 6, 11, 8, 7)
hist(sales, main="Histogram", xlab="Satış Miktarı", ylab="Frekans", col="skyblue")




# 2. Sütun Grafiği (Barplot) - Fiyata Göre Satış Miktarları
# Farklı fiyat seviyelerinde kaç adet satış yapıldığını gösterir
prices <- c("10M TL", "20M TL", "30M TL", "40M TL")
sales_amount <- c(15, 10, 7, 3)
barplot(sales_amount, names.arg=prices, main="Fiyata Göre Satış Miktarları", xlab="Fiyat", ylab="Satış Miktarı", col="orange")





# 3. Kutu Grafiği (Boxplot)
# Kutu grafiği verinin dağılımını özetler: Ortadaki çizgi medyanı, kutunun alt ve üstü 1. ve 3. çeyrekleri, uçlar ise minimum ve maksimum değerleri gösterir. Noktalar varsa bunlar aykırı (outlier) değerlerdir.
boxplot(sales, main="Satış Miktarı Kutu Grafiği", ylab="Satış Miktarı", xlab="Ürünler", col="lightgreen")



# 4. Çizgi Grafiği (Line Plot)
# Günlere göre satış miktarlarının değişimini gösterir
days <- 1:10
sold <- c(5, 6, 8, 7, 9, 10, 8, 11, 9, 7)
plot(days, sold, type="o", main="Günlere Göre Satış", xlab="Gün", ylab="Satış Miktarı", col="blue")




# 5. Pasta Grafiği (Pie Chart)
# Ürünlerin toplam satış içindeki paylarını gösterir, yüzde olarak etiketler
products <- c("A", "B", "C", "D")
market_share <- c(40, 25, 20, 15)
percent_labels <- paste(products, round(market_share/sum(market_share)*100), "%")
pie(market_share, labels=percent_labels, main="Ürünlerin Pazar Payı")
