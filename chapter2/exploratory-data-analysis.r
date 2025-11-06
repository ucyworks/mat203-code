
# Gerekli kütüphaneyi yükle
library(readxl)

# Excel dosyasını okuyan fonksiyon
read_data <- function(filename) {
	path <- file.path("c:/Users/90537/Desktop/rumeli/istatistik/mat203-code/chapter2/data", filename)
	data <- read_excel(path)
	return(data)
}

# dataset-2.xlsx dosyasını oku
data <- read_data("dataset-2.xlsx")

View(data)


# Tanımlayıcı istatistikleri hesaplayan fonksiyon
# data: Veri
# columns: İstatistikleri hesaplanacak sütun isimleri vektörü
descriptive_statistics <- function(data, columns) {
	# Her sütun için istatistikleri hesapla
	stats <- lapply(columns, function(col) {
		x <- data[[col]] # İlgili sütunun verisini al
		# İstatistikleri bir liste olarak döndür
		list(
			column = col,                # Sütun adı
			mean = mean(x, na.rm = TRUE),# Ortalama [NA (Non-Available)/Eksik Veri değerler hariç]
			sd = sd(x, na.rm = TRUE),    # Standart sapma [NA (Non-Available)/Eksik Veri değerler hariç]
			min = min(x, na.rm = TRUE),  # Minimum değer
			max = max(x, na.rm = TRUE),  # Maksimum değer
			median = median(x, na.rm = TRUE), # Medyan
			n = sum(!is.na(x))           # Geçerli (NA olmayan) gözlem sayısı
		)
	})
	# Sonuçları döndür
	return(stats)
}

columns <- c("USA", "JAPAN")


# USA ve JAPAN sütunları için tanımlayıcı istatistikler
stats_list <- descriptive_statistics(data, columns)

# lapply: Listenin her elemanına bir fonksiyon uygular ve sonuçları bir liste olarak döndürür
# as.data.frame: Her istatistik listesini veri çerçevesine çevirir
# rbind: Veri çerçevelerini satır bazında birleştirir (row bind)
# do.call: Bir fonksiyonu, argümanları bir liste olarak vererek çağırır
# Burada: stats_list içindeki veri çerçevelerini satır bazında birleştiriyoruz
stats_df <- do.call(rbind, lapply(stats_list, as.data.frame))
View(stats_df)


# USA ve JAPAN sütunları için boxplotlar
plot_boxplots(data, columns)
plot_histograms <- function(data, columns, outdir = "chapter2/histograms", outliers = NULL) {
	if (!dir.exists(outdir)) dir.create(outdir, recursive = TRUE) # Klasör yoksa oluştur
	for (col in columns) {
		outfile <- file.path(outdir, paste0("hist_", col, ".png")) # Dosya adını oluştur
		png(outfile, width = 800, height = 600) # PNG cihazını aç
		hist(data[[col]], main = paste("Histogram of", col), xlab = col, col = "skyblue", border = "white") # Histogramı çiz
	
		dev.off() # PNG'yi kapat
	}
	cat("Histogramlar kaydedildi: ", outdir, " klasöründe.\n") # Bilgilendirme
}

# USA ve JAPAN sütunları için histogramlar ve aykırı değerler
plot_histograms(data, columns, outliers = outliers)


# Belirtilen sütunlar için IQR yöntemine göre aykırı değerleri tespit eder
# data: Veri çerçevesi
# columns: Aykırı değer tespiti yapılacak sütun isimleri vektörü
detect_outlier <- function(data, columns) {
	outliers <- list() # Sonuçları tutacak liste
	for (col in columns) {
		x <- data[[col]] # Sütunun verisini al
		Q1 <- quantile(x, 0.25, na.rm = TRUE) # 1. çeyrek
		Q3 <- quantile(x, 0.75, na.rm = TRUE) # 3. çeyrek
		IQR <- Q3 - Q1 # Çeyrekler arası açıklık
		lower <- Q1 - 1.5 * IQR # Alt sınır
		upper <- Q3 + 1.5 * IQR # Üst sınır
		outlier_idx <- which(x < lower | x > upper) # Aykırı değerlerin indeksleri
		outliers[[col]] <- list(
			outlier_values = x[outlier_idx], # Aykırı değerler
			outlier_indices = outlier_idx    # İlgili indeksler
		)
	}
	return(outliers) # Sonuçları döndür
}


# USA ve JAPAN sütunları için aykırı değer tespiti
# outliers: detect_outlier fonksiyonundan dönen aykırı değerler
outliers <- detect_outlier(data, columns)

# Belirtilen sütunlar için boxplotları çizer ve istatistikleri etiketler
# plot_boxplots fonksiyonu: Belirtilen sütunlar için boxplot (kutu grafiği) oluşturur ve istatistik etiketlerini ekler
plot_boxplots <- function(data, columns, outdir = "chapter2/boxplots") {
	if (!dir.exists(outdir)) dir.create(outdir, recursive = TRUE) # Klasör yoksa oluştur
	for (col in columns) {
		x <- data[[col]] # Sütunun verisini al
		stats <- boxplot.stats(x)$stats # Boxplot istatistiklerini al (min, Q1, medyan, Q3, max)
		outfile <- file.path(outdir, paste0("boxplot_", col, ".png")) # Dosya adını oluştur
		png(outfile, width = 800, height = 600) # PNG cihazını aç
		boxplot(x, main = paste("Boxplot of", col), xlab = col, col = "lightgreen", border = "darkgreen") # Boxplot'u çiz
		# Kutu grafiği üzerinde istatistik etiketlerini ekle
		labels <- c("Min", "Q1", "Medyan", "Q3", "Max")
		for (i in 1:5) {
			text(1.25, stats[i], labels[i], col = "red", pos = 4, cex = 1) # Etiketi ilgili noktaya yaz
		}
		dev.off() # PNG cihazını kapat
	}
	cat("Boxplotlar kaydedildi: ", outdir, " klasöründe.\n") # Bilgilendirme
}

# USA ve JAPAN sütunları için boxplotlar
plot_boxplots(data, columns)