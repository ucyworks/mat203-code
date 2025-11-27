# Basit Seri İstatistikleri
# Basit seri: Ham verilerin herhangi bir gruplandırma yapılmadan listelendiği seridir
# Bu örnekte temel merkezi eğilim ölçüleri hesaplanmaktadır:
# - Toplam: Tüm değerlerin toplamı
# - Ortalama: Aritmetik ortalama (Σx / n)
# - Medyan: Sıralanmış verideki ortanca değer
# - Mod: En sık tekrar eden değer (tepe değer)

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri (basit seri)
values <- c(1, 3, 2, 2, 3, 1, 4, 5, 3, 6, 0, 5, 2, 3, 2, 4, 8, 0, 1, 2, 3, 3, 1, 0, 4)

# Veri sayısını hesapla
n <- length(values)

# Toplamı hesapla: Σx
total_sum <- sum(values)

# Ortalamayı hesapla: X̄ = Σx / n
mean_value <- mean(values)

# Medyanı hesapla (ortanca değer)
median_value <- median(values)

# Modu hesapla (en sık tekrar eden değer)
frequency_table <- table(values)
mode_value <- as.numeric(names(frequency_table)[which.max(frequency_table)])
mode_frequency <- max(frequency_table)

# Sıralanmış veriyi oluştur
sorted_values <- sort(values)

# Veri tablosu oluştur
data_table <- data.frame(
  "Sıra" = 1:n,
  "Değer" = values,
  "Sıralı Değer" = sorted_values,
  check.names = FALSE
)

# Toplam satırını ekle
data_table_with_summary <- rbind(
  data_table,
  data.frame(
    "Sıra" = "TOPLAM/ÖZETİN",
    "Değer" = paste0("Σx = ", total_sum),
    "Sıralı Değer" = paste0("n = ", n),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== BASİT SERİ İSTATİSTİKLERİ ===\n\n")
cat("Veri Sayısı: n =", n, "\n\n")
cat("Hesaplanan İstatistikler:\n")
cat("1. Toplam: Σx =", total_sum, "\n")
cat("2. Ortalama: X̄ = Σx / n =", total_sum, "/", n, "=", mean_value, "\n")
cat("3. Medyan (Ortanca): Sıralanmış verinin ortasındaki değer =", median_value, "\n")
cat("4. Mod (Tepe Değer): En sık tekrar eden değer =", mode_value, "(", mode_frequency, "kez tekrar ediyor)\n\n")

# Tabloyu View ile göster
View(data_table_with_summary)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/1-seri-ve-frekans"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-basit-seri-1-data.png"), 
    width = 800, height = 1000)
grid.table(data_table_with_summary, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("n (Veri Sayısı)",
                   "Σx (Toplam)",
                   "X̄ (Ortalama)",
                   "Medyan (Ortanca)",
                   "Mod (Tepe Değer)",
                   "Mod Frekansı"),
  "Değer" = c(n,
              total_sum,
              mean_value,
              median_value,
              mode_value,
              mode_frequency),
  "Açıklama" = c("Ham veri sayısı",
                 "Tüm değerlerin toplamı",
                 "Σx / n",
                 "Sıralanmış verinin ortasındaki değer",
                 "En sık tekrar eden değer",
                 "Mod değerinin tekrar sayısı"),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "1-basit-seri-2-result.png"), 
    width = 950, height = 450)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-basit-seri-1-data.png"), "\n")
cat("- ", file.path(output_dir, "1-basit-seri-2-result.png"), "\n")
