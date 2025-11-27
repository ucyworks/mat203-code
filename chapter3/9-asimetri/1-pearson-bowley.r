# Asimetri Katsayıları: Pearson ve Bowley Yöntemleri
# 
# Pearson 1. Asimetri Katsayısı: SK1 = (X̄ - Mod) / σ
# Pearson 2. Asimetri Katsayısı: SK2 = 3(X̄ - Medyan) / σ
# Bowley Asimetri Katsayısı: SKB = (Q3 + Q1 - 2×Q2) / (Q3 - Q1)
# 
# Yorum:
# - SK = 0: Simetrik dağılım
# - SK > 0: Sağa çarpık (pozitif çarpıklık)
# - SK < 0: Sola çarpık (negatif çarpıklık)

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri
values <- c(45, 52, 58, 60, 62, 65, 68, 70, 72, 75, 78, 80, 82, 85, 90, 95, 100)

# Temel istatistikleri hesapla
mean_value <- mean(values)
median_value <- median(values)
std_deviation <- sd(values)

# Mod (en sık tekrar eden değer) hesaplama
# Eğer mod yoksa ortalamayı kullanıyoruz (yaklaşık simetrik dağılım için)
freq_table <- table(values)
mode_value <- as.numeric(names(freq_table)[which.max(freq_table)])

# Kartilleri hesapla
q1 <- quantile(values, 0.25, type = 7)
q2 <- quantile(values, 0.50, type = 7)  # Medyan
q3 <- quantile(values, 0.75, type = 7)

# Pearson 1. Asimetri Katsayısı: SK1 = (X̄ - Mod) / σ
pearson_sk1 <- (mean_value - mode_value) / std_deviation

# Pearson 2. Asimetri Katsayısı: SK2 = 3(X̄ - Medyan) / σ
pearson_sk2 <- 3 * (mean_value - median_value) / std_deviation

# Bowley Asimetri Katsayısı: SKB = (Q3 + Q1 - 2×Q2) / (Q3 - Q1)
bowley_sk <- (q3 + q1 - 2 * q2) / (q3 - q1)

# Asimetri yorumu fonksiyonu
interpret_skewness <- function(sk) {
  if (abs(sk) < 0.1) return("Neredeyse Simetrik")
  else if (sk > 0) return("Sağa Çarpık (Pozitif)")
  else return("Sola Çarpık (Negatif)")
}

# Veri özet tablosu
data_summary <- data.frame(
  "Sira" = 1:length(values),
  "Değer" = values,
  check.names = FALSE
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== ASİMETRİ KATSAYILARI: PEARSON VE BOWLEY ===\n\n")
cat("Veri Sayısı: n =", length(values), "\n\n")
cat("Temel İstatistikler:\n")
cat("- Ortalama (X̄) =", mean_value, "\n")
cat("- Medyan =", median_value, "\n")
cat("- Mod =", mode_value, "\n")
cat("- Standart Sapma (σ) =", std_deviation, "\n")
cat("- Q1 (1. Kartil) =", as.numeric(q1), "\n")
cat("- Q2 (Medyan) =", as.numeric(q2), "\n")
cat("- Q3 (3. Kartil) =", as.numeric(q3), "\n\n")
cat("Asimetri Katsayıları:\n")
cat("1. Pearson SK1 = (X̄ - Mod) / σ\n")
cat("   SK1 = (", mean_value, " - ", mode_value, ") / ", std_deviation, " = ", pearson_sk1, "\n")
cat("   Yorum:", interpret_skewness(pearson_sk1), "\n\n")
cat("2. Pearson SK2 = 3(X̄ - Medyan) / σ\n")
cat("   SK2 = 3×(", mean_value, " - ", median_value, ") / ", std_deviation, " = ", pearson_sk2, "\n")
cat("   Yorum:", interpret_skewness(pearson_sk2), "\n\n")
cat("3. Bowley SKB = (Q3 + Q1 - 2×Q2) / (Q3 - Q1)\n")
cat("   SKB = (", as.numeric(q3), " + ", as.numeric(q1), " - 2×", as.numeric(q2), ") / (", as.numeric(q3), " - ", as.numeric(q1), ")\n")
cat("   SKB = ", bowley_sk, "\n")
cat("   Yorum:", interpret_skewness(bowley_sk), "\n\n")

# Tabloyu View ile göster
View(data_summary)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/9-asimetri"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-pearson-bowley-1-data.png"), 
    width = 700, height = 800)
grid.table(data_summary, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("n (Veri Sayısı)",
                   "X̄ (Ortalama)",
                   "Medyan",
                   "Mod",
                   "σ (Standart Sapma)",
                   "Q1 (1. Kartil)",
                   "Q2 (Medyan)",
                   "Q3 (3. Kartil)",
                   "Pearson SK1",
                   "Pearson SK2",
                   "Bowley SKB"),
  "Değer" = c(length(values),
              round(mean_value, 4),
              round(median_value, 4),
              mode_value,
              round(std_deviation, 4),
              round(as.numeric(q1), 4),
              round(as.numeric(q2), 4),
              round(as.numeric(q3), 4),
              round(pearson_sk1, 4),
              round(pearson_sk2, 4),
              round(bowley_sk, 4)),
  "Yorum" = c("", "", "", "", "", "", "", "",
              interpret_skewness(pearson_sk1),
              interpret_skewness(pearson_sk2),
              interpret_skewness(bowley_sk)),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "1-pearson-bowley-2-result.png"), 
    width = 950, height = 700)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-pearson-bowley-1-data.png"), "\n")
cat("- ", file.path(output_dir, "1-pearson-bowley-2-result.png"), "\n")
