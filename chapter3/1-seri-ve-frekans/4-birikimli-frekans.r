# Sınıf değerleri (class values)
class_values <- c(0,1,2,3,4,5,6,8)

# Frekanslar (frequencies)
frequencies <- c(3,4,5,6,3,2,1,1)

# Artan birikimli frekans (cumulative frequency - ascending)
# Her sınıfın frekansının önceki sınıfların frekanslarıyla toplamı
cumulative_ascending <- cumsum(frequencies)

# Azalan birikimli frekans (cumulative frequency - descending)
# Her sınıfın frekansının sonraki sınıfların frekanslarıyla toplamı
cumulative_descending <- rev(cumsum(rev(frequencies)))

# Toplam gözlem sayısı (total number of observations)
total_observations <- sum(frequencies)

# Birikimli frekans tablosu oluştur (create cumulative frequency table)
cumulative_table <- data.frame(
  class_values,              # Sınıf değerleri
  frequencies,               # Frekanslar
  cumulative_ascending,      # Artan birikimli frekans
  cumulative_descending      # Azalan birikimli frekans
)

# Toplam satırını ekle (add total row)
total_row <- data.frame(
  class_values = "TOPLAM",
  frequencies = total_observations,
  cumulative_ascending = max(cumulative_ascending),
  cumulative_descending = "-"
)
cumulative_table_with_total <- rbind(cumulative_table, total_row)

# Hesaplama bilgilerini göster
cat("\n=== Birikimli Frekans Hesaplama Bilgileri ===\n")
cat("Toplam Gözlem Sayısı (N):", total_observations, "\n")
cat("Artan Birikimli Frekans: Her sınıfın frekansı + önceki tüm frekanslar\n")
cat("Azalan Birikimli Frekans: Her sınıfın frekansı + sonraki tüm frekanslar\n\n")

# Tabloyu konsolda göster
print(cumulative_table_with_total, row.names = FALSE)

# Tabloyu View ile göster
View(cumulative_table_with_total)

# Tabloyu PNG olarak kaydet
if (!require(gridExtra)) install.packages("gridExtra")
library(gridExtra)

# Sütun isimlerini Türkçeye çevir
colnames_tr <- c("Sınıf Değeri", "Frekans", "Artan Birikimli", "Azalan Birikimli")
table_for_export <- cumulative_table_with_total
colnames(table_for_export) <- colnames_tr

png("chapter3/1-seri-ve-frekans/4-birikimli-frekans-1.png", width = 900, height = 600)
grid.table(table_for_export, rows = NULL)
dev.off()
cat("\nBirikimli frekans tablosu 'chapter3/1-seri-ve-frekans/4-birikimli-frekans-1.png' dosyasına kaydedildi.\n")
