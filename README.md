# Shape Hierarchy and Categorization

One Paragraph of the project description

See the <a href="http://2dshapesstructure.github.io">original project website</a> for a more comprehensive overview of the research study.

## Getting Started

These instructions will give you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on deploying the project on a live system.

### Prerequisites

Requirements for the software and other tools to build, test and push 
- MATLAB

### Installing

A step by step series of examples that tell you how to get a development
environment running

Say what the step will be

    Give the example

And repeat

    until finished

End with an example of getting some data out of the system or using it
for a little demo

## Running the program

Run the runMe.m file and wait for results. The amount of clusters is currently set to 5, but this can be changed to any number up to 9.

Expected output: the MATLAB console will display model parameters and cluster data.

*There are NO popup figures; we suppressed the popups because of the size of the dataset, but the PNG files will be created inside the appropriate folders for viewing later

Data files: dataset.mat, annotationTable.csv
MATLAB function to run: runMe.m

Directory Structure:

final_[name]

|

|__ clusters

|     |__ ... # random samples from each cluster

|

|__ images

|     |__ ... # each annotation from random samples from each cluster

|

|__ JSON

|     |__ ... # JSON shape files

|

|__ our_clusters

|     |__ ... # example clusters

| 

| annotationTable.csv

| dataset.mat

| displayShape.m

| extractFeatures.m

| featureData.mat

| readJSON.m

| runMe.m

|____


### Example console output

```
>> runMe
Building k-means clustering model. Please hold, this will take a while...
Parameters: k = 4, repetitions = 10, samples = 49, max iterations: 100

Replicate 1, 66 iterations, total sum of distances = 2991.77.
Replicate 2, 76 iterations, total sum of distances = 2991.77.
Replicate 3, 68 iterations, total sum of distances = 2991.78.
Replicate 4, 54 iterations, total sum of distances = 2991.77.
Replicate 5, 71 iterations, total sum of distances = 2991.77.
Replicate 6, 28 iterations, total sum of distances = 2991.78.
Replicate 7, 86 iterations, total sum of distances = 2991.78.
Replicate 8, 21 iterations, total sum of distances = 3400.97.
Replicate 9, 53 iterations, total sum of distances = 2991.78.
Replicate 10, 78 iterations, total sum of distances = 2991.78.
Best total sum of distances = 2991.77
Current cluster: k4-cluster1
Current cluster: k4-cluster2
Current cluster: k4-cluster3
Current cluster: k4-cluster4
Centroid locations:
    0.4726    0.3853    0.1437    0.0465    0.3219
    0.9088    0.0866    0.0568    0.0046    0.1193
    0.2472    0.2685    0.5262    0.0235    0.3662
    0.2184    0.7118    0.0974    0.0125    0.2498

You made it to the end of the script! Yay!
>> 
```

## Deployment

Add additional notes to deploy this on a live system


## Authors

This sub-project:

  - **Sara Bawale**
  - Caroline Dahl
  - Giuliana Zanutta

Original research study:

  - Axel Carlier
  - Kathryn Leonard
  - Stefanie Hahmann
  - Géraldine Morin
  - Misha Collins

## Acknowledgments

  - Many thanks to professor Kathryn Leonard for the support in developing this project
  - Thank you to Billie Thompson - <a href="https://github.com/PurpleBooth">PurpleBooth</a> for providing the the template for this README file
