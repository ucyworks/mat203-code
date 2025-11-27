# Frekans Serisinde Standart Sapma ve Varyans Hesaplama
# Varyans Formülü: σ² = Σ[f×(x - X̄)²] / N
# Standart Sapma Formülü: σ = √σ²
# σ²: Varyans (variance)
# σ: Standart sapma (standard deviation)
# X̄: Aritmetik ortalama
# f: Frekans
# x: Değer
# N: Toplam frekans

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri: değerler (x) ve frekanslar (f)
values <- c(2, 3, 4, 5, 6, 7, 8, 9, 10)
frequencies <- c(2, 4, 5, 10, 20, 30, 20, 10, 3)

# Toplam frekansı hesapla
total_frequency <- sum(frequencies)

# Aritmetik ortalamayı hesapla: X̄ = Σ(f×x) / N
mean_value <- sum(frequencies * values) / total_frequency

# Sapmaları hesapla: (x - X̄)
deviations <- values - mean_value

# Sapmaların karelerini hesapla: (x - X̄)²
squared_deviations <- deviations^2

# f×(x - X̄)² değerlerini hesapla
f_times_squared_deviations <- frequencies * squared_deviations

# Varyansı hesapla: σ² = Σ[f×(x - X̄)²] / N
variance <- sum(f_times_squared_deviations) / total_frequency

# Standart sapmayı hesapla: σ = √σ²
standard_deviation <- sqrt(variance)

# Detaylı hesaplama tablosu oluştur
calculation_table <- data.frame(
  "Değer (x)" = values,
  "Frekans (f)" = frequencies,
  "x - X̄" = round(deviations, 4),
  "(x - X̄)²" = round(squared_deviations, 4),
  "f×(x - X̄)²" = round(f_times_squared_deviations, 4),
  check.names = FALSE
)

# Toplam satırını ekle
calculation_table_with_total <- rbind(
  calculation_table,
  data.frame(
    "Değer (x)" = "TOPLAM",
    "Frekans (f)" = total_frequency,
    "x - X̄" = "",
    "(x - X̄)²" = "",
    "f×(x - X̄)²" = round(sum(f_times_squared_deviations), 4),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== FREKANS SERİSİNDE STANDART SAPMA VE VARYANS HESAPLAMA ===\n\n")
cat("Formül:\n")
cat("  Varyans: σ² = Σ[f×(x - X̄)²] / N\n")
cat("  Standart Sapma: σ = √σ²\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Toplam frekans: N =", total_frequency, "\n")
cat("2. Aritmetik ortalama: X̄ = Σ(f×x)/N =", mean_value, "\n")
cat("3. Her değer için sapma: (x - X̄)\n")
cat("4. Sapmaların karesi: (x - X̄)²\n")
cat("5. Frekans ile çarp: f×(x - X̄)²\n")
cat("6. Topla: Σ[f×(x - X̄)²] =", sum(f_times_squared_deviations), "\n")
cat("7. Varyans: σ² =", sum(f_times_squared_deviations), "/", total_frequency, "=", variance, "\n")
cat("8. Standart Sapma: σ = √", variance, "=", standard_deviation, "\n\n")

# Tabloyu View ile göster
View(calculation_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/7-standart-sapma"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-frekans-serisi-ss-1-table.png"), 
    width = 1000, height = 650)
grid.table(calculation_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("N (Toplam Frekans)",
                   "X̄ (Aritmetik Ortalama)",
                   "Σ[f×(x - X̄)²] (Toplam)",
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
png(file.path(output_dir, "1-frekans-serisi-ss-2-result.png"), 
    width = 800, height = 400)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-frekans-serisi-ss-1-table.png"), "\n")
cat("- ", file.path(output_dir, "1-frekans-serisi-ss-2-result.png"), "\n")
