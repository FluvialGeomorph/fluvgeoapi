test_that("check RHG", {

  # ----------- Setup ---------------------
  expect_silent({
    # Start plumber API
    local_api <- callthat::call_that_plumber_start(
      api_folder = system.file("plumber", package = "fluvgeoapi"),
      api_file = "plumber.R")

    # Start test session
    api_session <- callthat::call_that_session_start(local_api)
  })

  # Check response object
  expect_s3_class(
    rhg_response <- callthat::call_that_api_get(
      api_session,
      endpoint = "RHG",
      headers = list(region = "USA",
                   drainage_area = 1,
                   dimension_type = "area")
    ),
    "response")

  ## Test to confirm that the response was a success
  expect_equal(rhg_response$status_code, 200)

  ## Test to confirm the output of the API is correct
  expect_equal(round(content(rhg_response)[[1]], 2), 0.95)

  # ---------- Teardown ------------
  expect_null(
    callthat::call_that_session_stop(api_session)
  )
})
