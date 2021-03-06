% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fmri_ROI_phase2.R
\name{fmri_ROI_phase2}
\alias{fmri_ROI_phase2}
\title{tensor-on-tensor regression on region of interest(ROI) of the brain}
\usage{
fmri_ROI_phase2(
  fmridata,
  label_mask,
  label_dict,
  stimulus_idx,
  stimulus_dur,
  fmri.design_order = 2,
  fmri.stimulus_TR = 3,
  rrr_rank = 3,
  method = "t_test",
  parallel_computing = FALSE,
  ncor = max(detectCores() - 2, 1)
)
}
\arguments{
\item{fmridata}{a 4d array which contains the spatial and temporal record of fmri result.}

\item{label_mask}{a 3d nifti or 3d array of data that shows the labeled brain atlas.}

\item{label_dict}{a dataframe or array or matrix to specify the indices and corresponding
names of the ROI. The input of this parameter could take one of the list outputs of the \code{fmri_ROI_phase2} function as a following step.}

\item{stimulus_idx}{a vector of the start time points of the time period when the fMRI data receives stimulation.}

\item{stimulus_dur}{a vector of the time period when the fMRI data receives stimulation.}

\item{fmri.design_order}{a parameter to specify the order of the polynomial drift terms in \code{fmri.design} function.}

\item{fmri.stimulus_TR}{a parameter to specify the time between scans in seconds in \code{fmri.stimulus} function.}

\item{rrr_rank}{a parameter to specify the assumed rank of the coefficient array in \code{rrr} function.}

\item{method}{a string that represents method for calculating p-values from tensor-on-tensor regression coefficients. 
There are 2 options: 't_test' and 'corrected_t_test'. The default is 't_test'.
't_test' is to calculate the test statistics 't-value' across all voxels in the bounding box of ROI; 
'corrected_t_test' is to calculate the test statistics 't-value' by first across each voxel on a temporal basis,
and then across all voxels in the bounding box of ROI.}

\item{parallel_computing}{a logical parameter to determine whether to use parallel computing to speed up the function or not.
The default is FALSE.}

\item{ncor}{number of cores for parallel computing. The default is the number of cores of the computer minus 2.}
}
\value{
a 3d array storing ROI-based tensor regression p-values for the 4d fMRI data
}
\description{
This function takes a 4d fMRI data and detects locations where stimulus occurs
on each region of interest(ROI) of the brain using \code{MultiwayRegression}. This function could be used as
an intermediate step of a three-phase analytics protocol to detect motor areas. The functions to implement this 
three-phase protocol in a consecutive order is \code{fmri_ROI_phase2}, \code{fmri_ROI_phase3} and \code{fmri_post_hoc} respectively.
}
\details{
The function \code{fmri_ROI_phase2} is used to detect locations where stimulus occurs by calculating the p-values
of the ROI-based tensor-on-tensor regression. Two methods can be chosen to calculate the p-values from the regression coefficients.
}
\examples{
\donttest{
# sample 3D data of labeled brain atlas provided by the package
# this example will use parallel computing and take about ten minutes to finish
dim(mask_label)
# sample dataframe of ROI-based indices and names provided by the package
dim(mask_dict)
# sample 3D data of mask provided by the package
dim(mask)

# calculated p-values 
set.seed(1)
fmri_generate = fmri_simulate_func(dim_data = c(64, 64, 40), mask = mask)
fmridata = fmri_generate$fmri_data
stimulus_idx = fmri_generate$ons
stimulus_dur = fmri_generate$dur
# the function will may take a long time, see examples in demo function or vignettes       
}

}
\author{
SOCR team <\url{http://socr.umich.edu/people/}>
}
