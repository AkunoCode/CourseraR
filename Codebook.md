---
title: "Getting and Cleaning Data Project"
author: "John Leo D. Echevaria"
output: html_document
---

# Overview

This document outlines the dataset, variables, and processing steps used in the final project for the *Getting and Cleaning Data* course offered by Johns Hopkins University on Coursera.

# Data Source

The dataset used in this project is available at the [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones). It includes raw sensor data collected from smartphones carried by human participants during a series of physical activities.

# Background

A total of **30 participants**, aged **19 to 48 years**, were involved in the experiment. Each person wore a **Samsung Galaxy S II smartphone** on their waist while performing **six types of physical activity**:

1. Walking  
2. Walking upstairs  
3. Walking downstairs  
4. Sitting  
5. Standing  
6. Laying

## Data Recording and Structure

- The phone’s **accelerometer and gyroscope** recorded motion signals at a rate of **50Hz**.
- Video footage was used to manually label the data based on the activity being performed.
- Participants were randomly assigned:
  - **70%** to form the **training set**
  - **30%** to form the **test set**

## Signal Processing

1. Raw signals were cleaned using **noise filtering** techniques.
2. Data was segmented into **2.56-second windows**, overlapping by **50%** (resulting in 128 readings per segment).
3. The acceleration signals were separated into **body movement** and **gravitational** components using a **Butterworth low-pass filter** with a cutoff of **0.3 Hz**.
4. Features were extracted from each window in both the **time** and **frequency** domains.

# Features and Variables

Each entry in the final dataset includes the following components:

1. **3-axis accelerometer data** (total and body-specific acceleration)
2. **3-axis gyroscope data** (angular velocity)
3. A set of **561 features**, calculated from the time and frequency domain signals
4. A categorical **activity label**
5. A **subject ID** indicating the individual who performed the activity
