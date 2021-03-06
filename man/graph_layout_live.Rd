% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layout.R
\name{graph_layout_live}
\alias{graph_layout_live}
\alias{graph_live_layout}
\title{Live Layout}
\usage{
graph_live_layout(
  g,
  spring_length = 30L,
  sping_coeff = 8e-04,
  gravity = -1.2,
  theta = 0.8,
  drag_coeff = 0.02,
  time_step = 20L,
  is_3d = TRUE
)

graph_layout_live(
  g,
  spring_length = 30L,
  sping_coeff = 8e-04,
  gravity = -1.2,
  theta = 0.8,
  drag_coeff = 0.02,
  time_step = 20L,
  is_3d = TRUE
)
}
\arguments{
\item{g}{An object of class \code{graph} as 
returned by \code{\link{graph}} or a \code{graph_proxy}
as returned by a function of the same name.}

\item{spring_length}{Used to compute Hook's law, default of \code{30} is generally ideal.}

\item{sping_coeff}{Hook's law coefficient, where \code{1} is a solid spring.}

\item{gravity}{Coulomb's law coefficient. It's used to repel nodes thus should be negative 
if positive nodes attract each other.}

\item{theta}{Theta coefficient from Barnes Hut simulation, between \code{0} and \code{1}. 
The closer it's to \code{1} the more nodes the algorithm will have to go through.
Setting it to one makes Barnes Hut simulation no different from
brute-force forces calculation (each node is considered).}

\item{drag_coeff}{Drag force coefficient. Used to slow down system, thus should be less than \code{1}. 
The closer it is to 0 the less tight system will be.}

\item{time_step}{Default time step $dt$ for forces integration.}

\item{is_3d}{Whether to plot in 3 dimensions or 2 dimensions.}
}
\description{
Layout the graph live on the canvas using a physics simulator.
}
\details{
Calculates forces acting on each body and then deduces 
their position via Newton's law. There are three major forces in the system:

\itemize{
  \item{Spring force keeps connected nodes together via \href{https://en.wikipedia.org/wiki/Hooke's_law}{Hooke's law}.}
  \item{Each body repels each other via \href{https://en.wikipedia.org/wiki/Coulomb's_law}{Coulomb's law}.}
  \item{To guarantee we get to "stable" state the system has a drag force which slows entire simulation down.}
}

Body forces are calculated in \eqn{n*lg(n)} time with help of Barnes-Hut algorithm. 
\href{https://en.wikipedia.org/wiki/Euler_method}{Euler} method is then used to 
solve ordinary differential equation of Newton's law and get position of bodies.
}
\examples{
data <- make_data(20)

graph(data) \%>\% 
 graph_layout_live(time_step = 5L)

}
