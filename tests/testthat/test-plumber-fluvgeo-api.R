test_that("check RHG", {
  expect_silent({
    # ------------- Start plumber API -------------------
    local_api <- call_that_plumber_start(
      api_folder = system.file("plumber", package = "fluvgeoapi"),
      api_file = "fluvgeo-api.R")

    # ------------- Start test session ------------------
    api_session <- call_that_session_start(local_api)
  })
  expect_s3_class(
    # ---------------- Make API call --------------------
    get_rhg <- call_that_api_get(
      api_session,
      endpoint = "RHG",
      query = list(region = "USA",
                   drainage_area = 1,
                   dimension_type = "area")
    ),
    "response"
  )

  # ---------- Run tests against response ---------------
  ## Test to confirm that the response was a success
  expect_equal(
    get_rhg$status_code,
    200
  )
  ## Test to confirm the output of the API is correct
  expect_equal(
    round(content(get_rhg)[[1]], 2),
    0.95
  )

  # ----- Close the session, and the plumber API --------
  expect_null(
    call_that_session_stop(api_session)
  )
})
