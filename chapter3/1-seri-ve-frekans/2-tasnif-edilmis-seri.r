# Sınıf değerleri (class values)
class_values <- c(0,1,2,3,4,5,6,8)

# Frekanslar (frequencies)
frequencies <- c(3,4,5,6,3,2,1,1)

# Toplam gözlem sayısı (total number of observations)
total_observations <- sum(frequencies)

# Göreli frekans (relative frequency)
relative_frequency <- frequencies / total_observations

# Yüzde frekans (percentage frequency)
percentage_frequency <- relative_frequency * 100

# Tasnif edilmiş seri tablosu (classified series table)
classified_table <- data.frame(
  class_values,           # Sınıf değerleri
  frequencies,            # Frekanslar
  relative_frequency,     # Göreli frekans
  percentage_frequency    # Yüzde frekans
)

# Toplam satırını ekle (add totals row)
total_row <- data.frame(
  class_values = "TOTAL",                      # Toplam etiketi
  frequencies = sum(frequencies),              # Frekansların toplamı (N)
  relative_frequency = sum(relative_frequency), # Göreli frekansların toplamı (1.00)
  percentage_frequency = sum(percentage_frequency) # Yüzde toplamı (100%)
)

# Tabloyu toplam satırı ile birleştir
classified_table_with_total <- rbind(classified_table, total_row)

# Not: Göreli frekans = Frekans / Toplam Gözlem Sayısı (N)
# Not: Yüzde frekans = Göreli frekans * 100
cat("\nNot: Toplam gözlem sayısı (N) =", total_observations, "\n")
cat("Göreli frekans = Frekans / N\n")
cat("Yüzde frekans = Göreli frekans × 100\n\n")

# Tabloyu konsolda göster
print(classified_table_with_total)

# Tabloyu görüntüleyici penceresinde göster
View(classified_table_with_total)

# Tabloyu PNG olarak kaydet
png("chapter3/1-seri-ve-frekans/2-tasnif-edilmis-seri.png", width = 800, height = 600)
par(mar = c(1, 1, 3, 1))  # Kenar boşluklarını ayarla
plot.new()  # Yeni bir grafik alanı oluştur
title(main = "Tasnif Edilmiş Seri Tablosu", cex.main = 1.5)  # Başlık ekle

# Tabloyu grafik olarak çiz
# Sütun isimlerini Türkçeye çevir
colnames_tr <- c("Sınıf Değeri", "Frekans", "Göreli Frekans", "Yüzde (%)")

# Tabloyu metin olarak göster
table_text <- rbind(colnames_tr, 
                    as.matrix(classified_table_with_total))

# Tablo çizimi için gridExtra paketi kullan
if (!require(gridExtra)) install.packages("gridExtra")
library(gridExtra)

# Grafik alanını temizle ve tabloyu çiz
grid.table(table_text, rows = NULL)

dev.off()  # PNG cihazını kapat
cat("\nTablo 'chapter3/1-seri-ve-frekans/2-tasnif-edilmis-seri.png' dosyasına kaydedildi.\n")
  