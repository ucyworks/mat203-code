# Frekans Serisinde Aritmetik Ortalama Hesaplama
# Formül: X̄ = Σ(f·x) / Σf
# X̄: Aritmetik ortalama
# f: Frekans (sıklık)
# x: Değer (veri noktası)

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri: değerler (x) ve frekanslar (f)
values <- c(12, 13, 14, 15, 16)
frequencies <- c(2, 4, 7, 6, 1)

# f·x (frekans × değer) çarpımlarını hesapla
frequency_times_value <- frequencies * values

# Toplam frekans ve toplam (f·x) hesapla
total_frequency <- sum(frequencies)
total_fx <- sum(frequency_times_value)

# Aritmetik ortalama hesapla: X̄ = Σ(f·x) / Σf
arithmetic_mean <- total_fx / total_frequency

# Detaylı hesaplama tablosu oluştur
calculation_table <- data.frame(
  "Değer (x)" = values,
  "Frekans (f)" = frequencies,
  "f × x" = frequency_times_value,
  check.names = FALSE
)

# Toplam satırını ekle
calculation_table_with_total <- rbind(
  calculation_table,
  data.frame(
    "Değer (x)" = "TOPLAM",
    "Frekans (f)" = total_frequency,
    "f × x" = total_fx,
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== FREKANS SERİSİNDE ARİTMETİK ORTALAMA HESAPLAMA ===\n\n")
cat("Formül: X̄ = Σ(f·x) / Σf\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Her değeri frekansıyla çarp (f·x)\n")
cat("2. Tüm frekansları topla: Σf =", total_frequency, "\n")
cat("3. Tüm (f·x) değerlerini topla: Σ(f·x) =", total_fx, "\n")
cat("4. Aritmetik ortalama: X̄ =", total_fx, "/", total_frequency, "=", arithmetic_mean, "\n\n")

# Tabloyu View ile göster
View(calculation_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/3-ortalama"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-frekans-seri-ortalama-1-table.png"), 
    width = 800, height = 400)
grid.table(calculation_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("Σf (Toplam Frekans)", 
                   "Σ(f·x) (Toplam f×x)", 
                   "X̄ (Aritmetik Ortalama)"),
  "Değer" = c(total_frequency, 
              total_fx, 
              arithmetic_mean),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "1-frekans-seri-ortalama-2-result.png"), 
    width = 700, height = 300)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-frekans-seri-ortalama-1-table.png"), "\n")
cat("- ", file.path(output_dir, "1-frekans-seri-ortalama-2-result.png"), "\n")
