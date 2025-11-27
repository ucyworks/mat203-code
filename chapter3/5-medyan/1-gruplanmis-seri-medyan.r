# Gruplandırılmış Seride Medyan (Ortanca) Hesaplama
# Formül: Medyan = L_med + [(N/2 - F_önceki) / f_med] × i
# Medyan: Ortanca değer (serinin ortasındaki değer)
# L_med: Medyan sınıfının alt sınırı
# N: Toplam frekans
# F_önceki: Medyan sınıfından önceki birikimli frekans
# f_med: Medyan sınıfının frekansı
# i: Sınıf genişliği

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri: sınıf aralıkları ve frekanslar
class_lower <- c(150, 160, 170, 180, 190)
class_upper <- c(160, 170, 180, 190, 200)
frequencies <- c(10, 20, 35, 25, 10)

# Sınıf genişliğini hesapla
class_width <- class_upper[1] - class_lower[1]

# Toplam frekansı hesapla
total_frequency <- sum(frequencies)

# Birikimli frekansı hesapla
cumulative_frequency <- cumsum(frequencies)

# Medyan sınıfını bul (N/2'yi geçen ilk sınıf)
half_n <- total_frequency / 2
median_class_index <- which(cumulative_frequency >= half_n)[1]
median_class_lower <- class_lower[median_class_index]
median_class_upper <- class_upper[median_class_index]

# Medyan sınıfından önceki birikimli frekans
cumulative_before_median <- ifelse(median_class_index == 1, 0, cumulative_frequency[median_class_index - 1])

# Medyan değerini hesapla
median_value <- median_class_lower + ((half_n - cumulative_before_median) / frequencies[median_class_index]) * class_width

# Sınıf aralıklarını metin olarak oluştur
class_intervals <- paste0(class_lower, " - ", class_upper)

# Medyan sınıfını işaretle
median_class_marker <- ifelse(1:length(frequencies) == median_class_index, "MEDYAN SINIFI", "")

# Detaylı frekans tablosu oluştur
frequency_table <- data.frame(
  "Sınıf Aralığı" = class_intervals,
  "Frekans (f)" = frequencies,
  "Birikimli Frekans (F)" = cumulative_frequency,
  "Not" = median_class_marker,
  check.names = FALSE
)

# Toplam satırını ekle
frequency_table_with_total <- rbind(
  frequency_table,
  data.frame(
    "Sınıf Aralığı" = "TOPLAM",
    "Frekans (f)" = total_frequency,
    "Birikimli Frekans (F)" = "",
    "Not" = paste0("N/2 = ", half_n),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== GRUPLANDIRIMIŞ SERİDE MEDYAN HESAPLAMA ===\n\n")
cat("Formül: Medyan = L_med + [(N/2 - F_önceki) / f_med] × i\n\n")
cat("Verilen Bilgiler:\n")
cat("- Toplam frekans: N =", total_frequency, "\n")
cat("- N/2 =", half_n, "\n")
cat("- Sınıf genişliği: i =", class_width, "\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Medyan sınıfı:", class_intervals[median_class_index], "(N/2 =", half_n, "değerini geçen ilk sınıf)\n")
cat("2. Medyan sınıfının alt sınırı: L_med =", median_class_lower, "\n")
cat("3. Medyan sınıfının frekansı: f_med =", frequencies[median_class_index], "\n")
cat("4. Medyan sınıfından önceki birikimli frekans: F_önceki =", cumulative_before_median, "\n")
cat("5. N/2 - F_önceki =", half_n, "-", cumulative_before_median, "=", half_n - cumulative_before_median, "\n")
cat("6. (N/2 - F_önceki) / f_med =", half_n - cumulative_before_median, "/", frequencies[median_class_index], "=", (half_n - cumulative_before_median) / frequencies[median_class_index], "\n")
cat("7. Medyan =", median_class_lower, "+ (", (half_n - cumulative_before_median) / frequencies[median_class_index], "×", class_width, ") =", median_value, "\n\n")

# Tabloyu View ile göster
View(frequency_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/5-medyan"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-gruplanmis-seri-medyan-1-table.png"), 
    width = 900, height = 450)
grid.table(frequency_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("N (Toplam Frekans)",
                   "N/2",
                   "Medyan Sınıfı",
                   "L_med (Medyan Sınıfı Alt Sınırı)",
                   "i (Sınıf Genişliği)",
                   "f_med (Medyan Sınıfı Frekansı)",
                   "F_önceki (Önceki Birikimli Frekans)",
                   "N/2 - F_önceki",
                   "(N/2 - F_önceki) / f_med",
                   "Medyan (Ortanca)"),
  "Değer" = c(total_frequency,
              half_n,
              class_intervals[median_class_index],
              median_class_lower,
              class_width,
              frequencies[median_class_index],
              cumulative_before_median,
              half_n - cumulative_before_median,
              (half_n - cumulative_before_median) / frequencies[median_class_index],
              median_value),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "1-gruplanmis-seri-medyan-2-result.png"), 
    width = 900, height = 650)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-gruplanmis-seri-medyan-1-table.png"), "\n")
cat("- ", file.path(output_dir, "1-gruplanmis-seri-medyan-2-result.png"), "\n")
