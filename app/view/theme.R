box::use(
  bslib[bs_theme, bs_add_rules],
  sass[sass_file],
)

# Load bslib basic theme and primary variable
#' @export
my_theme <- bslib::bs_theme(version = "5") |> 
  bslib::bs_add_rules(sass::sass_file("app/styles/main.scss"))
