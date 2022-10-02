---
title: "MadeUpResume"
author: Megan Bruce
date: "`r Sys.Date()`"
output:
  pagedown::html_resume:
    css: ['css/custom_resume.css', 'css/styles.css', 'resume']
    # set it to true for a self-contained HTML page but it'll take longer to render
    self_contained: true
---

```{r, include = FALSE}

library(knitr)
library(magrittr)
library(tidyverse)
library(glue)
```

```{r, include=FALSE}

knitr::opts_chunk$set(
  results='asis', 
  echo = FALSE
)

# Set this to true to have links turned into footnotes at the end of the document
PDF_EXPORT <- FALSE

# Holds all the links that were inserted for placement at the end
links <- c()

source('C:/Users/thebr/Documents/cv/parsing_functions.R')


# First let's get the data, filtering to only the items tagged as
# Resume items

position_data <- read_csv('C:/Users/thebr/Documents/cv/positions.csv') %>% 
  filter(in_resume) %>% 
  mutate(
    # Build some custom sections by collapsing others
    section = case_when(
      section %in% c('research_positions', 'industry_positions') ~ 'positions', 
      section %in% c('data_science_writings', 'by_me_press') ~ 'writings',
      TRUE ~ section
    )
  ) 


```

# Aside

## Contact {#contact}

-   <i class="fa fa-envelope"></i> [mlankfor\@asu.edu](mailto:mlankfor@asu.edu){.email}
-   <i class="fa fa-github"></i> github.com/MegsBruce
-   <i class="fa fa-phone"></i> (800) 876-5309

## Language Skills {#skills}

```{r}
skills <- tribble(
  ~skill,               ~level,
  "Nerd",                  5,
  "Klingon", 4.5,
  "R",                2
)

build_skill_bars <- function(skills, out_of = 5){
  bar_color <- "#969696"
  bar_background <- "#d9d9d9"
  skills %>% 
    mutate(width_percent = round(100*level/out_of)) %>% 
    glue_data(
      "<div class = 'skill-bar'",
      "style = \"background:linear-gradient(to right,",
      "{bar_color} {width_percent}%,",
      "{bar_background} {width_percent}% 100%)\" >",
      "{skill}",
      "</div>"
    )
}

build_skill_bars(skills)


```

## Open Source Contributions {#open-source}

All projects available at `github.com/nstrayer/<name>`

-   `shinysense`: R package to use sensor data in Shiny apps
-   `tuftesque`: Hugo theme (behind LiveFreeOrDichotomize.com)
-   `slid3r`: D3 add-on for fully svg slider inputs

## More info {#more-info}

I currently have three classes until graduation. I can't tell if I'm more stressed or more excited about it.

## Disclaimer {#disclaimer}

Made w/ [**pagedown**](https://github.com/rstudio/pagedown).

Source code: [github.com/nstrayer/cv](https://github.com/nstrayer/cv).

Last updated on `r Sys.Date()`.

# Main

## Megan Bruce {#title}

```{r}
intro_text <- "

I'm currently trying to get myself through ASU's PEDA program. This is my (mostly) made-up resume for CPP527's 6th Lab." 


cat(sanitize_links(intro_text))
```

## Education {data-icon="graduation-cap" data-concise="true"}

```{r}

position_data %>% print_section('education')

```
