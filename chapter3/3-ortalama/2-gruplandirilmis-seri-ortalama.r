# Gruplandırılmış Seride Aritmetik Ortalama Hesaplama
# Formül: X̄ = Σ(f·m) / Σf
# X̄: Aritmetik ortalama
# f: Frekans (sıklık)
# m: Sınıf orta noktası (midpoint)
# m = (sınıf alt sınırı + sınıf üst sınırı) / 2

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri: sınıf aralıkları ve frekanslar
class_lower <- c(0, 2, 4, 6, 10)
class_upper <- c(2, 4, 6, 10, 20)
frequencies <- c(5, 10, 40, 30, 25)

# Sınıf orta noktalarını hesapla: m = (alt sınır + üst sınır) / 2
class_midpoint <- (class_lower + class_upper) / 2

# f·m (frekans × orta nokta) çarpımlarını hesapla
frequency_times_midpoint <- frequencies * class_midpoint

# Toplam frekans ve toplam (f·m) hesapla
total_frequency <- sum(frequencies)
total_fm <- sum(frequency_times_midpoint)

# Aritmetik ortalama hesapla: X̄ = Σ(f·m) / Σf
arithmetic_mean <- total_fm / total_frequency

# Sınıf aralıklarını metin olarak oluştur
class_intervals <- paste0(class_lower, " - ", class_upper)

# Detaylı hesaplama tablosu oluştur
calculation_table <- data.frame(
  "Sınıf Aralığı" = class_intervals,
  "Sınıf Orta Noktası (m)" = class_midpoint,
  "Frekans (f)" = frequencies,
  "f × m" = frequency_times_midpoint,
  check.names = FALSE
)

# Toplam satırını ekle
calculation_table_with_total <- rbind(
  calculation_table,
  data.frame(
    "Sınıf Aralığı" = "TOPLAM",
    "Sınıf Orta Noktası (m)" = "",
    "Frekans (f)" = total_frequency,
    "f × m" = total_fm,
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== GRUPLANDIRIMIŞ SERİDE ARİTMETİK ORTALAMA HESAPLAMA ===\n\n")
cat("Formül: X̄ = Σ(f·m) / Σf\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Her sınıf için orta noktayı hesapla: m = (alt sınır + üst sınır) / 2\n")
cat("2. Her orta noktayı frekansıyla çarp (f·m)\n")
cat("3. Tüm frekansları topla: Σf =", total_frequency, "\n")
cat("4. Tüm (f·m) değerlerini topla: Σ(f·m) =", total_fm, "\n")
cat("5. Aritmetik ortalama: X̄ =", total_fm, "/", total_frequency, "=", arithmetic_mean, "\n\n")

# Tabloyu View ile göster
View(calculation_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/3-ortalama"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "2-gruplandirilmis-seri-ortalama-1-table.png"), 
    width = 900, height = 450)
grid.table(calculation_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("Σf (Toplam Frekans)", 
                   "Σ(f·m) (Toplam f×m)", 
                   "X̄ (Aritmetik Ortalama)"),
  "Değer" = c(total_frequency, 
              total_fm, 
              arithmetic_mean),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "2-gruplandirilmis-seri-ortalama-2-result.png"), 
    width = 700, height = 300)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "2-gruplandirilmis-seri-ortalama-1-table.png"), "\n")
cat("- ", file.path(output_dir, "2-gruplandirilmis-seri-ortalama-2-result.png"), "\n")
