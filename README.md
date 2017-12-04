# Character classification via Principle Component Analysis

This basic Octave/Matlab project demonstrates how to use
PCA to classify a set of vectorized data, such as images.

Here, a set of Chinese calligraphic characters are used
in different styles as training sets. Then clean and noisy
images of characters can be classified by projecting them
onto the principle components generated from the training
data set.

Thank you to Dr. Paul H. Shimpf, PhD of Eastern Washington
University for demonstrating this technique to me as a way
to implement facial recognition via image classification.

To run the classifier, install free Gnu Octave (or Matlab $$$):

https://wiki.octave.org/GNU_Octave_Wiki

Then follow the instructions below.


## Instructions:

---------------------------------------------------

### TRAINING

To set up the classification data structures,
at the Matlab/Octave prompt type:

```
>> image_p_components
```

to run the image_p_components.m script

When prompted to select the number of principle
components to retain, it is suggested to use 15.
If the number is changed, the classifychar.m
script must be changed to have the hard-coded
P15 data file name changed to PXX, where XX is
the number of components retained.

Executing this script will generate the classifier
template files Tc1, Tc2, Tc3, Tc4, for characters
c1, ..., c4, respectively, as well as the PXX
principle component data template file. These files
are used by the classifychar script to classify an
unknown character by matching it to the closest
template.

NOTE: These files have already been generated
and stored with the demo package, so you do not
need to run this script unless you want to test
new character data templates, or change the number
of principle components retained.

NOTE: This script relies on the images in the
directories c1, c2, c3 and c4 to generate the data
templates. It references the hard-coded directory
names, and file names within the directories, to
access the template files.

---------------------------------------------------

### CLASSIFICATION

To classify an unkown character image,
at the Matlab/Octave prompt type:

```
>> classifychar
```

When prompted for the file prefix name, enter the
name in single quotes, e.g. for the file c1.png,
enter:

```
>> 'c1'
```

NOTE: Both of these scripts expect files of the
.png format currently.
