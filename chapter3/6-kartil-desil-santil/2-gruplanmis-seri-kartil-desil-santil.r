# Gruplandırılmış Seride Kartil, Desil ve Santil Hesaplama
# Genel Formül: Qp = L + [(p×N - F_önceki) / f] × i
# Qp: p oranındaki kartil/desil/santil değeri
# L: Hedef sınıfın alt sınırı
# p: Oran (Q1=0.25, D8=0.80, C65=0.65 gibi)
# N: Toplam frekans
# F_önceki: Hedef sınıftan önceki birikimli frekans
# f: Hedef sınıfın frekansı
# i: Sınıf genişliği

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri: sınıf aralıkları ve frekanslar
class_lower <- c(220, 240, 260, 280, 300)
class_upper <- c(240, 260, 280, 300, 320)
frequencies <- c(6, 10, 14, 8, 2)

# Sınıf genişliğini hesapla
class_width <- class_upper[1] - class_lower[1]

# Toplam frekansı hesapla
total_frequency <- sum(frequencies)

# Birikimli frekansı hesapla
cumulative_frequency <- cumsum(frequencies)

# Sınıf aralıklarını metin olarak oluştur
class_intervals <- paste0(class_lower, " - ", class_upper)

# Örnek: C65 (65. Santil) hesaplama
percentile_ratio <- 0.65  # p değeri
target_position <- percentile_ratio * total_frequency  # p × N

# Hedef sınıfı bul (p×N'i geçen ilk sınıf)
target_class_index <- which(cumulative_frequency >= target_position)[1]
target_class_lower <- class_lower[target_class_index]

# Hedef sınıftan önceki birikimli frekans
cumulative_before_target <- ifelse(target_class_index == 1, 0, cumulative_frequency[target_class_index - 1])

# C65 değerini hesapla
c65_value <- target_class_lower + ((target_position - cumulative_before_target) / frequencies[target_class_index]) * class_width

# Hedef sınıfı işaretle
target_class_marker <- ifelse(1:length(frequencies) == target_class_index, "C65 SINIFI", "")

# Detaylı frekans tablosu oluştur
frequency_table <- data.frame(
  "Sınıf Aralığı" = class_intervals,
  "Frekans (f)" = frequencies,
  "Birikimli Frekans (F)" = cumulative_frequency,
  "Not" = target_class_marker,
  check.names = FALSE
)

# Toplam satırını ekle
frequency_table_with_total <- rbind(
  frequency_table,
  data.frame(
    "Sınıf Aralığı" = "TOPLAM",
    "Frekans (f)" = total_frequency,
    "Birikimli Frekans (F)" = "",
    "Not" = paste0("p×N = ", percentile_ratio, "×", total_frequency, " = ", target_position),
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== GRUPLANDIRIMIŞ SERİDE KARTİL/DESİL/SANTİL HESAPLAMA ===\n\n")
cat("Formül: Qp = L + [(p×N - F_önceki) / f] × i\n\n")
cat("Örnek: C65 (65. Santil - %65'lik dilim) Hesaplama\n\n")
cat("Verilen Bilgiler:\n")
cat("- Toplam frekans: N =", total_frequency, "\n")
cat("- Oran: p =", percentile_ratio, "(C65 için %65)\n")
cat("- p×N =", percentile_ratio, "×", total_frequency, "=", target_position, "\n")
cat("- Sınıf genişliği: i =", class_width, "\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Hedef sınıf:", class_intervals[target_class_index], "(p×N =", target_position, "değerini geçen ilk sınıf)\n")
cat("2. Hedef sınıfın alt sınırı: L =", target_class_lower, "\n")
cat("3. Hedef sınıfın frekansı: f =", frequencies[target_class_index], "\n")
cat("4. Hedef sınıftan önceki birikimli frekans: F_önceki =", cumulative_before_target, "\n")
cat("5. p×N - F_önceki =", target_position, "-", cumulative_before_target, "=", target_position - cumulative_before_target, "\n")
cat("6. (p×N - F_önceki) / f =", target_position - cumulative_before_target, "/", frequencies[target_class_index], "=", (target_position - cumulative_before_target) / frequencies[target_class_index], "\n")
cat("7. C65 =", target_class_lower, "+ (", (target_position - cumulative_before_target) / frequencies[target_class_index], "×", class_width, ") =", c65_value, "\n\n")
cat("Yorum: Verinin %65'i", c65_value, "değerinden küçük veya eşittir.\n\n")

# Tabloyu View ile göster
View(frequency_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/6-kartil-desil-santil"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "2-gruplanmis-seri-kartil-desil-santil-1-table.png"), 
    width = 950, height = 450)
grid.table(frequency_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("N (Toplam Frekans)",
                   "p (Oran - C65 için)",
                   "p×N (Hedef Pozisyon)",
                   "Hedef Sınıf",
                   "L (Hedef Sınıf Alt Sınırı)",
                   "i (Sınıf Genişliği)",
                   "f (Hedef Sınıf Frekansı)",
                   "F_önceki (Önceki Birikimli Frekans)",
                   "p×N - F_önceki",
                   "(p×N - F_önceki) / f",
                   "C65 (65. Santil)"),
  "Değer" = c(total_frequency,
              percentile_ratio,
              target_position,
              class_intervals[target_class_index],
              target_class_lower,
              class_width,
              frequencies[target_class_index],
              cumulative_before_target,
              target_position - cumulative_before_target,
              (target_position - cumulative_before_target) / frequencies[target_class_index],
              c65_value),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "2-gruplanmis-seri-kartil-desil-santil-2-result.png"), 
    width = 950, height = 700)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "2-gruplanmis-seri-kartil-desil-santil-1-table.png"), "\n")
cat("- ", file.path(output_dir, "2-gruplanmis-seri-kartil-desil-santil-2-result.png"), "\n")
