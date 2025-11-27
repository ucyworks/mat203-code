# Basit Seride Kartil, Desil ve Santil Hesaplama
# Kartil (Quartile): Veriyi 4 eşit parçaya bölen değerler (Q1, Q2, Q3)
# Desil (Decile): Veriyi 10 eşit parçaya bölen değerler (D1, D2, ..., D9)
# Santil/Persentil (Percentile): Veriyi 100 eşit parçaya bölen değerler (C1, C2, ..., C99)
# 
# Q1 = %25'lik dilim (1. Kartil)
# Q2 = %50'lik dilim (Medyan)
# Q3 = %75'lik dilim (3. Kartil)
# D8 = %80'lik dilim (8. Desil)
# C38 = %38'lik dilim (38. Santil)

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri (sıralanmış basit seri)
values <- c(5, 8, 9, 12, 18, 22, 23, 28, 32, 45, 54, 67, 71, 75, 84)

# Veri sayısı
n <- length(values)

# Kartil, Desil ve Santil hesaplama (type=7 R'nin standart interpolasyon yöntemi)
# Q1: 1. Kartil (%25'lik dilim)
q1_value <- quantile(values, 0.25, type = 7)

# D8: 8. Desil (%80'lik dilim)
d8_value <- quantile(values, 0.80, type = 7)

# C38: 38. Santil (%38'lik dilim)
c38_value <- quantile(values, 0.38, type = 7)

# Veri tablosu oluştur
data_table <- data.frame(
  "Sıra" = 1:n,
  "Değer" = values,
  check.names = FALSE
)

# Toplam satırını ekle
data_table_with_summary <- rbind(
  data_table,
  data.frame(
    "Sıra" = "TOPLAM",
    "Değer" = paste0("n = ", n),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== BASİT SERİDE KARTİL, DESİL VE SANTİL HESAPLAMA ===\n\n")
cat("Veri Sayısı: n =", n, "\n\n")
cat("Hesaplama Yöntemi: R quantile fonksiyonu (type = 7)\n\n")
cat("Kartiller (Quartiles - Veriyi 4'e böler):\n")
cat("  Q1 (1. Kartil) = %25'lik dilim =", q1_value, "\n")
cat("  → Verinin %25'i", q1_value, "değerinden küçük veya eşittir\n\n")
cat("Desiller (Deciles - Veriyi 10'a böler):\n")
cat("  D8 (8. Desil) = %80'lik dilim =", d8_value, "\n")
cat("  → Verinin %80'i", d8_value, "değerinden küçük veya eşittir\n\n")
cat("Santiller/Persentiller (Percentiles - Veriyi 100'e böler):\n")
cat("  C38 (38. Santil) = %38'lik dilim =", c38_value, "\n")
cat("  → Verinin %38'i", c38_value, "değerinden küçük veya eşittir\n\n")

# Tabloyu View ile göster
View(data_table_with_summary)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/6-kartil-desil-santil"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-basit-seri-kartil-desil-santil-1-table.png"), 
    width = 700, height = 700)
grid.table(data_table_with_summary, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("n (Veri Sayısı)",
                   "Q1 (1. Kartil - %25)",
                   "D8 (8. Desil - %80)",
                   "C38 (38. Santil - %38)"),
  "Değer" = c(n,
              as.numeric(q1_value),
              as.numeric(d8_value),
              as.numeric(c38_value)),
  "Açıklama" = c("Toplam gözlem sayısı",
                 "Verinin %25'i bu değerden küçük/eşit",
                 "Verinin %80'i bu değerden küçük/eşit",
                 "Verinin %38'i bu değerden küçük/eşit"),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "1-basit-seri-kartil-desil-santil-2-result.png"), 
    width = 950, height = 350)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-basit-seri-kartil-desil-santil-1-table.png"), "\n")
cat("- ", file.path(output_dir, "1-basit-seri-kartil-desil-santil-2-result.png"), "\n")
