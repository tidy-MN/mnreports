![Lifecycle:Maturing](https://img.shields.io/badge/Lifecycle-Maturing-007EC6)

# mnreports <img src="https://tidy-mn.github.io/mnreports/web/mnreports_logo.png" align="right" width="27%" style="margin-right:10px;">

:bookmark_tabs: State of Minnesota branded report templates for R Markdown

Add MN themes to your reports with branded headers, chart themes, and tables. Produce reports in a variety of formats including HTML, MS Word, and PDF. 

The package includes report templates for the following agencies:

> - [MDH](https://tidy-mn.github.io/mnreports/web/)   
> - [MPCA](https://tidy-mn.github.io/mnreports/web/mpca.html)   


## Install

Install `mnreports` from GitHub:

``` r
# 1. Install the 'remotes' package
install.packages("remotes")

# 2. Install 'mnreports' from GitHub
remotes::install_github("tidy-MN/mnreports")
```


## Use

After installing and restarting RStudio, create a new RMarkdown file.

**In RStudio:**

- Go to `New File` > `R Markdown...` > Choose `From Template` in the left menu 
- Choose `MDH report` or `MPCA report` (they're sorted by the package name on the right)

Here's a preview of the MDH report:

<img alt="Preview of MDH report template with MDH logo at top, a publication date in the top right, a large title of A Healthy Report, a subtitle of Environmental Health, a line for the report authors, followed by a table of contents that lists: 1 - Summary, 2 - R code, 3 - Chunk options." src="https://tidy-mn.github.io/mnreports/web/web_report_white.png" width="60%" />



## What is R Markdown?

If you're new to Markdown documents, here is a nice little intro video and gallery of examples https://rmarkdown.rstudio.com/lesson-1.html. In short, it takes your R script, comments, and charts and turns it all into a friendly readable document ready for public viewing. 

For example: 

<img src="https://d33wubrfki0l68.cloudfront.net/96ec0c54c6d64ea2ec3665db9b3b781962ff6339/5cee1/lesson-images/how-3-output.png" alt="From R script to report" width="74%" />

<br>

