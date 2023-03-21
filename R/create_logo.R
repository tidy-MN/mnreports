
if (FALSE) {
library(hexSticker)
library(sysfonts)
library(magick)

font_paths("../../Downloads/lato")

f <- font_files()

font_add("c_bold", "calibrib.ttf")

font_add("a_black", "ariblk.ttf")

font_add("l_bold", "Lato-Bold.ttf")
font_add("l_black", "Lato-Black.ttf")
font_add("lato", "Lato-Regular.ttf")

logo_white <- image_read("web/mn_icon_text_white.png")

sticker(package = "",#"MNREPORTS",
        filename = "web/mnreports_hex.svg",
        p_size = 5.5,#18,
        p_y = 0.72,
        p_family = "l_black",#"a_black",#"c_bold",
        #p_color = "#003865",
        subplot = logo_white,
        s_width = 1.95,#1.15,
        s_height = 1.95,
        s_x = 1,
        s_y = 1,#1.16,
        h_fill = "#003865", 
        h_color = "#A4BCC2",#"#D9D9D6",#"#A4BCC2",#"#78BE21", #"#97999B",
        h_size = 2.9,
        url = "github.com/tidy-mn/mnreports",
        u_y = .085,
        u_size = 1.2, 
        u_color = "#A4BCC2",
        spotlight = T,
        l_y = 1.4,
        l_x = 0.6,
        l_height = 2.5, 
        l_width = 3,
        l_alpha = 0.2,
        white_around_sticker = T
        ) %>% print

file.show("web/mnreports_hex.svg")

p <- image_read("web/mnreports_hex.svg")#, density = 300)

image_info(p)

p <- image_border(p, "white", "50x50")

#hex_clip <- image_read("web/hex_blank.svg")
#pp <- magick::image_composite(p, hex_clip, operator = 'copyopacity') #offset = "+0+01", 

p <- p %>%
  image_fill(color = "transparent", refcolor = "white", fuzz = 4, point = "+1+1") %>%
  image_fill(color = "transparent", refcolor = "white", fuzz = 4, point = "+518+1") %>%
  image_fill(color = "transparent", refcolor = "white", fuzz = 4, point = "+1+590") %>%
  image_fill(color = "transparent", refcolor = "white", fuzz = 4, point = "+518+590")

p <- image_trim(p)

p

image_write(p, path = "web/mnreports_hex.svg")

usethis::use_logo("web/mnreports_logo.png")


# Alternate logo
logo_blue <- image_read("web/mn_icon.jpg")

sticker(package = "MNREPORTS",
        filename = "web/mnreports_hex_white.png",
        p_size = 18,
        p_y = 0.7,
        p_family = "l_black",#"a_black",#"c_bold",
        p_color = "#003865",
        subplot = logo_blue,
        s_width = 1.2,
        s_height = 1.5,
        s_x = 1,
        s_y = 1.25,
        h_color = "#97999B",#"#D9D9D6",#"#003865",
        h_fill = "white",#"#78BE21",
        h_size = 2.5,
        url = "github.com/tidy-mn/mnreports",
        u_size = 3.75, 
        u_color = "#003865",
        spotlight = T,
        l_y = 1.4,
        l_x = 0.6,
        l_height = 2.5, 
        l_width = 3,
        l_alpha = 0.2,
        white_around_sticker = T) %>% print
}
