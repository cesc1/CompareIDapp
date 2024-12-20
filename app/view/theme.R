box::use(
  bslib[bs_add_rules, bs_theme],
  sass[sass_file],
)

# Load bslib basic theme and primary variable
#' @export
my_theme <- bs_theme(version = "5") |>
  bs_add_rules(sass_file("app/styles/main.scss"))
