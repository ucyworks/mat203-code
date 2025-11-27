# Gruplandırılmış Seride Mod (Tepe Değer) Hesaplama
# Formül: Mod = L_mod + [d₁ / (d₁ + d₂)] × i
# Mod: Mod değeri (en sık tekrar eden değerin tahmini)
# L_mod: Mod sınıfının alt sınırı
# d₁: Mod sınıfının frekansı - önceki sınıfın frekansı
# d₂: Mod sınıfının frekansı - sonraki sınıfın frekansı
# i: Sınıf genişliği

# gridExtra paketi ile tabloları PNG olarak kaydetmek için gerekli
library(gridExtra)

# Ham veri: sınıf aralıkları ve frekanslar
class_lower <- c(0, 10, 20, 30, 40)  # Alt sınırlar
class_upper <- c(10, 20, 30, 40, 50)  # Üst sınırlar
frequencies <- c(5, 12, 20, 9, 4)

# Sınıf genişliğini hesapla
class_width <- class_upper[1] - class_lower[1]

# Mod sınıfını bul (en yüksek frekansa sahip sınıf)
modal_class_index <- which.max(frequencies)
modal_class_lower <- class_lower[modal_class_index]
modal_class_upper <- class_upper[modal_class_index]

# d₁ ve d₂ değerlerini hesapla
d1 <- frequencies[modal_class_index] - frequencies[modal_class_index - 1]
d2 <- frequencies[modal_class_index] - frequencies[modal_class_index + 1]

# Mod değerini hesapla: Mod = L_mod + [d₁ / (d₁ + d₂)] × i
mode_value <- modal_class_lower + (d1 / (d1 + d2)) * class_width

# Sınıf aralıklarını metin olarak oluştur
class_intervals <- paste0(class_lower, " - ", class_upper)

# Mod sınıfını işaretle
modal_class_marker <- ifelse(1:length(frequencies) == modal_class_index, "MOD SINIFI", "")

# Frekans tablosu oluştur
frequency_table <- data.frame(
  "Sınıf Aralığı" = class_intervals,
  "Frekans (f)" = frequencies,
  "Not" = modal_class_marker,
  check.names = FALSE
)

# Toplam satırını ekle
frequency_table_with_total <- rbind(
  frequency_table,
  data.frame(
    "Sınıf Aralığı" = "TOPLAM",
    "Frekans (f)" = sum(frequencies),
    "Not" = "",
    check.names = FALSE
  )
)

# Konsola hesaplama detaylarını yazdır
cat("\n=== GRUPLANDIRIMIŞ SERİDE MOD HESAPLAMA ===\n\n")
cat("Formül: Mod = L_mod + [d₁ / (d₁ + d₂)] × i\n\n")
cat("Verilen Bilgiler:\n")
cat("- Sınıf genişliği: i =", class_width, "\n")
cat("- En yüksek frekans:", frequencies[modal_class_index], "(Sınıf:", class_intervals[modal_class_index], ")\n\n")
cat("Hesaplama Adımları:\n")
cat("1. Mod sınıfı:", class_intervals[modal_class_index], "(frekans =", frequencies[modal_class_index], ")\n")
cat("2. Mod sınıfının alt sınırı: L_mod =", modal_class_lower, "\n")
cat("3. Önceki sınıfın frekansı:", frequencies[modal_class_index - 1], "\n")
cat("4. Sonraki sınıfın frekansı:", frequencies[modal_class_index + 1], "\n")
cat("5. d₁ = f_mod - f_önceki =", frequencies[modal_class_index], "-", frequencies[modal_class_index - 1], "=", d1, "\n")
cat("6. d₂ = f_mod - f_sonraki =", frequencies[modal_class_index], "-", frequencies[modal_class_index + 1], "=", d2, "\n")
cat("7. d₁ + d₂ =", d1, "+", d2, "=", d1 + d2, "\n")
cat("8. d₁ / (d₁ + d₂) =", d1, "/", d1 + d2, "=", d1 / (d1 + d2), "\n")
cat("9. Mod =", modal_class_lower, "+ (", d1 / (d1 + d2), "×", class_width, ") =", mode_value, "\n\n")

# Tabloyu View ile göster
View(frequency_table_with_total)

# Tabloyu PNG olarak kaydet
output_dir <- "chapter3/4-mod"
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

png(file.path(output_dir, "1-gruplanmis-seri-mod-1-table.png"), 
    width = 800, height = 450)
grid.table(frequency_table_with_total, rows = NULL)
dev.off()

# Sonuç tablosu oluştur
result_table <- data.frame(
  "İstatistik" = c("Mod Sınıfı",
                   "L_mod (Mod Sınıfı Alt Sınırı)",
                   "i (Sınıf Genişliği)",
                   "f_mod (Mod Sınıfı Frekansı)",
                   "f_önceki (Önceki Sınıf Frekansı)",
                   "f_sonraki (Sonraki Sınıf Frekansı)",
                   "d₁ (f_mod - f_önceki)",
                   "d₂ (f_mod - f_sonraki)",
                   "d₁ / (d₁ + d₂)",
                   "Mod (Tepe Değer)"),
  "Değer" = c(class_intervals[modal_class_index],
              modal_class_lower,
              class_width,
              frequencies[modal_class_index],
              frequencies[modal_class_index - 1],
              frequencies[modal_class_index + 1],
              d1,
              d2,
              d1 / (d1 + d2),
              mode_value),
  check.names = FALSE
)

# Sonuç tablosunu View ile göster
View(result_table)

# Sonuç tablosunu PNG olarak kaydet
png(file.path(output_dir, "1-gruplanmis-seri-mod-2-result.png"), 
    width = 800, height = 600)
grid.table(result_table, rows = NULL)
dev.off()

cat("Tablolar kaydedildi:\n")
cat("- ", file.path(output_dir, "1-gruplanmis-seri-mod-1-table.png"), "\n")
cat("- ", file.path(output_dir, "1-gruplanmis-seri-mod-2-result.png"), "\n")
