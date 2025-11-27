# Harmonik Ortalama Hesaplama
# Formül: H = n / Σ(1/x)
# H: Harmonik ortalama
# n: Gözlem sayısı
# x: Değerler
# Harmonik ortalama genellikle hız, oran ve fiyat ortalamaları için kullanılır

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri (örneğin: hızlar km/saat cinsinden)
values <- c(60, 75, 80, 90)

# Her değerin tersini hesapla (1/x)
reciprocals <- 1 / values

# Terslerin toplamını hesapla
sum_reciprocals <- sum(reciprocals)

# Gözlem sayısı
n <- length(values)

# Harmonik ortalama hesapla: H = n / Σ(1/x)
harmonic_mean <- n / sum_reciprocals

# Detaylı hesaplama tablosu oluştur
calculation_table <- data.frame(
  "Sıra" = 1:length(values),
  "Değer (x)" = values,
  "1/x" = reciprocals,
  check.names = FALSE
)

# Toplam satırını ekle
calculation_table_with_total <- rbind(
  calculation_table,
  data.frame(
    "Sıra" = "TOPLAM",
    "Değer (x)" = "",
    "1/x" = sum_reciprocals,
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== HARMONİK ORTALAMA HESAPLAMA ===\n\n")
cat("Formül: H = n / Σ(1/x)\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Her değerin tersini al: 1/x\n")
cat("2. Gözlem sayısı: n =", n, "\n")
cat("3. Terslerin toplamı: Σ(1/x) =", sum_reciprocals, "\n")
cat("4. Harmonik ortalama: H =", n, "/", sum_reciprocals, "=", harmonic_mean, "\n\n")

# Tabloyu View ile göster
View(calculation_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/3-ortalama"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "6-harmonik-ortalama-1-table.png"), 
    width = 800, height = 400)
grid.table(calculation_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("n (Gözlem Sayısı)",
                   "Σ(1/x) (Terslerin Toplamı)",
                   "H (Harmonik Ortalama)"),
  "Değer" = c(n,
              sum_reciprocals,
              harmonic_mean),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "6-harmonik-ortalama-2-result.png"), 
    width = 700, height = 300)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "6-harmonik-ortalama-1-table.png"), "\n")
cat("- ", file.path(output_dir, "6-harmonik-ortalama-2-result.png"), "\n")
