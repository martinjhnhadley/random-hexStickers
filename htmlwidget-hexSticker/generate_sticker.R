# source("https://bioconductor.org/biocLite.R")
# biocLite("EBImage")

library(hexSticker)

imgPath <- "htmlwidget-icon.png"

sticker(imgPath, package="htmlwidgets", p_size=7, s_x=1, s_y=.76, s_width=.5,
        p_family = "wqy-microhei",
        filename="htmlwidgets-hexSticker.png")
