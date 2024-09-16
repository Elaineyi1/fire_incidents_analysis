install.packages('opendatatoronto')
install.packages('dylyr')
library(opendatatoronto)
library(dplyr)

# get package
package <- show_package("64a26694-01dc-4ec3-aa87-ad8509604f50")
package

# get all resources for this package
resources <- list_package_resources("64a26694-01dc-4ec3-aa87-ad8509604f50")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data_original <- filter(datastore_resources, row_number()==1) %>% get_resource()
head(data_original)
