# Gruplandırılmış Seride Standart Sapma ve Varyans Hesaplama
# Varyans Formülü: σ² = Σ[f×(m - X̄)²] / N
# Standart Sapma Formülü: σ = √σ²
# σ²: Varyans (variance)
# σ: Standart sapma (standard deviation)
# X̄: Aritmetik ortalama
# f: Frekans
# m: Sınıf orta noktası (midpoint)
# N: Toplam frekans

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri: sınıf aralıkları ve frekanslar
class_lower <- c(0, 10, 20, 30, 40, 50)
class_upper <- c(10, 20, 30, 40, 50, 60)
frequencies <- c(5, 8, 12, 10, 7, 3)

# Sınıf orta noktalarını hesapla: m = (alt sınır + üst sınır) / 2
class_midpoint <- (class_lower + class_upper) / 2

# Toplam frekansı hesapla
total_frequency <- sum(frequencies)

# Aritmetik ortalamayı hesapla: X̄ = Σ(f×m) / N
mean_value <- sum(frequencies * class_midpoint) / total_frequency

# Sapmaları hesapla: (m - X̄)
deviations <- class_midpoint - mean_value

# Sapmaların karelerini hesapla: (m - X̄)²
squared_deviations <- deviations^2

# f×(m - X̄)² değerlerini hesapla
f_times_squared_deviations <- frequencies * squared_deviations

# Varyansı hesapla: σ² = Σ[f×(m - X̄)²] / N
variance <- sum(f_times_squared_deviations) / total_frequency

# Standart sapmayı hesapla: σ = √σ²
standard_deviation <- sqrt(variance)

# Sınıf aralıklarını metin olarak oluştur
class_intervals <- paste0(class_lower, " - ", class_upper)

# Detaylı hesaplama tablosu oluştur
calculation_table <- data.frame(
  "Sınıf Aralığı" = class_intervals,
  "Orta Nokta (m)" = class_midpoint,
  "Frekans (f)" = frequencies,
  "m - X̄" = round(deviations, 4),
  "(m - X̄)²" = round(squared_deviations, 4),
  "f×(m - X̄)²" = round(f_times_squared_deviations, 4),
  check.names = FALSE
)

# Toplam satırını ekle
calculation_table_with_total <- rbind(
  calculation_table,
  data.frame(
    "Sınıf Aralığı" = "TOPLAM",
    "Orta Nokta (m)" = "",
    "Frekans (f)" = total_frequency,
    "m - X̄" = "",
    "(m - X̄)²" = "",
    "f×(m - X̄)²" = round(sum(f_times_squared_deviations), 4),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== GRUPLANDIRIMIŞ SERİDE STANDART SAPMA VE VARYANS HESAPLAMA ===\n\n")
cat("Formül:\n")
cat("  Varyans: σ² = Σ[f×(m - X̄)²] / N\n")
cat("  Standart Sapma: σ = √σ²\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Sınıf orta noktaları: m = (alt + üst) / 2\n")
cat("2. Toplam frekans: N =", total_frequency, "\n")
cat("3. Aritmetik ortalama: X̄ = Σ(f×m)/N =", mean_value, "\n")
cat("4. Her orta nokta için sapma: (m - X̄)\n")
cat("5. Sapmaların karesi: (m - X̄)²\n")
cat("6. Frekans ile çarp: f×(m - X̄)²\n")
cat("7. Topla: Σ[f×(m - X̄)²] =", sum(f_times_squared_deviations), "\n")
cat("8. Varyans: σ² =", sum(f_times_squared_deviations), "/", total_frequency, "=", variance, "\n")
cat("9. Standart Sapma: σ = √", variance, "=", standard_deviation, "\n\n")

# Tabloyu View ile göster
View(calculation_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/7-standart-sapma"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "2-gruplanmis-seri-ss-1-table.png"), 
    width = 1100, height = 500)
grid.table(calculation_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("N (Toplam Frekans)",
                   "X̄ (Aritmetik Ortalama)",
                   "Σ[f×(m - X̄)²] (Toplam)",
                   "σ² (Varyans)",
                   "σ (Standart Sapma)"),
  "Değer" = c(total_frequency,
              mean_value,
              sum(f_times_squared_deviations),
              variance,
              standard_deviation),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "2-gruplanmis-seri-ss-2-result.png"), 
    width = 800, height = 400)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "2-gruplanmis-seri-ss-1-table.png"), "\n")
cat("- ", file.path(output_dir, "2-gruplanmis-seri-ss-2-result.png"), "\n")