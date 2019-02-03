# DisparityMapfromStereoPair
Given the stereo pair of two scan-line aligned images, tsukuba_l.png and tsukuba_r.png, compute the disparity map of the stereo pair images.
```
midterm_Q4_v1.m : This code computes disparity map of the stereo pair
midterm_Q4_SSD.m : This code computes disparity map of the stereo pair using SSD and window-based matching
midterm_Q4_v3.m : This code computes disparity map of stereo pair using block matching w/ Dynamic Programming
project.m : This function pixel coordinates of the projected points in the image
SSD.m : This function computes the Sum Of Square Differences of 2 given images
```
```
tsukuba_l.png : Stereo image left pair (Original image of Q4)
```
![tsukuba_left](/tsukuba_l.png)

```
tsukuba_r.png : Stereo image right pair (Original image of Q4)
```
![tsukuba_right](/tsukuba_r.png)

```
dispMap1.jpg : The generated 3D plot of stereo pair 
```
![dispMap1.jpg](/dispMap1.jpg)

```
dispMap2.jpg : The generated disparity map of stereo pair with SSD and window-based matching
```
![dispMap2.jpg](/dispMap2.jpg)

```
dispMap3.jpg : The generated disparity map of stereo pair using block matching w/ Dynamic Programming
```
![dispMap3.jpg](/dispMap3.jpg)
