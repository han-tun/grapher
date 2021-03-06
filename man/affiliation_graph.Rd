% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/affiliation.R
\name{affiliation_graph}
\alias{affiliation_graph}
\title{Affiliation Graph}
\usage{
affiliation_graph(
  links,
  member,
  community,
  weight = NULL,
  seed = 42,
  coefficient = NULL,
  scale = NULL
)
}
\arguments{
\item{links}{A data.frame containing \code{member}
and \code{community}.}

\item{member}{A person who is part of a \code{community}.}

\item{community}{A community, e.g.: a mailing list, a news group, etc.}

\item{seed}{A random seed for reproducibility.}

\item{coefficient, scale, weight}{You can explicitly specify the strength of a 
membership. That is how strongly a given \code{member} belongs to a 
\code{community}. The higher the strength the more likely it is for 
a member to have connections with other members of the community. 
By default the function does not require you to specify strength for the 
affiliation graph. If you do not specify the strength, it is assumed 
that strength is equally distributed among community members, and its 
value will be: \eqn{strength = (numberOfCommunityMembers, -coefficient) ^ 2 * scale}.
You specify the very strength of each relationship ising the \code{weight}
column.}
}
\value{
A data.frame of \code{member} links.
}
\description{
Create an affiliation graph from a user-community structure.
}
\details{
Note: setting weight to 0 will prohibit the model from building 
connections for this user within current community. It's same as just not 
including user into the community.
}
\examples{
data <- tibble::tribble(
 ~"user",     ~"group",
 "user 0",     "group 1",
 "user 1",     "group 1",
 "user 2",     "group 1",
 "user 1",     "group 2",
 "user 2",     "group 2",
 "user 3",     "group 2"
)

g <- affiliation_graph(data, user, group)
graph(g)

# with weight
data$strength <- runif(6, 1, 10)
affiliation_graph(data, user, group, weight = strength)

}
\seealso{
\href{official documentation}{https://github.com/anvaka/ngraph.agmgen}
}
