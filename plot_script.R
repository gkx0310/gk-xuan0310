
library(tidyverse)
library(plotly)
library(htmlwidgets)

output_dir <- "media/plots/"
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

color_primary <- '#0072B2'
color_secondary <- '#D55E00'

df_agg_math <- df %>%
  group_by(age, sex) %>%
  summarise(mean_math = mean(Math, na.rm = TRUE), .groups = "drop")

p_barchart <- ggplot(df_agg_math,
  aes(
    x = factor(age),
    y = mean_math,
    fill = sex,
    text = paste("Age:", age,
                 "<br>Sex:", sex,
                 "<br>Mean Math Score:", round(mean_math, 2))
  )
) +
  geom_bar(stat = "identity", position = position_dodge(0.8), width = 0.7) +
  scale_fill_manual(values = c("F" = color_secondary, "M" = color_primary)) +
  labs(
    title = "Mean Math Scores by Age and Sex",
    x = "Age",
    y = "Mean Math Score"
  ) +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18),
    axis.text.x = element_text(size = 14),
    axis.text.y = element_text(size = 14),
    title = element_text(size = 20, face = "bold"),
    legend.title = element_text(size = 16),
    legend.text = element_text(size = 14)
  )

p_plotly <- ggplotly(p_barchart, tooltip = "text")

htmlwidgets::saveWidget(
  p_plotly,
  "media/plots/math_scores_age_sex_barchart.html",
  selfcontained = TRUE
)
