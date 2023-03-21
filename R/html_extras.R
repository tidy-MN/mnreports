
# resolve the html extras for a document (dependencies and arbitrary html to inject into the document)
html_extras_for_document <- function(knit_meta, runtime, dependency_resolver, format_deps = NULL) {

  extras <- list()

  # merge the dependencies discovered with the dependencies of this format and dependencies discovered in knit_meta
  all_dependencies <- if (is.null(format_deps)) list() else format_deps
  all_dependencies <- append(all_dependencies, flatten_html_dependencies(knit_meta))

  bk_depends <- paste(all_dependencies, collapse="")

  # Drop dependencies that will be retrieved from web source
  remove <- c(# Base
              "header-attrs", "bootstrap", "pagedtable", "jquery",
              # Crosstalk
              "crosstalk",
              # HTMLwidget
              "htmlwidgets",  "htmlwidget",
              # leaflet
              "leaflet", "leafletfix", "proj4", "Proj4Leaflet", "leaflet-binding", "leaflet-providers", "leaflet-providers-plugin", "rstudio_leaflet",
              # Datatable
              "datatables", "dt", "dtwidget","dt-core", "datatables-css", #"default", "auto",
              # Plotly
              "plotly", "plotly-binding", "plotly-main", "typedarray", "plotly-htmlwidgets-css",
              # selectize
              "selectize",
              # noui-slider
              "noui-slider", "nouislider",
              # jqueryui
              "jqueryui"
              )

  all_dependencies <- htmltools::subtractDependencies(all_dependencies, remove, warnOnConflict = FALSE)

  if (grepl("plotly", bk_depends)) {
    plotly <- list(
      htmltools::htmlDependency(
        name = "plotly",
        version = "2.18.2",
        src = c(href = "https://rawcdn.githack.com/plotly/plotly.R/9ee548023bba6d68dd953f46485b2e611026766b/inst/htmlwidgets/lib/plotlyjs/"),
        script = c(list('data-external'="1", src = "plotly-latest.min.js")),
        head = '<link data-external="1" href="https://rawcdn.githack.com/plotly/plotly.R/9ee548023bba6d68dd953f46485b2e611026766b/inst/htmlwidgets/lib/plotlyjs/plotly-htmlwidgets.css" rel="stylesheet">'),
      htmltools::htmlDependency(
        name = "plotly-binding",
        version = "1",
        src = c(href = "https://rawcdn.githack.com/plotly/plotly.R/9ee548023bba6d68dd953f46485b2e611026766b/inst/htmlwidgets/"),
        script = c(list('data-external'="1", src = "plotly.js"))),
      htmltools::htmlDependency(
        name = "typedarray-min",
        version = "1",
        src = c(href = "https://rawcdn.githack.com/plotly/plotly.R/9ee548023bba6d68dd953f46485b2e611026766b/inst/htmlwidgets/lib/typedarray/"),
        script = c(list('data-external'="1", src = "typedarray.min.js"))
      ))

    all_dependencies <- append(all_dependencies, plotly)
  }

  if (grepl("leaflet", bk_depends)) {
    leaflet <- list(
      htmltools::htmlDependency(
        name = "leaflet",
        version = "1.3.1",
        src = c(href="https://rstudio.github.io/leaflet/libs/leaflet/"),
        script = c(list('data-external'="1", src = "leaflet.js")),
        head = '<link data-external="1" href="https://rstudio.github.io/leaflet/libs/leaflet/leaflet.css" rel="stylesheet">'),
      htmltools::htmlDependency(
        name = "leafletfix",
        version = "1.0.0",
        src = c(href="https://rstudio.github.io/leaflet/libs/leafletfix/"),
        head = '<link data-external="1" href="https://rstudio.github.io/leaflet/libs/leafletfix/leafletfix.css" rel="stylesheet">'),
      htmltools::htmlDependency(
        name = "proj4",
        version = "2.6.2",
        src = c(href = "https://rstudio.github.io/leaflet/libs/proj4/"),
        script = c(list('data-external'="1", src = "proj4.min.js"))),
      htmltools::htmlDependency(
        name = "Proj4Leaflet",
        version = "1.0.1",
        src = c(href = "https://rstudio.github.io/leaflet/libs/Proj4Leaflet/"),
        script = c(list('data-external'="1", src = "proj4leaflet.js"))),
      htmltools::htmlDependency(
        name = "rstudio_leaflet",
        version = "1.3.1",
        src = c(href="https://rstudio.github.io/leaflet/libs/leafletfix/"),
        head = '<link data-external="1" href="https://rstudio.github.io/leaflet/libs/leafletfix/leafletfix.css" rel="stylesheet">'),
      # Include the rstudio leaflet binding last
      htmltools::htmlDependency(
        name = "leaflet-binding",
        version = "1.1.1",
        src = c(href = "https://rstudio.github.io/leaflet/libs/leaflet-binding/"),
        script = c(list('data-external'="1", src = "leaflet.js"))),
      htmltools::htmlDependency(
        name = "leaflet-providers-plugin",
        version = "1.1.1",
        src = c(href = "https://rstudio.github.io/leaflet/libs/leaflet-providers-plugin/"),
        script = c(list('data-external'="1", src = "leaflet-providers-plugin.js"))),
      htmltools::htmlDependency(
        name = "leaflet-providers_1.9.0",
        version = "1.1.1",
        src = c(href = "https://rstudio.github.io/leaflet/libs/leaflet-providers/"),
        script = c(list('data-external'="1", src = "leaflet-providers_1.9.0.js")))
    )

    all_dependencies <- append(all_dependencies, leaflet)
  }

  if (grepl("crosstalk", bk_depends)) {
    crosstalk <- list(
      htmltools::htmlDependency(
        name = "crosstalk-css",
        version = "1.0.1",
        src = c(href="https://rstudio.github.io/crosstalk/site_libs/crosstalk-1.0.1/css/"),
        head = '<link data-external="1" href="https://rstudio.github.io/crosstalk/site_libs/crosstalk-1.0.1/css/crosstalk.css" rel="stylesheet">'),
      htmltools::htmlDependency(
        name = "crosstalk-min",
        version = "1.1.1",
        src = c(href = "https://rstudio.github.io/crosstalk/site_libs/crosstalk-1.0.1/js/"),
        script = c(list('data-external'="1", src = "crosstalk.min.js")))
    )

    all_dependencies <- append(all_dependencies, crosstalk)
  }

  if (grepl("dt-core", bk_depends)) {
    dt <- list(
      htmltools::htmlDependency(
        name = "datatables-crosstalk-css",
        version = "0.0.0",
        src = c(href="https://rstudio.github.io/crosstalk/site_libs/datatables-css-0.0.0/"),
        head = '<link data-external="1" href="https://rstudio.github.io/crosstalk/site_libs/datatables-css-0.0.0/datatables-crosstalk.css" rel="stylesheet">'),
      htmltools::htmlDependency(
        name = "datatables-min-css",
        version = "1.12.1",
        src = c(href="https://rstudio.github.io/DT/libs/dt-core/css/"),
        head = '<link data-external="1" href="https://rstudio.github.io/DT/libs/dt-core/css/jquery.dataTables.min.css" rel="stylesheet">'),
      htmltools::htmlDependency(
        name = "datatables-min-js",
        version = "1.11.3",
        src = c(href = "https://rstudio.github.io/DT/libs/dt-core/js/"),
        script = c(list('data-external'="1", src = "jquery.dataTables.min.js"))),
      htmltools::htmlDependency(
        name = "datatables-binding",
        version = "1.1.1",
        src = c(href = "https://rstudio.github.io/DT/libs/datatables-binding/"),
        script = c(list('data-external'="1", src = "datatables.js"))),
      htmltools::htmlDependency(
          name = "datatables-extra-css",
          version = "1.12.1",
          src = c(href="https://rstudio.github.io/DT/libs/dt-core/css/"),
          head = '<link data-external="1" href="https://rstudio.github.io/DT/libs/dt-core/css/jquery.dataTables.extra.css" rel="stylesheet">')
    )

    all_dependencies <- append(all_dependencies, dt)
  }

  if (grepl("selectize", bk_depends)) {
    selectize <- list(
      htmltools::htmlDependency(
        name = "selectize",
        version = "0.12.1",
        src = c(href="https://rstudio.github.io/DT/libs/selectize/"),
        script = c(list('data-external'="1", src = "selectize.min.js")),
        head = '<link data-external="1" href="https://rstudio.github.io/DT/libs/selectize/selectize.bootstrap3.css" rel="stylesheet">')
    )

      all_dependencies <- append(all_dependencies, selectize)
  }

  if (grepl("noui", bk_depends)) {
    noui <- list(
      htmltools::htmlDependency(
        name = "noui-slider",
        version = "0.12.1",
        src = c(href="https://rstudio.github.io/DT/libs/nouislider/"),
        script = c(list('data-external'="1", src = "jquery.nouislider.min.js")),
        head = '<link data-external="1" href="https://rstudio.github.io/DT/libs/nouislider/jquery.nouislider.min.css" rel="stylesheet">')
    )

      all_dependencies <- append(all_dependencies, noui)
  }

  if (grepl("jqueryui", bk_depends)) {
    jqueryui <- list(
      htmltools::htmlDependency(
        name = "jqueryui",
        version = "1.11.4",
        src = c(href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/"),
        script = c(list('data-external'="1", src = "jquery.jquery-ui.min.js")),
        head = '<link data-external="1" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css" rel="stylesheet">')
    )

      all_dependencies <- append(all_dependencies, jqueryui)
  }

  # Resolve conflicts / duplicates
  extras$dependencies <- dependency_resolver(all_dependencies)

  # return extras
  extras
}

# convert html extras to the pandoc args required to include them
pandoc_html_extras_args <- function(extras, self_contained, lib_dir,
                                    output_dir) {

  args <- c(extras$args)

  # dependencies
  dependencies <- extras$dependencies
  if (length(dependencies) > 0) {
    if (self_contained)
      file <- as_tmpfile(html_dependencies_as_string(dependencies, NULL, NULL))
    else
      file <- as_tmpfile(html_dependencies_as_string(dependencies, lib_dir,
                                                     output_dir))
    args <- c(args, pandoc_include_args(in_header = file))
  }

  # extras
  args <- c(args, pandoc_include_args(
                    in_header = as_tmpfile(extras$in_header),
                    before_body = as_tmpfile(extras$before_body),
                    after_body = as_tmpfile(extras$after_body)))

  args
}
