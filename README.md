# Specific Surface Chan-Vese (SSCV) Model for Image-Based Rock Typing
## Overview
Image-based rock typing (IBRT) is an effective way to understand the pore scale heterogeneity of the reservoir samples. IBRT is aimed to segment a rock sample’s image into different regions where each region presents a homogeneous porous medium, also known as rock type. Currently, the phase-field rock typing method has attracted more attention due to its impressive performance in classifying the heterogeneous rock images with highly irregular pore structures. A modified specific surface Chan-Vese (SSCV) model, which can be solved by a fast classifier called iterative convolution-thresholding method (ICTM), is proposed to realize the IBRT. In SSCV model, the specific surface of a pixel is calculated within a given size neighborhood to distinguish different rock types, and the iterative convolution-thresholding method is applied as the classifier. Compared to the LHFCV method, an existing phase-field rock typing method, the proposed SSCV is capable to process the images with more than two rock types and can be solved by ICTM which has higher computational efficiency. The proposed SSCV method has presented remarkable performance in the segmentation of various images of both synthetic and natural rock samples. Here give the codes for SSCV model.
## Prerequisites
* Matlab versions R2018b and later.
## How to use
Simply run `SSCV` in Matlab.
## Examples
* Example 1
<img src = "https://github.com/cyliu111/SSCV/blob/main/image/d1.jpg" width = "225"> <img src = "https://github.com/cyliu111/SSCV/blob/main/image/d1_contour.jpg" width = "225"> <img src = "https://github.com/cyliu111/SSCV/blob/main/image/d1_segments.jpg" width = "225">
* Example 2
<img src = "https://github.com/cyliu111/SSCV/blob/main/image/d2.jpg" width = "225"> <img src = "https://github.com/cyliu111/SSCV/blob/main/image/d2_contour.jpg" width = "225"> <img src = "https://github.com/cyliu111/SSCV/blob/main/image/d2_segments.jpg" width = "225">
* Example 3
<img src = "https://github.com/cyliu111/SSCV/blob/main/image/d3_o.jpg" width = "225"> <img src = "https://github.com/cyliu111/SSCV/blob/main/image/d3_contour.jpg" width = "225"> <img src = "https://github.com/cyliu111/SSCV/blob/main/image/d3_segments.jpg" width = "225"> <br> <br>
In each example, the first image is the original image. The second one and third one show the final contours and segments obtained by SSCV model.
