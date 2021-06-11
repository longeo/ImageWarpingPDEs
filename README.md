# ImageWarpingPDEs

## Motivation

Image warping is a branch of image processing that deals with the geometric transformation of digital images. Warping can be used for creative purposes or for the correction of image distortion. Image processing software such as Photoshop, allows users to alter images by specifying a warp at a given point. However, this process may become arduous when the user is attempting to warp an image along a desired curve. The goal of this project is to create a method that will allow the user to warp e.g. shrink, stretch or pinch a specific part of an image along any specified spline while preserving the surrounding area. Ultimately this process will be applied to images of Classical Renaissance paintings with the goal of correcting perceived anatomical imperfections.

## Mathematical Method

This project develops a method that allows users to define a curve or line in an image and then to create a warp based on how the user chooses to change that curve. This curve is known as a spline and the movements of the pixels along it are used to characterize the warp. Parametric equations are used to define both the initial spline and the user transformed spline. A vector field of the movements of all pixels in the image is created using the known pixel movements and an interpolation function. Finding the interpolation function involves solving the Poisson partial differential equation through the use of numerical methods. Finally, the new process is employed to correct anatomical imperfections in images of classical Renaissance paintings.

See more project details and results in the 'details' PDF for further information.
