# Renk paleti için gerekli kütüphane
if (!requireNamespace("RColorBrewer", quietly = TRUE)) install.packages("RColorBrewer")
library(RColorBrewer)
# Gerekli kütüphaneyi yükle
library(readxl)

# Excel dosyasını okuyan fonksiyon
read_data <- function(filename) {
	path <- file.path("c:/Users/90537/Desktop/rumeli/istatistik/mat203-code/chapter2/data", filename)
	data <- read_excel(path)
	return(data)
}

# dataset-3.xlsx dosyasını oku
data <- read_data("dataset-3.xlsx")
View(data)

# 6. satırı sil
data <- data[-6, ]

# Sütun isimlerini değiştiren fonksiyon
rename_columns <- function(df, old_names, new_names) {
	names(df)[names(df) %in% old_names] <- new_names
	return(df)
}

# Sütun isimlerini güncelle
data <- rename_columns(data,
	old_names = c("BOY UZUNLUĞU (CM)", "SINIF DEĞERİ (x)", "BİRİM SAYISI (FREKANS)"),
	new_names = c("height", "x", "frequency"))
View(data)

# x sütunu etiket, frequency sütunu değer olacak şekilde pasta grafiği çizen fonksiyon
plot_pie_chart <- function(data, value_col = "frequency", label_col = "x", outfile = "chapter2/pie_chart.png") {
	# Negatif veya sıfır değerleri filtrele
	valid_idx <- which(data[[value_col]] > 0)
	valid_idx <- which(data[[value_col]] > 0)
	vals <- data[[value_col]][valid_idx]
	x_vals <- data[[label_col]][valid_idx]
	x_labels <- paste(x_vals, "cm", sep = " ")
	labs <- x_labels
		# Uyumlu renk paleti seç (pastel)
		n <- length(vals)
		pal <- brewer.pal(min(n, 8), "Pastel1")
		if (n > 8) pal <- colorRampPalette(brewer.pal(8, "Pastel1"))(n)
			png(outfile, width = 800, height = 600)
			# Pasta grafiği çiz
			pie(vals, labels = labs, main = "Frekanslara Göre Pasta Grafiği", col = pal)
			# Tanımlayıcı istatistikleri hesapla
			mean_x <- mean(as.numeric(x_vals), na.rm = TRUE)
			min_x <- min(as.numeric(x_vals), na.rm = TRUE)
			max_x <- max(as.numeric(x_vals), na.rm = TRUE)
			median_x <- median(as.numeric(x_vals), na.rm = TRUE)
			sd_x <- sd(as.numeric(x_vals), na.rm = TRUE)
			n_x <- sum(!is.na(as.numeric(x_vals)))
				# Tanımlayıcı istatistikleri tablo şeklinde göster
				stats_df <- data.frame(
					İstatistik = c("Ortalama", "Medyan", "Min", "Max", "Std Sapma", "Gözlem Sayısı"),
					Değer = c(
						sprintf("%.2f cm", mean_x),
						sprintf("%.2f cm", median_x),
						sprintf("%.2f cm", min_x),
						sprintf("%.2f cm", max_x),
						sprintf("%.2f cm", sd_x),
						n_x
					)
				)
				# Tabloyu grafiğin sol üstüne yaz
				legend("topleft", legend = paste(stats_df$İstatistik, stats_df$Değer, sep = ": "), bty = "n", cex = 1)
			# Adetleri (frekans) grafiğin üstünde göster
			legend("top", legend = paste(x_labels, vals, sep = " : "), fill = pal, horiz = FALSE, cex = 1)
			dev.off()
			cat("Pasta grafiği kaydedildi: ", outfile, "\n")
}

# Pasta grafiği oluştur
plot_pie_chart(data)