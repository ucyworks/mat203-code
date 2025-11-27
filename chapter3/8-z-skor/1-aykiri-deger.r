# Z-Skoru ile Aykırı Değer Tespiti
# Z-Skor Formülü: z = (x - μ) / σ
# z: Z-skoru (standart skor)
# x: Gözlem değeri
# μ: Ortalama
# σ: Standart sapma
# 
# Kural: |z| > 3 ise aykırı değer olarak kabul edilir
# (Değer ortalamadan 3 standart sapmadan fazla uzaktaysa)

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Verilen bilgiler
mean_value <- 102      # μ: Ortalama hız
std_deviation <- 14    # σ: Standart sapma
speed_values <- c(53, 116, 130)  # Gözlemlenen hız değerleri

# Z-skorlarını hesapla: z = (x - μ) / σ
z_scores <- (speed_values - mean_value) / std_deviation

# Mutlak z-skorlarını hesapla
absolute_z_scores <- abs(z_scores)

# Aykırı değer kontrolu (|z| > 3)
is_outlier <- absolute_z_scores > 3

# Aykırı değer durumunu metin olarak belirt
outlier_status <- ifelse(is_outlier, "AYKIRI DEĞER", "Normal")

# Detaylı analiz tablosu oluştur
analysis_table <- data.frame(
  "Hız (x)" = speed_values,
  "x - μ" = speed_values - mean_value,
  "z-Skoru" = round(z_scores, 4),
  "|z|" = round(absolute_z_scores, 4),
  "|z| > 3?" = is_outlier,
  "Durum" = outlier_status,
  check.names = FALSE
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== Z-SKORU İLE AYKIRI DEĞER TESPİTİ ===\n\n")
cat("Formül: z = (x - μ) / σ\n\n")
cat("Verilen Bilgiler:\n")
cat("- Ortalama hız: μ =", mean_value, "\n")
cat("- Standart sapma: σ =", std_deviation, "\n")
cat("- Gözlem değerleri:", paste(speed_values, collapse = ", "), "\n\n")
cat("Aykırı Değer Kuralı: |z| > 3\n")
cat("(Değer, ortalamadan 3 standart sapmadan fazla uzaktaysa aykırıdır)\n\n")
cat("Hesaplama Sonuçları:\n")
for (i in 1:length(speed_values)) {
  cat(sprintf("%d. Hız = %d:\n", i, speed_values[i]))
  cat(sprintf("   z = (%d - %d) / %d = %.4f\n", speed_values[i], mean_value, std_deviation, z_scores[i]))
  cat(sprintf("   |z| = %.4f %s\n", absolute_z_scores[i], ifelse(is_outlier[i], "> 3 → AYKIRI DEĞER!", "< 3 → Normal")))
  cat("\n")
}

# Tabloyu View ile göster
View(analysis_table)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/8-z-skor"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-aykiri-deger-1-table.png"), 
    width = 1000, height = 350)
grid.table(analysis_table, rows = NULL)
dev.off()

# Sonuç özet tablosu oluştur
result_summary <- data.frame(
  "İstatistik" = c("μ (Ortalama)",
                   "σ (Standart Sapma)",
                   "Toplam Gözlem Sayısı",
                   "Aykırı Değer Sayısı",
                   "Aykırı Değerler"),
  "Değer" = c(mean_value,
              std_deviation,
              length(speed_values),
              sum(is_outlier),
              ifelse(sum(is_outlier) > 0, paste(speed_values[is_outlier], collapse = ", "), "Yok")),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_summary)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "1-aykiri-deger-2-result.png"), 
    width = 800, height = 400)
grid.table(result_summary, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-aykiri-deger-1-table.png"), "\n")
cat("- ", file.path(output_dir, "1-aykiri-deger-2-result.png"), "\n")
