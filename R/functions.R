#' Convenience 'not-in' operator
#'
#' Complement of the built-in operator `%in%`. Returns the elements of `x` that are not in `y`.
#' @title `%nin%`
#' @param x vector of items
#' @param y vector of all values
#' @return logical vector of items in x not in y
#' @author Kieran Healy
#' @rdname nin
#' @examples
#' fruit <- c("apples", "oranges", "banana")
#' "apples" %nin% fruit
#' "pears" %nin% fruit
#' @export
"%nin%" <- function(x, y) {
  return( !(x %in% y) )
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param date PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname MMWRweekday
#' @author
#' @source http://
#' @references
MMWRweekday <- function (date)
{
  factor(strftime(as.Date(date), "%w"), levels = 0:6, labels = c("Sunday",
                                                                 "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                                                                 "Saturday"))
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param year PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname start_date
#' @author
#' @source http://
#' @references
start_date <- function (year)
{
  jan1 = as.Date(paste(year, "-01-01", sep = ""))
  wday = as.numeric(MMWRweekday(jan1))
  jan1 - (wday - 1) + 7 * (wday > 4)
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param MMWRyear PARAM_DESCRIPTION
#' @param MMWRweek PARAM_DESCRIPTION
#' @param MMWRday PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname MMWRweek2Date
#' @author Kieran Healy
#' @source http://
#' @references
MMWRweek2Date <- function (MMWRyear, MMWRweek, MMWRday = NULL)
{
  stopifnot(all(is.numeric(MMWRyear)))
  stopifnot(all(is.numeric(MMWRweek)))
  stopifnot(all(0 < MMWRweek & MMWRweek < 54))
  stopifnot(length(MMWRyear) == length(MMWRweek))
  if (is.null(MMWRday))
    MMWRday = rep(1, length(MMWRweek))
  stopifnot(all(0 < MMWRday & MMWRday < 8))
  jan1 = start_date(MMWRyear)
  return(jan1 + (MMWRweek - 1) * 7 + MMWRday - 1)
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param year PARAM_DESCRIPTION
#' @param week PARAM_DESCRIPTION
#' @param day PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[MMWRweek]{MMWRweek2Date}}
#' @rdname mmwr_week_to_date
#' @author Kieran Healy
#' @source http://
#' @export
#' @references
mmwr_week_to_date <- function (year, week, day = NULL)
{
  year <- as.numeric(year)
  week <- as.numeric(week)
  day <- if (!is.null(day))
    as.numeric(day)
  else rep(1, length(week))
  week <- ifelse(0 < week & week < 54, week, NA)
  as.Date(ifelse(is.na(week), NA, MMWRweek2Date(year,
                                                week, day)), origin = "1970-01-01")
}


#' @title fmt_nc
#' @description Format fmt_nc in df
#' @param x df
#' @return formatted string
#' @details use in fn documentation
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname fmt_nc
#' @author Kieran Healy
fmt_nc <- function(x){
  prettyNum(ncol(x), big.mark=",", scientific=FALSE)
}


#' @title fmt_nr
#' @description Format fmt_nr in df
#' @param x df
#' @return formatted string
#' @details use in fn documentation
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @author Kieran Healy
fmt_nr <- function(x){
  prettyNum(nrow(x), big.mark=",", scientific=FALSE)
}


