test_that("check slope_sinuosity", {
  expect_silent({
    # ------------- Start plumber API -------------------
    local_api <- call_that_plumber_start(
      api_folder = system.file("plumber", package = "fluvgeoapi"),
      api_file = "plumber.R")

    # ------------- Start test session ------------------
    api_session <- call_that_session_start(local_api)
  })

  # ---------- Get testing data ------------------------
    flowline_points_geojson <- geojsonsf::sf_geojson(
      fluvgeoapi::flowline_points)

  # ---------- Run tests against response ---------------
  expect_s3_class(
    ## Make API call
    slope_sinuosity <- call_that_api_get(
      api_session,
      endpoint = "slope_sinuosity",
      query = list(channel_features = flowline_points_geojson,
                   lead_n = 1,
                   lag_n = 1 ,
                   use_smoothing = TRUE,
                   loess_span = 0.05,
                   vert_units = "ft")
    ),
    "response"
  )

  ## Test to confirm that the response was a success
  expect_equal(
    slope_sinuosity$status_code,
    200
  )
  ## Test to confirm the output of the API is correct
  expect_snapshot(slope_sinuosity)

  # ----- Close the session, and the plumber API --------
  expect_null(
    call_that_session_stop(api_session)
  )
})
