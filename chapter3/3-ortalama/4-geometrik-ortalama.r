# Geometrik Ortalama Hesaplama
# Formül: G = ⁿ√(x₁ × x₂ × ... × xₙ)
# Alternatif formül: G = exp(Σln(x) / n)
# G: Geometrik ortalama
# n: Gözlem sayısı
# x: Değerler

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri
values <- c(2, 3, 5, 4, 6)

# Logaritmaları hesapla
log_values <- log(values)

# Logaritmaların ortalamasını hesapla
mean_log <- mean(log_values)

# Geometrik ortalama hesapla: G = exp(mean(log(x)))
geometric_mean <- exp(mean_log)

# Alternatif hesaplama: çarpımın n'inci kökü
n <- length(values)
product_values <- prod(values)
alternative_geometric_mean <- product_values^(1/n)

# Detaylı hesaplama tablosu oluştur
calculation_table <- data.frame(
  "Sıra" = 1:length(values),
  "Değer (x)" = values,
  "ln(x)" = log_values,
  check.names = FALSE
)

# Toplam satırını ekle
calculation_table_with_total <- rbind(
  calculation_table,
  data.frame(
    "Sıra" = "TOPLAM/ORTALAMA",
    "Değer (x)" = paste0("Çarpım = ", product_values),
    "ln(x)" = sum(log_values),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== GEOMETRİK ORTALAMA HESAPLAMA ===\n\n")
cat("Formül 1: G = ⁿ√(x₁ × x₂ × ... × xₙ)\n")
cat("Formül 2: G = exp(Σln(x) / n)\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Her değerin doğal logaritmasını al: ln(x)\n")
cat("2. Logaritmaların toplamı: Σln(x) =", sum(log_values), "\n")
cat("3. Gözlem sayısı: n =", n, "\n")
cat("4. Logaritmaların ortalaması: Σln(x)/n =", mean_log, "\n")
cat("5. Geometrik ortalama: G = exp(", mean_log, ") =", geometric_mean, "\n\n")
cat("Alternatif Hesaplama:\n")
cat("1. Tüm değerleri çarp: Π(x) =", product_values, "\n")
cat("2. Çarpımın", n, "'inci kökünü al: G =", alternative_geometric_mean, "\n\n")

# Tabloyu View ile göster
View(calculation_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/3-ortalama"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "4-geometrik-ortalama-1-table.png"), 
    width = 800, height = 450)
grid.table(calculation_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("n (Gözlem Sayısı)", 
                   "Π(x) (Değerlerin Çarpımı)",
                   "Σln(x) (Logaritmaların Toplamı)",
                   "Σln(x)/n (Logaritmaların Ortalaması)",
                   "G (Geometrik Ortalama)"),
  "Değer" = c(n, 
              product_values,
              sum(log_values),
              mean_log,
              geometric_mean),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "4-geometrik-ortalama-2-result.png"), 
    width = 800, height = 400)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "4-geometrik-ortalama-1-table.png"), "\n")
cat("- ", file.path(output_dir, "4-geometrik-ortalama-2-result.png"), "\n")
