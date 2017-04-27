## Taken directly from http://bl.ocks.org/timelyportfolio/raw/33db1fb9e64257ef7149754bdff0b2e0/
## All credit to https://twitter.com/timelyportfolio, https://github.com/timelyportfolio
## Note there's a manual step of clipping the image, at present

# Step 1 convert htmlwidget to character representation of HTML components
as.character.htmlwidget <- function(x, ...) {
  htmltools::HTML(
    htmltools:::as.character.shiny.tag.list(
      htmlwidgets:::as.tags.htmlwidget(
        x
      ),
      ...
    )
  )
}

add_deps <- function(dtbl, name, pkg = name) {
  tagList(
    dtbl,
    htmlwidgets::getDependency(name, pkg)
  )
}

library(leaflet) # needs leaflet > 1 timelyportfolio/leaflet@v1.0
library(htmlwidgets)
library(htmltools)
library(sparkline)

df <- read.csv(textConnection(
  "Name,Lat,Long
  Samurai Noodle,0,-20.25
  Kukai Ramen,47.6154,-122.327157
  Tsukushinbo,47.59987,-122.326726"
))

leaflet(df) %>% 
  addProviderTiles(providers$OpenMapSurfer.Roads) %>%
  addMarkers(
    ~Long, ~Lat,
    popup = lapply(seq_along(df),function(x)as.character(sparkline(runif(20))))
  ) %>%
  onRender(
    "
    function(el,x) {
    this.on('popupopen', function() {HTMLWidgets.staticRender();})
    }
    ") %>%
  add_deps("sparkline") %>%
  browsable()
