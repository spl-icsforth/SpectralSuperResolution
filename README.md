# Spectral Super Resolution of Hyperspectral Images
### **Code for Spectral Super Resolution of Hyperspectral Images**


# Table of contents
1. [Introduction](#introduction)
2. [Dependencies](#paragraph1)
3. [Execution](#paragraph2)

## Introduction <a name="introduction"></a>
This repository contains MATLAB codes and scripts designed for the spectral super-resolution of hyperspectral data.
The proposed approach synthesizes a high spectral resolution 3D data cube from its acquired low resolution form,
by capitalizing on the Sparse Representations (SR) learning framework. According to the SR framework, various 
low and high-spectral resolution datacubes can be represented as sparse linear combinations of elements from
learned over-complete dictionaries.

## Dependencies <a name="paragraph1"></a>

**Dataset** 

* The performance of the proposed spectral super-resolution scheme, is quantified using EO-1 NASA's Hyperion satellite 
hyperspectral Earth Observation scenes. Due to its high spectral coverage, Hyperion scenes have been widely utilized 
in the remote sensing community for classification and spectral unmixing purposes. We considered hyperspectral scenes 
of the Hawaii island, acquired on August 30, 2015, and utilized 67 spectral bands in the visible and near infrared spectrum range,
from 436.9 to 833.83 nm.


**Dictionaries**

* Regarding the dictionary training phase, we designed coupled dictionaries that model both the high
  and the low spectral resolution feature spaces, based on a ADMM Sparse Coupled Dictionary Learning scheme.

* We trained 512 representative dictionary atoms from 100.000 couples of training low and high spectral resolution datacubes.

* We have experimented with variant sub_sampling factors: x2, x3,x4

**In order to run the code, the testing 3D datacube must be downloaded:** 

* This link provides the sample data:
[link](https://www.dropbox.com/s/pn60j5l4hozmfoc/test_cube.mat?dl=0)


**The testing hypercube should be placed in the same folder with the source code**

## Execution <a name="paragraph2"></a>

The primary function is **SPSR.m** which is designed to take a 3D data cube, the coupled dictionaries, 
a sparsity regularization parameter , and the sub-sampling factor, and attemp to reconstruct the high-spectral resolution hypercube.

**Input Arguments**

* **test\_cube\_small**: Input hypercube

* **D\_high** : High spectral resolution dictionary

* **D\_low** :  Low spectral resolution dictioanary

* **lambda**  : sparsity regularization parameter

* **lin\_p** : parameter that controls the amount of contrast of the reconstructed hyper-pixels.

* **full\_bands** : total number of spectral bands

* **sub\_sampling** : sub-sampling factor

**Output Arguments**

* **full\_bands\_admm** : Estimated high-spectral resolution hypercube

The primary script that loads the data, the dictionaries and provides visual results of the reconstructed spectral profiles 
is **demo\_SPSR.m**

In the **demo\_SPSR.m**, we reconstruct the high spectral resolution hypercube, from the correspondent low-spectral resolution 3D data cube. 



