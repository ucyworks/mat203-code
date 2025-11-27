# 1-frekans-poligonu.r dosyasındaki verileri kullan (use data from 1-frekans-poligonu.r)
# Sınıf alt sınırları (lower class boundaries)
class_lower <- c(40, 50, 60, 70, 80, 90)

# Sınıf üst sınırları (upper class boundaries)
class_upper <- c(50, 60, 70, 80, 90, 100)

# Frekanslar (frequencies)
frequencies <- c(3, 4, 7, 6, 3, 2)

# Sınıf aralıklarını oluştur (create class intervals)
class_interval <- paste0("[", class_lower, "-", class_upper, ")")

# Artan birikimli frekansı hesapla (calculate ascending cumulative frequency)
# Her sınıfın frekansı + önceki tüm frekanslar
cumulative_ascending <- cumsum(frequencies)

# Azalan birikimli frekansı hesapla (calculate descending cumulative frequency)
# Her sınıfın frekansı + sonraki tüm frekanslar
cumulative_descending <- rev(cumsum(rev(frequencies)))

# Artan birikimli frekans tablosu oluştur (create ascending cumulative frequency table)
ascending_table <- data.frame(
  class_interval,              # Sınıf aralığı
  class_upper,                 # Üst sınır (X ekseni için)
  frequencies,                 # Frekans
  cumulative_ascending         # Artan birikimli frekans
)

# Toplam satırını ekle
total_row_asc <- data.frame(
  class_interval = "TOPLAM",
  class_upper = "-",
  frequencies = sum(frequencies),
  cumulative_ascending = max(cumulative_ascending)
)
ascending_table_with_total <- rbind(ascending_table, total_row_asc)

# Azalan birikimli frekans tablosu oluştur (create descending cumulative frequency table)
descending_table <- data.frame(
  class_interval,              # Sınıf aralığı
  class_lower,                 # Alt sınır (X ekseni için)
  frequencies,                 # Frekans
  cumulative_descending        # Azalan birikimli frekans
)

# Toplam satırını ekle
total_row_desc <- data.frame(
  class_interval = "TOPLAM",
  class_lower = "-",
  frequencies = sum(frequencies),
  cumulative_descending = max(cumulative_descending)
)
descending_table_with_total <- rbind(descending_table, total_row_desc)

# Hesaplama bilgilerini göster
cat("\n=== Birikimli Frekans Hesaplama Bilgileri ===\n")
cat("Toplam Gözlem Sayısı (N):", sum(frequencies), "\n")
cat("Artan Birikimli: Her sınıfın frekansı + önceki tüm frekanslar\n")
cat("Azalan Birikimli: Her sınıfın frekansı + sonraki tüm frekanslar\n\n")

# Tabloları konsolda göster
cat("=== Artan Birikimli Frekans (Ogive ≤) ===\n")
print(ascending_table_with_total, row.names = FALSE)

cat("\n=== Azalan Birikimli Frekans (Ogive ≥) ===\n")
print(descending_table_with_total, row.names = FALSE)

# Tabloları View ile göster
View(ascending_table_with_total)
View(descending_table_with_total)

# Tabloları PNG olarak kaydet
if (!require(gridExtra)) install.packages("gridExtra")
library(gridExtra)

png("chapter3/2-grafik/2-birikimli-frekans-poligonu-1-table.png", width = 900, height = 600)
grid.table(ascending_table_with_total, rows = NULL)
dev.off()
cat("\nArtan birikimli tablo 'chapter3/2-grafik/2-birikimli-frekans-poligonu-1-table.png' dosyasına kaydedildi.\n")

png("chapter3/2-grafik/2-birikimli-frekans-poligonu-2-table.png", width = 900, height = 600)
grid.table(descending_table_with_total, rows = NULL)
dev.off()
cat("Azalan birikimli tablo 'chapter3/2-grafik/2-birikimli-frekans-poligonu-2-table.png' dosyasına kaydedildi.\n")

# Artan birikimli frekans grafiğini oluştur (create ascending cumulative frequency graph - Ogive ≤)
png("chapter3/2-grafik/2-birikimli-frekans-poligonu-1.png", width = 800, height = 600)
plot(class_upper, cumulative_ascending, type="o", main="Ogive (≤) - Artan Birikimli Frekans", 
     xlab="Üst Sınır", ylab="Birikimli Frekans",
     col="blue", lwd=2, pch=19, las=1, cex.axis=1.2, cex.lab=1.2)
grid()
dev.off()
cat("Artan birikimli grafik 'chapter3/2-grafik/2-birikimli-frekans-poligonu-1.png' dosyasına kaydedildi.\n")

# Azalan birikimli frekans grafiğini oluştur (create descending cumulative frequency graph - Ogive ≥)
png("chapter3/2-grafik/2-birikimli-frekans-poligonu-2.png", width = 800, height = 600)
plot(class_lower, cumulative_descending, type="o", main="Ogive (≥) - Azalan Birikimli Frekans",
     xlab="Alt Sınır", ylab="Birikimli Frekans",
     col="red", lwd=2, pch=19, las=1, cex.axis=1.2, cex.lab=1.2)
grid()
dev.off()
cat("Azalan birikimli grafik 'chapter3/2-grafik/2-birikimli-frekans-poligonu-2.png' dosyasına kaydedildi.\n")