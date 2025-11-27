# Tartılı Aritmetik Ortalama Hesaplama
# Formül: X̄w = Σ(w·x) / Σw
# X̄w: Tartılı aritmetik ortalama (weighted arithmetic mean)
# w: Ağırlık (weight) - bu örnekte kredi değeri
# x: Değer (value) - bu örnekte not

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri: notlar ve krediler (ağırlıklar)
grades <- c(70, 60, 50, 80)
credits <- c(3, 4, 3, 2)

# w·x (ağırlık × değer) çarpımlarını hesapla
weight_times_value <- credits * grades

# Toplam ağırlık ve toplam (w·x) hesapla
total_weight <- sum(credits)
total_wx <- sum(weight_times_value)

# Tartılı aritmetik ortalama hesapla: X̄w = Σ(w·x) / Σw
weighted_arithmetic_mean <- total_wx / total_weight

# Ders numaralarını oluştur
course_number <- paste0("Ders ", 1:length(grades))

# Detaylı hesaplama tablosu oluştur
calculation_table <- data.frame(
  "Ders" = course_number,
  "Not (x)" = grades,
  "Kredi (w)" = credits,
  "w × x" = weight_times_value,
  check.names = FALSE
)

# Toplam satırını ekle
calculation_table_with_total <- rbind(
  calculation_table,
  data.frame(
    "Ders" = "TOPLAM",
    "Not (x)" = "",
    "Kredi (w)" = total_weight,
    "w × x" = total_wx,
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== TARTILI ARİTMETİK ORTALAMA HESAPLAMA ===\n\n")
cat("Formül: X̄w = Σ(w·x) / Σw\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Her notu kredisiyle çarp (w·x)\n")
cat("2. Tüm kredileri (ağırlıkları) topla: Σw =", total_weight, "\n")
cat("3. Tüm (w·x) değerlerini topla: Σ(w·x) =", total_wx, "\n")
cat("4. Tartılı aritmetik ortalama: X̄w =", total_wx, "/", total_weight, "=", weighted_arithmetic_mean, "\n\n")

# Tabloyu View ile göster
View(calculation_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/3-ortalama"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "3-tartili-aritmetik-ortalama-1-table.png"), 
    width = 850, height = 400)
grid.table(calculation_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("Σw (Toplam Kredi)", 
                   "Σ(w·x) (Toplam w×x)", 
                   "X̄w (Tartılı Aritmetik Ortalama)"),
  "Değer" = c(total_weight, 
              total_wx, 
              weighted_arithmetic_mean),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "3-tartili-aritmetik-ortalama-2-result.png"), 
    width = 700, height = 300)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "3-tartili-aritmetik-ortalama-1-table.png"), "\n")
cat("- ", file.path(output_dir, "3-tartili-aritmetik-ortalama-2-result.png"), "\n")
