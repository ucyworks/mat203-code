# Temel R Dili Kavramları ve Fonksiyonları

# 1. Değişken Türleri
sayi <- 10                # Sayısal (numeric) değişken
karakter <- "Merhaba"     # Karakter (character) değişken
mantiksal <- TRUE         # Mantıksal (logical) değişken
vektor <- c(1, 2, 3, 4)   # Vektör (aynı türden birden fazla değer)
liste <- list(1, "a", TRUE) # Liste (farklı türden değerler)

# 2. Kütüphane/Paket Kullanımı
# install.packages("ggplot2") # Paket yükleme (ilk seferde gerekirse)
library(ggplot2)             # Paket yükleme (kullanmak için)

# 3. Veri Tanımlama
veri <- c(5, 8, 12, 7, 9)    # Vektör olarak veri tanımlama
df <- data.frame(sayi=veri, grup=c("A", "B", "A", "B", "A")) # Veri çerçevesi

# 4. Sayısal Fonksiyonlar
mutlak_deger <- abs(-15)     # Mutlak değer
ortalama <- mean(veri)       # Ortalama
medyan <- median(veri)       # Medyan
standart_sapma <- sd(veri)   # Standart sapma

# 5. Konsola Çıktı Yazdırma
print("Merhaba R!")
print(paste("Ortalama:", ortalama))
cat("Medyan:", medyan, "\n")

# 6. Histogram Çizdirme
hist(veri, main="Veri Histogramı", xlab="Değerler", col="lightblue")

# 7. Yardım Alma
# ?mean   # mean fonksiyonu hakkında yardım almak için

# 8. Faktör (Kategori) Değişkenler
grup_faktor <- factor(df$grup)
print(grup_faktor)

# 9. Temel İstatistiksel Özet
summary(veri)
x <- c(1, 2, 3, 4, 5)
y <- c(6, 7, 8, 9, 10)
z <- c(11, 12, 13, 14, 15)

mean(y)