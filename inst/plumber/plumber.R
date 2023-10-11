library(plumber)
library(RegionalCurve)
library(fluvgeo)

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


#* @apiTitle Post slope_sinuosity
#* @apiDescription Calculate Slope and Sinuosity
#* @param channel_features geojson; a `fluvgeo` data structure of
#*                         channel features (i.e., cross section, flowline
#*                         points, etc.) Must have the following fields:
#*                         `ReachName`, `POINT_X`, `POINT_Y`, `POINT_M`, `Z`
#* @param lead_n           numeric; The number of features to lead (upstream)
#*                         to calculate the slope and sinuosity. Must be an
#*                         integer.
#* @param lag_n            numeric; The number of features to lag (downstream)
#*                         to calculate the slope and sinuosity. Must be an
#*                         integer.
#* @param use_smoothing    boolean; determines if smoothed elevation values
#*                         are used to calculate gradient. values are:
#*                         TRUE, FALSE (default)
#* @param loess_span       numeric; the loess regression span parameter,
#*                         defaults to 0.05
#* @param vert_units       character; The vertical units. One of: "m" (meter),
#*                         "ft" (foot), "us-ft" (us survey foot)
#* @post /slope_sinuosity
function(channel_features,
         lead_n, lag_n, use_smoothing, loess_span, vert_units) {
  fluvgeo::slope_sinuosity(channel_features,
                           lead_n, lag_n,
                           use_smoothing, loess_span, vert_units)
}
