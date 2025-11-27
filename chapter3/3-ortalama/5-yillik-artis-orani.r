# Yıllık Artış Oranı ve Gelecek Değer Tahmini (Geometrik Ortalama Uygulaması)
# Formül: r = (Pₙ / P₀)^(1/n) - 1
# r: Yıllık artış oranı (annual growth rate)
# P₀: Başlangıç değeri
# Pₙ: n yıl sonraki değer
# n: Yıl sayısı

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Başlangıç verileri
initial_value <- 10000    # P₀ (2017 yılı nüfusu)
final_value <- 300000     # Pₙ (2025 yılı nüfusu)
years <- 8                # n (2017'den 2025'e kadar geçen yıl sayısı)

# Yıllık artış oranını hesapla: r = (Pₙ / P₀)^(1/n) - 1
ratio <- final_value / initial_value
growth_rate <- ratio^(1/years) - 1

# Yüzde olarak yıllık artış oranı
growth_rate_percent <- growth_rate * 100

# 2032 yılı tahmini (2025'ten 7 yıl sonrası)
years_ahead <- 7
predicted_2032 <- final_value * (1 + growth_rate)^years_ahead

# Yıl bazında hesaplama tablosu oluştur
year_sequence <- 2017:2025
population_sequence <- initial_value * (1 + growth_rate)^(0:(years))

year_table <- data.frame(
  "Yıl" = year_sequence,
  "Tahmini Nüfus" = format(round(population_sequence, 0), scientific = FALSE, big.mark = "."),
  "Artış Oranı (%)" = c("", rep(round(growth_rate_percent, 4), years)),
  check.names = FALSE
)

# 2032 tahminini ekle
year_table <- rbind(
  year_table,
  data.frame(
    "Yıl" = "...",
    "Tahmini Nüfus" = "...",
    "Artış Oranı (%)" = "...",
    check.names = FALSE
  ),
  data.frame(
    "Yıl" = 2032,
    "Tahmini Nüfus" = format(round(predicted_2032, 0), scientific = FALSE, big.mark = "."),
    "Artış Oranı (%)" = round(growth_rate_percent, 4),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== YILLIK ARTIŞ ORANI VE GELECEK DEĞER TAHMİNİ ===\n\n")
cat("Formül: r = (Pₙ / P₀)^(1/n) - 1\n\n")
cat("Verilen Bilgiler:\n")
cat("- Başlangıç yılı: 2017, Nüfus (P₀) =", format(initial_value, scientific = FALSE), "\n")
cat("- Bitiş yılı: 2025, Nüfus (Pₙ) =", format(final_value, scientific = FALSE), "\n")
cat("- Geçen süre: n =", years, "yıl\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Oran hesapla: Pₙ / P₀ =", format(final_value, scientific = FALSE), "/", format(initial_value, scientific = FALSE), "=", ratio, "\n")
cat("2. n'inci kök al: (", ratio, ")^(1/", years, ") =", ratio^(1/years), "\n")
cat("3. 1 çıkar: r =", ratio^(1/years), "- 1 =", growth_rate, "\n")
cat("4. Yüzde olarak: r =", growth_rate_percent, "%\n\n")
cat("2032 Yılı Tahmini (2025'ten 7 yıl sonrası):\n")
cat("Formül: P₂₀₃₂ = Pₙ × (1 + r)^t\n")
cat("P₂₀₃₂ =", format(final_value, scientific = FALSE), "× (1 +", growth_rate, ")^", years_ahead, "\n")
cat("P₂₀₃₂ =", format(predicted_2032, scientific = FALSE), "\n\n")

# Tabloyu View ile göster
View(year_table)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/3-ortalama"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "5-yillik-artis-orani-1-table.png"), 
    width = 800, height = 600)
grid.table(year_table, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("P₀ (Başlangıç Nüfusu - 2017)",
                   "Pₙ (Bitiş Nüfusu - 2025)",
                   "n (Yıl Sayısı)",
                   "Pₙ / P₀ (Oran)",
                   "r (Yıllık Artış Oranı)",
                   "r (Yüzde Olarak)",
                   "P₂₀₃₂ (2032 Tahmini)"),
  "Değer" = c(format(initial_value, scientific = FALSE),
              format(final_value, scientific = FALSE),
              years,
              ratio,
              growth_rate,
              paste0(round(growth_rate_percent, 4), "%"),
              format(round(predicted_2032, 0), scientific = FALSE)),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "5-yillik-artis-orani-2-result.png"), 
    width = 800, height = 500)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "5-yillik-artis-orani-1-table.png"), "\n")
cat("- ", file.path(output_dir, "5-yillik-artis-orani-2-result.png"), "\n")
