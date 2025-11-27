# Momentler, Asimetri ve Basıklık Katsayıları
# 
# Merkezi Momentler:
# m2 = Σ(x - μ)² / n  (2. merkezi moment - varyans)
# m3 = Σ(x - μ)³ / n  (3. merkezi moment)
# m4 = Σ(x - μ)⁴ / n  (4. merkezi moment)
# 
# Asimetri Moment Katsayısı: α3 = m3 / (m2)^(3/2)
# Basıklık Katsayısı: α4 = m4 / (m2)²
# 
# Asimetri Yorumu (α3):
# - α3 = 0: Simetrik
# - α3 > 0: Sağa çarpık
# - α3 < 0: Sola çarpık
# 
# Basıklık Yorumu (α4):
# - α4 = 3: Normal (mezokurtik)
# - α4 > 3: Sivri (leptokurtik)
# - α4 < 3: Basık (platikurtik)

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri
values <- c(12, 15, 18, 20, 22, 25, 28, 30, 32, 35, 38, 40, 42, 45, 50, 55, 60)

# Veri sayısı
n <- length(values)

# Ortalamayı hesapla
mean_value <- mean(values)

# Sapmaları hesapla: (x - μ)
deviations <- values - mean_value

# İkinci merkezi moment (varyans): m2 = Σ(x - μ)² / n
deviations_squared <- deviations^2
m2 <- mean(deviations_squared)

# Üçüncü merkezi moment: m3 = Σ(x - μ)³ / n
deviations_cubed <- deviations^3
m3 <- mean(deviations_cubed)

# Dördüncü merkezi moment: m4 = Σ(x - μ)⁴ / n
deviations_fourth <- deviations^4
m4 <- mean(deviations_fourth)

# Asimetri moment katsayısı: α3 = m3 / (m2)^(3/2)
alpha3 <- m3 / (m2^(3/2))

# Basıklık katsayısı: α4 = m4 / (m2)²
alpha4 <- m4 / (m2^2)

# Fazla basıklık (excess kurtosis): α4 - 3
excess_kurtosis <- alpha4 - 3

# Yorumlama fonksiyonları
interpret_skewness <- function(alpha3) {
  if (abs(alpha3) < 0.1) return("Simetrik")
  else if (alpha3 > 0) return("Sağa Çarpık (Pozitif)")
  else return("Sola Çarpık (Negatif)")
}

interpret_kurtosis <- function(alpha4) {
  if (abs(alpha4 - 3) < 0.2) return("Normal (Mezokurtik)")
  else if (alpha4 > 3) return("Sivri (Leptokurtik)")
  else return("Basık (Platikurtik)")
}

# Detaylı hesaplama tablosu
calculation_table <- data.frame(
  "x" = values,
  "x - μ" = round(deviations, 4),
  "(x - μ)²" = round(deviations_squared, 4),
  "(x - μ)³" = round(deviations_cubed, 4),
  "(x - μ)⁴" = round(deviations_fourth, 4),
  check.names = FALSE
)

# Toplam satırını ekle
calculation_table_with_total <- rbind(
  calculation_table,
  data.frame(
    "x" = "TOPLAM",
    "x - μ" = "",
    "(x - μ)²" = round(sum(deviations_squared), 4),
    "(x - μ)³" = round(sum(deviations_cubed), 4),
    "(x - μ)⁴" = round(sum(deviations_fourth), 4),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== MOMENTLER, ASİMETRİ VE BASIKLIK KATSAYILARI ===\n\n")
cat("Veri Sayısı: n =", n, "\n")
cat("Ortalama: μ =", mean_value, "\n\n")
cat("Merkezi Momentler:\n")
cat("1. m2 (2. merkezi moment - varyans) = Σ(x-μ)²/n =", m2, "\n")
cat("2. m3 (3. merkezi moment) = Σ(x-μ)³/n =", m3, "\n")
cat("3. m4 (4. merkezi moment) = Σ(x-μ)⁴/n =", m4, "\n\n")
cat("Asimetri Katsayısı:\n")
cat("  α3 = m3 / (m2)^(3/2)\n")
cat("  α3 =", m3, "/ (", m2, ")^(3/2) =", alpha3, "\n")
cat("  Yorum:", interpret_skewness(alpha3), "\n\n")
cat("Basıklık Katsayısı:\n")
cat("  α4 = m4 / (m2)²\n")
cat("  α4 =", m4, "/ (", m2, ")² =", alpha4, "\n")
cat("  Fazla Basıklık: α4 - 3 =", excess_kurtosis, "\n")
cat("  Yorum:", interpret_kurtosis(alpha4), "\n\n")

# Tabloyu View ile göster
View(calculation_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/10-moment-ve-basiklik"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-moment-ve-basiklik-1-table.png"), 
    width = 1100, height = 850)
grid.table(calculation_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("n (Veri Sayısı)",
                   "μ (Ortalama)",
                   "m2 (2. Merkezi Moment)",
                   "m3 (3. Merkezi Moment)",
                   "m4 (4. Merkezi Moment)",
                   "α3 (Asimetri Katsayısı)",
                   "α4 (Basıklık Katsayısı)",
                   "Fazla Basıklık (α4 - 3)"),
  "Değer" = c(n,
              round(mean_value, 4),
              round(m2, 4),
              round(m3, 4),
              round(m4, 4),
              round(alpha3, 4),
              round(alpha4, 4),
              round(excess_kurtosis, 4)),
  "Yorum" = c("", "", "Varyans", "", "",
              interpret_skewness(alpha3),
              interpret_kurtosis(alpha4),
              ""),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "1-moment-ve-basiklik-2-result.png"), 
    width = 950, height = 550)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-moment-ve-basiklik-1-table.png"), "\n")
cat("- ", file.path(output_dir, "1-moment-ve-basiklik-2-result.png"), "\n")
