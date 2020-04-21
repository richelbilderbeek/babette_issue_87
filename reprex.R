# Hi,
#
# I'm writing to follow-up about a really helpful tip dating feature you added a while ago (thank you!). I used the tipdates_filename argument pointing towards a tab-delimited file of sample names and dates (attached), but am running into errors when I start running the XML in BEAST.
#
# I define the model as follows:

library(babette)
library(testthat)

input_filename <- "cluster_10_dates.fa"
expect_true(file.exists(input_filename))

dates_filename <- "cluster_10_dates_tmp.csv"
expect_true(file.exists(dates_filename))

# Define input model
mean_sub_rate <- 5.7694E-08
sd_sub_rate <- (4.0324E-08 - 5.7694E-080) / 2.0
sd_sub_rate

input_model <- create_inference_model(
  site_model = create_gtr_site_model(),
  clock_model = create_clock_model_strict(clock_rate_distr = create_log_normal_distr(m = mean_sub_rate, s = sd_sub_rate)),
  tree_prior = create_ccp_tree_prior(),
  mcmc = create_mcmc(chain_length = 1e8, store_every = 1000),
  tipdates_filename = dates_filename
)


# Use the default BEAUti settings to create a BEAST2 input file
create_beast2_input_file_from_model(
  input_filename,
  output_filename,
  inference_model = input_model
)

# The error from BEAST:
#
# Loading package BEAST v2.6.2
#
# Error 170 parsing the xml input file
#
# Could not find object associated with idref TaxonSet.G_VII_pre2003_msa
#
# Error detected about here:
#   <beast>
#       <run id='mcmc' spec='MCMC'>
#           <state id='state'>
#               <tree id='Tree.t:cluster_10_dates' name='stateNode'>
#                   <taxonset>
#
# I believe this error has to do with specifying ids somewhere or not specifying the dates file with the appropriate syntax. Any suggestions would be great. Thank you in advance!

