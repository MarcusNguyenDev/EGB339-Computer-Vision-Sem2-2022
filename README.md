# EGB339-Computer-Vision-Sem2-2022
## Note
To verify the function, run the validate_solution.m included in each folder.

The test cases and validate_solution.m are provided by QUT.

These functions passed all test on Matlab Grader and recieved 20/20 points

Problem 3 did not come with a test function

## Description
* Problem 1: Segmentation and Shape Classification

  *  Write a function that returns the centroid coordinates of all circles, squares, and triangles in the image.
The centroids should be returned as three Nx2 matrices, containing the (u,v) coordinates of the centroids. You do not have to worry about the order in which you return the centroids (i.e. it does not matter if the top-right centroid is in row 1 or any other row of your returned 9x2 matrix). Your function will be called and provided with a grayscale image, of type uint8.

* Problem 2: Segmentation of Calibration Markers

  *   Write a function that returns a binary image and the coordinates of the centroids of the blue calibration markers.
The binary image should be the same size as the input image. Only pixels corresponding to blue pixels in the original image should contain a logical 1 (true). All other pixels should be 0 (false).
The centroids should be returned as a 9x2 matrix, containing the (u,v) coordinates of the centroids of all 9 markers. You do not have to worry about the order in which you return the centroids (i.e. it does not matter if the top-right centroid is in row 1 or any other row of your returned 9x2 matrix).

* Problem 3: Homography Calculation

  * A robot arm with a camera mounted to its endeffector is operating on top of a planar workspace, similar to the one pictured below. The planar workspace contains 9 calibration markers in the form of blue circles (arranged in a regular grid pattern with equal spacing of 250mm between the centroids), and a number of other geometric shapes in red and green. The world coordinates of the calibration markers are known. 
Your task is to calculate the homography H that maps from image coordinates to workspace coordinates, such that q = Hp (where p is an image point, and q is a point in the workspace). 

* Problem 4: 3D Vision

  * Consider the following scenario: A robot arm is equipped with a small stereo camera mounted at its endeffector. The robot positions the camera in a way that it looks directly downwards onto a planar work space, similar to the scenario pictured below. You can assume that the two cameras of the stereo camera are perfectly calibrated and aligned pinhole cameras (i.e. there is no lens distortion or similar effects). You can further assume that both image planes are coplanar, and parallel to the planar workspace.
Given both images from the stereo camera, your task is to write a function that calculates the vertical distance between camera and the workspace plane (i.e. the vertical distance between camera and the table in the picture). From the datasheet of the stereo camera and the used lenses you know that the focal length is 2.5mm, and that the baseline (distance between the two camera centers) is 5cm. Furthermore, the cameras have global shutter CCD chips with a pixel size of 4, and a frame rate of 30Hz.
Task:
Write a function that accepts two images (from the left and right camera of a stereo camera) and returns the disparity and the distance between the left camera center and the planar scene, following the general description above. Return the disparity in pixels, and the depth in meters.
