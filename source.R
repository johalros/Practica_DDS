
############################################################################################
#                             PACKAGES, LIBRARYS AND VARIABLES                             #
############################################################################################

setwd("C:/Users/Just someone_else/Documents/Practica_DDS")
library(easypackages)
lybrarys <- c("base64enc","bookdown", "cowplot", "curl", "devtools", "doParallel", "dplyr",
              "egg", "ggmap", "ggplot2", "grid", "gridExtra", "hrbrthemes", "htmltools",
              "iptools", "IPtoCountry", "knitr", "kableExtra", "leaflet", "magick",
              "magrittr", "maps", "maptools", "mapdata", "markdown", "mapview", "memoise",
              "microbenchmark", "packrat", "PKI", "plyr", "png", "prettydoc", "RColorBrewer",
              "Rcpp", "readr", "readxl", "reticulate", "rgl", "rmarkdown", "roxygen2", "rowr",
              "rworldmap", "sf", "shiny", "shinyWidgets", "sqldf", "threejs", "tidyr", "tm",
              "tidyverse", "VennDiagram", "tmap", "tmaptools")
libraries(lybrarys)

############################################################################################
#                              DOWNLOAD, IMPORT AND DATA INGESTION.                        #
#                    EXTRACT IPs, DETERMINE COUNTRY OF ORIGIN AND TABULATE                 # 
############################################################################################

url_Malware1 <- "https://iplists.firehol.org/files/hphosts_emd.ipset"
url_Malware2 <- "https://iplists.firehol.org/files/esentire_downs1_ru.ipset"
url_Malware3 <- "https://iplists.firehol.org/files/cybercrime.ipset"
url_Spam1 <- "https://iplists.firehol.org/files/nixspam.ipset"
url_Spam2 <- "https://iplists.firehol.org/files/urandomusto_mailer.ipset"
url_Spam3 <- "https://iplists.firehol.org/files/cleanmx_phishing.ipset"
url_Abuse1 <- "https://iplists.firehol.org/files/sblam.ipset"
url_Abuse2 <- "https://iplists.firehol.org/files/myip.ipset"
url_Abuse3 <- "https://iplists.firehol.org/files/gpf_comics.ipset"

#download.file(url = url_Malware1, destfile ="./Datasets/data_hpHosts.csv")
#download.file(url = url_Malware2, destfile ="./Datasets/data_esentire.csv")
#download.file(url = url_Malware3, destfile ="./Datasets/data_cybercrime.csv")
#download.file(url = url_Spam1, destfile ="./Datasets/data_nixspam.csv")
#download.file(url = url_Spam2, destfile ="./Datasets/data_urandomusto.csv")
#download.file(url = url_Spam3, destfile ="./Datasets/data_cleanmx.csv")
#download.file(url = url_Abuse1, destfile ="./Datasets/data_sblam.csv")
#download.file(url = url_Abuse2, destfile ="./Datasets/data_myip.csv")
#download.file(url = url_Abuse3, destfile ="./Datasets/data_gpfcomics.csv")


### Datasets column names ###
var_names1 <- c("IP", "Abrv", "Country", "Longitud", "Latitud")

### Graphics tables column names ###
var_names2 <- c("Country", "IPs")

### Malware 1 data ingestion ###
data_hpHost <- read_csv("./Datasets/data_hpHosts.csv")
dataset_hpHost <- data_hpHost[34:19500, ]

### Malware 1 IP Location ###
hpHost_location <- IP_location(dataset_hpHost$`#`)
hpHost_location=hpHost_location[ , c(1,2,7,6)]

### Malware 1 setup data frame, add IP Location and delete NAs ###
dataset_hpHost <- cbind.data.frame(dataset_hpHost, hpHost_location)
dataset_hpHost=dataset_hpHost[dataset_hpHost$lat != 0 & dataset_hpHost$long != 0, ]
dataset_hpHost[, 4]=as.numeric(as.character(dataset_hpHost[, 4] ))
dataset_hpHost[, 5]=as.numeric(as.character(dataset_hpHost[, 5] ))
names(dataset_hpHost)=var_names1
dataset_hpHost$Threat="Malware"
dataset_hpHost$Source="hpHost"


### Malware 2 data ingestion ###
data_esentire <- read_csv("./Datasets/data_esentire.csv")
dataset_esentire <- data_esentire[29:7259, ]

### Malware 2 IP Location ###
esentire_location <- IP_location(dataset_esentire$`#`)
esentire_location=esentire_location[ , c(1,2,7,6)]

### Malware 2 setup data frame, add IP Location and delete NAs ###
dataset_esentire <- cbind.data.frame(dataset_esentire, esentire_location)
dataset_esentire=dataset_esentire[dataset_esentire$lat != 0 & dataset_esentire$long != 0, ]
dataset_esentire[, 4]=as.numeric(as.character(dataset_esentire[, 4] ))
dataset_esentire[, 5]=as.numeric(as.character(dataset_esentire[, 5] ))
names(dataset_esentire)=var_names1
dataset_esentire$Threat="Malware"
dataset_esentire$Source="eSentire"


### Malware 3 data ingestion ###
data_cybercrime <- read_csv("./Datasets/data_cybercrime.csv")
dataset_cybercrime <- data_cybercrime[30:2265, ]

### Malware 3 IP Location ###
cybercrime_location <- IP_location(dataset_cybercrime$`#`)
cybercrime_location=cybercrime_location[ , c(1,2,7,6)]

### Malware 3 setup data frame, add IP Location and delete NAs ###
dataset_cybercrime <- cbind.data.frame(dataset_cybercrime, cybercrime_location)
dataset_cybercrime=dataset_cybercrime[dataset_cybercrime$lat != 0 & dataset_cybercrime$long != 0, ]
dataset_cybercrime[, 4]=as.numeric(as.character(dataset_cybercrime[, 4] ))
dataset_cybercrime[, 5]=as.numeric(as.character(dataset_cybercrime[, 5] ))
names(dataset_cybercrime)=var_names1
dataset_cybercrime$Threat="Malware"
dataset_cybercrime$Source="Cybercrime"


### Spam 1 data ingestion ###
data_nixspam <- read_csv("./Datasets/data_nixspam.csv")
dataset_nixspam <- data_nixspam[45:7500, ]

### Spam 1 IP Location ###
nixspam_location <- IP_location(dataset_nixspam$`#`)
nixspam_location=nixspam_location[ , c(1,2,7,6)]

### Spam 1 setup data frame, add IP Location and delete NAs ###
dataset_nixspam <- cbind.data.frame(dataset_nixspam, nixspam_location)
dataset_nixspam=dataset_nixspam[dataset_nixspam$lat != 0 & dataset_nixspam$long != 0, ]
dataset_nixspam[, 4]=as.numeric(as.character(dataset_nixspam[, 4] ))
dataset_nixspam[, 5]=as.numeric(as.character(dataset_nixspam[, 5] ))
names(dataset_nixspam)=var_names1
dataset_nixspam$Threat="Spam"
dataset_nixspam$Source="NiX Spam"


### Spam 2 data ingestion ###
data_urandomusto <- read_csv("./Datasets/data_urandomusto.csv")
dataset_urandomusto <- data_urandomusto[30:288, ]

### Spam 2 IP Location ###
urandomusto_location <- IP_location(dataset_urandomusto$`#`)
urandomusto_location=urandomusto_location[ , c(1,2,7,6)]

### Spam 2 setup data frame, add IP Location and delete NAs ###
dataset_urandomusto <- cbind.data.frame(dataset_urandomusto, urandomusto_location)
dataset_urandomusto=dataset_urandomusto[dataset_urandomusto$lat != 0 & dataset_urandomusto$long != 0, ]
dataset_urandomusto[, 4]=as.numeric(as.character(dataset_urandomusto[, 4] ))
dataset_urandomusto[, 5]=as.numeric(as.character(dataset_urandomusto[, 5] ))
names(dataset_urandomusto)=var_names1
dataset_urandomusto$Threat="Spam"
dataset_urandomusto$Source="urandom.us.to"


### Spam 3 data ingestion ###
data_cleanmx <- read_csv("./Datasets/data_cleanmx.csv")
dataset_cleanmx <- data_cleanmx[30:4548, ]

### Spam 3 IP Location ###
cleanmx_location <- IP_location(dataset_cleanmx$`#`)
cleanmx_location=cleanmx_location[ , c(1,2,7,6)]

### Spam 3 setup data frame, add IP Location and delete NAs ###
dataset_cleanmx <- cbind.data.frame(dataset_cleanmx, cleanmx_location)
dataset_cleanmx=dataset_cleanmx[dataset_cleanmx$lat != 0 & dataset_cleanmx$long != 0, ]
dataset_cleanmx[, 4]=as.numeric(as.character(dataset_cleanmx[, 4] ))
dataset_cleanmx[, 5]=as.numeric(as.character(dataset_cleanmx[, 5] ))
names(dataset_cleanmx)=var_names1
dataset_cleanmx$Threat="Spam"
dataset_cleanmx$Source="Clean-MX.de"


### Abuse 1 data ingestion ###
data_sblam <- read_csv("./Datasets/data_sblam.csv")
dataset_sblam <- data_sblam[30:9384, ]

### Abuse 1 IP Location ###
sblam_location <- IP_location(dataset_sblam$`#`)
sblam_location=sblam_location[ , c(1,2,7,6)]

### Abuse 1 setup data frame, add IP Location and delete NAs ###
dataset_sblam <- cbind.data.frame(dataset_sblam, sblam_location)
dataset_sblam=dataset_sblam[dataset_sblam$lat != 0 & dataset_sblam$lon != 0, ]
dataset_sblam[, 4]=as.numeric(as.character(dataset_sblam[, 4] ))
dataset_sblam[, 5]=as.numeric(as.character(dataset_sblam[, 5] ))
names(dataset_sblam)=var_names1
dataset_sblam$Threat="Abuse"
dataset_sblam$Source="sblam.com"


### Abuse 2 data ingestion ###
data_myip <- read_csv("./Datasets/data_myip.csv")
dataset_myip <- data_myip[33:900, ]

### Abuse 2 IP Location ###
myip_location <- IP_location(dataset_myip$`#`)
myip_location=myip_location[ , c(1,2,7,6)]

### Abuse 2 setup data frame, add IP Location and delete NAs ###
dataset_myip <- cbind.data.frame(dataset_myip, myip_location)
dataset_myip=dataset_myip[dataset_myip$lat != 0 & dataset_myip$long != 0, ]
dataset_myip[, 4]=as.numeric(as.character(dataset_myip[, 4] ))
dataset_myip[, 5]=as.numeric(as.character(dataset_myip[, 5] ))
names(dataset_myip)=var_names1
dataset_myip$Threat="Abuse"
dataset_myip$Source="MyIP.ms"


### Abuse 3 data ingestion ###
data_gpfcomics <- read_csv("./Datasets/data_gpfcomics.csv")
dataset_gpfcomics <- data_gpfcomics[40:14200, ]

### Abuse 3 IP Location ###
gpfcomics_location <- IP_location(dataset_gpfcomics$`#`)
gpfcomics_location=gpfcomics_location[ , c(1,2,7,6)]

### Abuse 3 setup data frame, add IP Location and delete NAs ###
dataset_gpfcomics <- cbind.data.frame(dataset_gpfcomics, gpfcomics_location)
dataset_gpfcomics=dataset_gpfcomics[dataset_gpfcomics$lat != 0 & dataset_gpfcomics$long != 0, ]
dataset_gpfcomics[, 4]=as.numeric(as.character(dataset_gpfcomics[, 4] ))
dataset_gpfcomics[, 5]=as.numeric(as.character(dataset_gpfcomics[, 5] ))
names(dataset_gpfcomics)=var_names1
dataset_gpfcomics$Threat="Abuse"
dataset_gpfcomics$Source="GPF Comics"



############################################################################################
#                                  TABLES, MAPS NAD GRAPHICS                               #
############################################################################################

### create data frame Countrys Malware 1, delete ceros, order data by frequence and length value calculation ###
countrys_hpHost <- data.frame(table(dataset_hpHost[, 3]))
countrys_hpHost=countrys_hpHost[countrys_hpHost$Freq != 0, ]
countrys_hpHost=countrys_hpHost[order(-countrys_hpHost$Freq), ]
count_countrysHp <- length(countrys_hpHost$Var1)


### create data frame Countrys Malware 2, delete ceros, order data by frequence and length value calculation ###
countrys_esentire <- data.frame(table(dataset_esentire[, 3]))
countrys_esentire=countrys_esentire[countrys_esentire$Freq != 0, ]
countrys_esentire=countrys_esentire[order(-countrys_esentire$Freq), ]
count_countrysEs <- length(countrys_esentire$Var1)


### create data frame  Countrys Malware 3, delete ceros, order data by frequence and length value calculation ###
countrys_cybercrime <- data.frame(table(dataset_cybercrime[, 3]))
countrys_cybercrime=countrys_cybercrime[countrys_cybercrime$Freq != 0, ]
countrys_cybercrime=countrys_cybercrime[order(-countrys_cybercrime$Freq), ]
count_countryCyb <- length(countrys_cybercrime$Var1)


### create data frame  Countrys Spam 1, delete ceros, order data by frequence and length value calculation ###
countrys_nixspam <- data.frame(table(dataset_nixspam[, 3]))
countrys_nixspam=countrys_nixspam[countrys_nixspam$Freq != 0, ]
countrys_nixspam=countrys_nixspam[order(-countrys_nixspam$Freq), ]
count_countrysNix <- length(countrys_nixspam$Var1)


### create data frame  Countrys Spam 2, delete ceros, order data by frequence and length value calculation ###
countrys_urandomusto <- data.frame(table(dataset_urandomusto[, 3]))
countrys_urandomusto=countrys_urandomusto[countrys_urandomusto$Freq != 0, ]
countrys_urandomusto=countrys_urandomusto[order(-countrys_urandomusto$Freq), ]
count_countrysUra <- length(countrys_urandomusto$Var1)


### create data frame  Countrys Spam 3 order by frequence and length value calculation ###
countrys_cleanmx <- data.frame(table(dataset_cleanmx[, 3]))
countrys_cleanmx=countrys_cleanmx[countrys_cleanmx$Freq != 0, ]
countrys_cleanmx=countrys_cleanmx[order(-countrys_cleanmx$Freq), ]
count_countryClem <- length(countrys_cleanmx$Var1)


### create data frame  Countrys Abuse 1, delete ceros, order data by frequence and length value calculation ###
countrys_sblam <- data.frame(table(dataset_sblam[, 3]))
countrys_sblam=countrys_sblam[countrys_sblam$Freq != 0, ]
countrys_sblam=countrys_sblam[order(-countrys_sblam$Freq), ]
count_countrysSbla <- length(countrys_sblam$Var1)


### create data frame  Countrys Abuse 2, delete ceros, order data by frequence and length value calculation###
countrys_myip <- data.frame(table(dataset_myip[, 3]))
countrys_myip=countrys_myip[countrys_myip$Freq != 0, ]
countrys_myip=countrys_myip[order(-countrys_myip$Freq), ]
count_countrysMy <- length(countrys_myip$Var1)


### create data frame  Countrys Abuse 3, delete ceros, order data by frequence and length value calculation ###
countrys_gpfcomics=data.frame(table(dataset_gpfcomics[, 3]))
countrys_gpfcomics=countrys_gpfcomics[countrys_gpfcomics$Freq != 0, ]
countrys_gpfcomics=countrys_gpfcomics[order(-countrys_gpfcomics$Freq), ]
count_countryGfp <- length(countrys_gpfcomics$Var1)


### calculate quantity of IPs in Malware category ###
IPs_hpHost=nrow(dataset_hpHost)
IPs_esentire=nrow(dataset_esentire)
IPs_cybercrime=nrow(dataset_cybercrime)


### calculate quantity of IPs in Spam category ###
IPs_nixspam=nrow(dataset_nixspam)
IPs_urandomusto=nrow(dataset_urandomusto)
IPs_cleanmx=nrow(dataset_cleanmx)


### calculate quantity of IPs in Abuse category###
IPs_sblam=nrow(dataset_sblam)
IPs_myip=nrow(dataset_myip)
IPs_gpfcomics=nrow(dataset_gpfcomics)


### create vector Countrys with all categories to further the practice description table ###
countrys_all <- c(count_countrysHp,
                  count_countrysEs,
                  count_countryCyb,
                  count_countrysNix,
                  count_countrysUra,
                  count_countryClem, 
                  count_countrysSbla,
                  count_countrysMy,
                  count_countryGfp)


### create vector  IPs all categories to further the practice description table ###
IPs_all <- c(IPs_hpHost,
             IPs_esentire,
             IPs_cybercrime,
             IPs_nixspam,
             IPs_urandomusto,
             IPs_cleanmx,
             IPs_sblam,
             IPs_myip,
             IPs_gpfcomics)


### URLs ipsets sources to further the practice description table ###
URLs <- c("http://iplists.firehol.org/?ipset=hphosts_emd", 
          "http://iplists.firehol.org/?ipset=esentire_downs1_ru",
          "http://iplists.firehol.org/?ipset=cybercrime",
          "http://iplists.firehol.org/?ipset=nixspam", 
          "http://iplists.firehol.org/?ipset=urandomusto_mailer", 
          "http://iplists.firehol.org/?ipset=cleanmx_phishing",
          "http://iplists.firehol.org/?ipset=sblam",
          "http://iplists.firehol.org/?ipset=myip", 
          "http://iplists.firehol.org/?ipset=gpf_comics")


### Create the practice description table ###
RBL <- c("hpHost", "eSentire", "Cybercrime", "NiX Spam", "Urandom", "Clean-MX",
         "Sblam.com", "MyIP.ms", "GPF Comics")
threat <- c(rep("Malware" , 3) , rep("Spam" , 3), rep("Abuse" , 3))
RBL_table <- cbind.data.frame(RBL, threat, IPs_all, countrys_all, URLs)
names(RBL_table)=c("RBL", "Threat", "IPs", "Country", "Source")



## data barplot Malware category ###
temp_malw1 <- c(as.character(dataset_hpHost$Country))
temp_malw2 <- c(as.character(dataset_esentire$Country))
temp_malw3 <- c(as.character(dataset_cybercrime$Country))
countrys_malware <- data.frame(table(c(temp_malw1, temp_malw2, temp_malw3)))
countrys_malware=countrys_malware[order(-countrys_malware$Freq), ]
countrys_malware=head(countrys_malware, n=5)
countrys_malware$Abrv=c("US", "UA", "RU", "DE", "GB")


## data barplot Spam category ###
temp_spam1 <- c(as.character(dataset_nixspam$Country))
temp_spam2 <- c(as.character(dataset_urandomusto$Country))
temp_spam3 <- c(as.character(dataset_cleanmx$Country))
countrys_spam <- data.frame(table(c(temp_spam1, temp_spam2, temp_spam3)))
countrys_spam=countrys_spam[order(-countrys_spam$Freq), ]
countrys_spam=head(countrys_spam, n=5)
countrys_spam$Abrv=c("US", "VN", "RU", "IN", "CN")


## data barplot Abuse category ###
temp_abuse1 <- c(as.character(dataset_sblam$Country))
temp_abuse2 <- c(as.character(dataset_myip$Country))
temp_abuse3 <- c(as.character(dataset_gpfcomics$Country))
countrys_abuse <- data.frame(table(c(temp_abuse1, temp_abuse2, temp_abuse3)))
countrys_abuse=countrys_abuse[order(-countrys_abuse$Freq), ]
countrys_abuse=head(countrys_abuse, n=5)
countrys_abuse$Abrv=c("US", "RU", "CN", "	BR", "IR")



## Icon geolocation ##
MalwareIcon <- makeIcon(
  iconUrl = "./Images/icon.jpg",
  iconWidth = 45, iconHeight = 35,
  iconAnchorX = 45, iconAnchorY = 35)





## Venn Diagramm structure 


## venn.diagram(
##   x = list(
##     dataset_sblam$IP,
##     dataset_myip$IP,
##     dataset_gpfcomics$IP
##   ),
##   category.names = c("Sblam.com", "MyIP.ms", "GPF Comics"),
##   lty = "blank",
##   fill = c("palegreen", "darkorchid1", "yellow3"),
##   filename = 'venn.png',
##   output = TRUE,
##   scaled = FALSE,
##   fontface = "bold",
##   fontfamily = "sans",
##   cat.fontface = "bold",
##   cat.fontfamily = "sans",
##   cat.default.pos = "outer",
##   cat.pos = c(-20, 10, 28),
##   cat.dist = c(0.055, 0.055, 0.025),
##   resolution = 900,
##   cat.col = c('#174B7A', '#5b3260', '#7a512f'),
##   cat.cex = 1,
##   cex = 0.8)











