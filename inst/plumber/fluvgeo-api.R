library(plumber)
library(RegionalCurve)

#* @apiTitle Get RHG
#* @apiDescription Get Regional Hydraulic Geometry
#* @param region          The region that a dimension will be calculated for.
#* @param drainage_area   The upstream drainage area
#* @param dimension_type  Dimension type: "area", "depth", "width", "discharge"
#* @get /RHG
function(region, drainage_area, dimension_type) {
  RegionalCurve::RHG(region = region,
                     drainageArea = as.numeric(drainage_area),
                     dimensionType = dimension_type)
}
