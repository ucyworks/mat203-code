# Ham veri seti (raw data)
raw_data <- c(13.5, 9.5, 8.2, 6.5, 8.4, 8.1, 6.9, 7.5, 10.5, 13.5, 7.2, 7.1)

# Sınıf sayısını Sturges formülü ile hesapla (calculate number of classes using Sturges formula)
# k = 1 + 3.322 × log10(n), n = gözlem sayısı
number_of_classes <- ceiling(1 + 3.322 * log10(length(raw_data)))

# Sınıf genişliğini hesapla (calculate class width)
# Genişlik = (Maksimum - Minimum) / Sınıf Sayısı
class_width <- (max(raw_data) - min(raw_data)) / number_of_classes

# Sınıf sınırlarını oluştur (create class boundaries)
class_breaks <- seq(floor(min(raw_data)), ceiling(max(raw_data)), by = class_width)

# Verileri gruplara ayır (group data into classes)
grouped_data <- cut(raw_data, breaks = class_breaks, right = FALSE)

# Frekans tablosu oluştur (create frequency table)
frequency_table <- table(grouped_data)

# Detaylı bilgi tablosu oluştur (create detailed information table)
summary_info <- data.frame(
  metric = c("Gözlem Sayısı (n)", "Minimum Değer", "Maksimum Değer", 
             "Aralık (Range)", "Sınıf Sayısı (k)", "Sınıf Genişliği"),
  value = c(length(raw_data), min(raw_data), max(raw_data),
            max(raw_data) - min(raw_data), number_of_classes, class_width)
)

# Frekans tablosunu veri çerçevesine çevir (convert frequency table to data frame)
freq_df <- data.frame(
  class_interval = names(frequency_table),  # Sınıf aralığı
  frequency = as.numeric(frequency_table)   # Frekans
)

# Toplam satırını ekle (add total row)
total_row <- data.frame(
  class_interval = "TOPLAM",
  frequency = sum(freq_df$frequency)
)
freq_df_with_total <- rbind(freq_df, total_row)

# Özet bilgileri konsolda göster
cat("\n=== Gruplama Bilgileri ===\n")
print(summary_info, row.names = FALSE)

cat("\n=== Frekans Tablosu ===\n")
print(freq_df_with_total, row.names = FALSE)

# Tabloları View ile göster
View(summary_info)
View(freq_df_with_total)

# Tabloları PNG olarak kaydet
# gridExtra paketi yükle
if (!require(gridExtra)) install.packages("gridExtra")
library(gridExtra)

# 1. Özet bilgiler tablosu
png("chapter3/1-seri-ve-frekans/grup-seri-1-summary.png", width = 800, height = 400)
grid.table(summary_info, rows = NULL)
dev.off()
cat("\nÖzet bilgiler 'chapter3/1-seri-ve-frekans/grup-seri-1-summary.png' dosyasına kaydedildi.\n")

# 2. Frekans tablosu
png("chapter3/1-seri-ve-frekans/grup-seri-1-frequency.png", width = 800, height = 500)
grid.table(freq_df_with_total, rows = NULL)
dev.off()
cat("Frekans tablosu 'chapter3/1-seri-ve-frekans/grup-seri-1-frequency.png' dosyasına kaydedildi.\n")
