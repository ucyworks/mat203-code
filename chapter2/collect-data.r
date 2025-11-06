# Excel dosyasını okuyan fonksiyon
library(readxl)

# Veri okuma fonksiyonu

# Belirtilen Excel dosyasını okur ve veriyi döner
read_data <- function(filename) {
    # filename: Okunacak Excel dosyasının adı
	path <- file.path("c:/Users/90537/Desktop/rumeli/istatistik/mat203-code/chapter2/data", filename)
	data <- read_excel(path)

	return(data)
}

# Örnek kullanım
data <- read_data("dataset-1.xlsx")
print(head(data))
View(data)