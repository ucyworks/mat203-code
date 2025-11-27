# Sınıf alt sınırları (lower class boundaries)
class_lower <- c(40, 50, 60, 70, 80, 90)

# Sınıf üst sınırları (upper class boundaries)
class_upper <- c(50, 60, 70, 80, 90, 100)

# Sınıf orta noktalarını hesapla (calculate class midpoints)
# Orta nokta = (Alt sınır + Üst sınır) / 2
class_midpoint <- (class_lower + class_upper) / 2

# Frekanslar (frequencies)
frequencies <- c(3, 4, 7, 6, 3, 2)

# Sınıf aralıklarını oluştur (create class intervals as text)
class_interval <- paste0("[", class_lower, "-", class_upper, ")")

# Frekans poligonu tablosu oluştur (create frequency polygon table)
polygon_table <- data.frame(
  class_interval,      # Sınıf aralığı
  class_midpoint,      # Sınıf orta noktası
  frequencies          # Frekans
)

# Toplam satırını ekle (add total row)
total_row <- data.frame(
  class_interval = "TOPLAM",
  class_midpoint = "-",
  frequencies = sum(frequencies)
)
polygon_table_with_total <- rbind(polygon_table, total_row)

# Hesaplama bilgilerini göster
cat("\n=== Frekans Poligonu Hesaplama Bilgileri ===\n")
cat("Toplam Gözlem Sayısı (N):", sum(frequencies), "\n")
cat("Sınıf Orta Noktası = (Alt Sınır + Üst Sınır) / 2\n\n")

# Tabloyu konsolda göster
print(polygon_table_with_total, row.names = FALSE)

# Tabloyu View ile göster
View(polygon_table_with_total)

# Tabloyu PNG olarak kaydet
if (!require(gridExtra)) install.packages("gridExtra")
library(gridExtra)

png("chapter3/2-grafik/1-frekans-poligonu-1-table.png", width = 800, height = 500)
grid.table(polygon_table_with_total, rows = NULL)
dev.off()
cat("Frekans poligonu tablosu 'chapter3/2-grafik/1-frekans-poligonu-1-table.png' dosyasına kaydedildi.\n")

# Frekans poligonu grafiğini oluştur ve PNG olarak kaydet (create frequency polygon and save as PNG)
png("chapter3/2-grafik/1-frekans-poligonu-1.png", width = 800, height = 600)
plot(class_midpoint, frequencies, type="o", main="Frekans Poligonu",
     xlab="Sınıf Orta Noktası", ylab="Frekans", 
     col="blue", lwd=2, pch=19, las=1, cex.axis=1.2, cex.lab=1.2)
grid()  # Izgara ekle
dev.off()
cat("Frekans poligonu grafiği 'chapter3/2-grafik/1-frekans-poligonu-1.png' dosyasına kaydedildi.\n")
