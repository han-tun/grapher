#' Camera FOV
#' 
#' Adjust the camera field of view.
#' 
#' @inheritParams graph_nodes
#' @param fov The field of view of the camera.
#' 
#' @examples 
#' library(shiny)
#' 
#' graph_data <- make_data(500)
#' 
#' colors <- list(
#'   "#000000", "#121420",
#'   "#1B2432", "#2C2B3C"
#' )
#' 
#' ui <- fluidPage(
#'   sliderInput("fov", "Field of view", 45, 120, 75, step = 5),
#'   graphOutput("graph")
#' )
#' 
#' server <- function(input, output) {
#' 
#'   output$graph <- renderGraph({
#'     graph_data %>% 
#'       graph() %>% 
#'       graph_live_layout(time_step = 5)
#'   })
#' r
#'   observeEvent(input$fov, {
#'     graph_proxy("graph") %>% 
#'       graph_camera_fov(input$fov)
#'   })
#' 
#' }
#' 
#' \dontrun{shinyApp(ui, server)}
#' 
#' @export
graph_camera_fov <- function(g, fov = 75L) UseMethod("graph_camera_fov")

#' @export 
#' @method graph_camera_fov graph
graph_camera_fov.graph <- function(g, fov = 75L) {

  g$x$cameraFov <- fov
  
  return(g)
}

#' @export 
#' @method graph_camera_fov graph_proxy
graph_camera_fov.graph_proxy <- function(g, fov = 75L) {

  msg <- list(id = g$id, fov = fov)

  g$session$sendCustomMessage("camera-fov", msg)
  
  return(g)
}

#' Camera Position
#' 
#' Position the camera, \emph{this only works on a stable graph}:
#' see \code{\link{graph_stable_layout}} and examples. The 
#' \code{graph_camera_lookat} let's define what position the camera
#' looks at.
#' 
#' @inheritParams graph_nodes
#' @param x,y,z Coordinates of camera position.
#' 
#' @examples 
#' library(shiny)
#' 
#' gdata <- make_data(100)
#' 
#' ui <- fluidPage(
#'   actionButton("mv", "Move camera"),
#'   graphOutput("g", height = "80vh")
#' )
#' 
#' server <- function(input, output) {
#'   output$g <- render_graph({
#'     graph(gdata) %>% 
#'       graph_stable_layout(ms = 5000)
#'   })
#' 
#'   observeEvent(input$mv, {
#'     graph_proxy("g") %>% 
#'       graph_camera_position(
#'         sample(1:500, 1),
#'         sample(1:500, 1),
#'         sample(1:500, 1)
#'       )
#'   })
#' }
#' 
#' \dontrun{shinyApp(ui, server)}
#' 
#' @name graph_camera_position
#' @export
graph_camera_position <- function(g, x = NULL, y = NULL, z = NULL) UseMethod("graph_camera_position")

#' @export
#' @method graph_camera_position graph
graph_camera_position.graph <- function(g, x = NULL, y = NULL, z = NULL){

  g$x$camera <- list(x = x, y = y, z = z)

  return(g)
}

#' @export
#' @method graph_camera_position graph_proxy
graph_camera_position.graph_proxy <- function(g, x = NULL, y = NULL, z = NULL){

  msg <- list(id = g$id, x = x, y = y, z = z)
  g$session$sendCustomMessage("position-camera", msg)

  return(g)
}

#' @rdname graph_camera_position
#' @export
graph_camera_lookat <- function(g, x = NULL, y = NULL, z = NULL) UseMethod("graph_camera_lookat")

#' @export
#' @method graph_camera_lookat graph
graph_camera_lookat.graph <- function(g, x = NULL, y = NULL, z = NULL){

  g$x$cameraLookat <- list(x = x, y = y, z = z)

  return(g)
}

#' @export
#' @method graph_camera_lookat graph_proxy
graph_camera_lookat.graph_proxy <- function(g, x = NULL, y = NULL, z = NULL){

  msg <- list(id = g$id, pos = list(x = x, y = y, z = z))
  g$session$sendCustomMessage("lookat-camera", msg)

  return(g)
}

#' Focus 
#' 
#' Focus on a specific node.
#' 
#' @inheritParams graph_nodes
#' @param id The id of the node to focus on.
#' @param dist The distance from the node the camera should move to.
#' 
#' @examples 
#' library(shiny)
#' 
#' gdata <- make_data(100)
#' 
#' ui <- fluidPage(
#'   sliderInput("node", "node to focus on", 1, max = 100, value = 5),
#'   graphOutput("g", height = "80vh")
#' )
#' 
#' server <- function(input, output) {
#'   output$g <- render_graph({
#'     graph(gdata) %>% 
#'     graph_stable_layout(ms = 1500)
#'   })
#' 
#'   observeEvent(input$node, {
#'     graph_proxy("g") %>% 
#'       graph_focus_node(input$node)
#'   })
#' }
#' 
#' \dontrun{shinyApp(ui, server)}
#' 
#' @export
graph_focus_node <- function(g, id, dist = .1) UseMethod("graph_focus_node")

#' @export 
#' @method graph_focus_node graph_proxy
graph_focus_node.graph_proxy <- function(g, id, dist = .1){

  msg <- list(id = g$id, node = id, dist = dist)
  g$session$sendCustomMessage("focus-node", msg)
  return(g)
}
