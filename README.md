# **Nucleus Segmentation and Feature Extraction (MATLAB Project)**

## **Project Summary**

This MATLAB project implements an **automated nucleus segmentation and analysis pipeline** for microscopy images of cell nuclei. The solution performs **robust segmentation** of individual nuclei using optimized thresholding and watershed algorithms, **counts** each detected nucleus, and extracts **three key morphological features** for quantitative analysis. The project handles challenging image conditions including variable reflection and touching nuclei, providing both **visual documentation** and **tabular data** for further biological analysis.

---

## **Core Features**

* **Automated Nucleus Segmentation:** Identifies and separates individual nuclei from background using adaptive thresholding
* **Touching Nucleus Separation:** Implements watershed algorithm with distance transform to separate adjacent nuclei
* **Quantitative Feature Extraction:** Calculates area, perimeter, and ellipticity (axis ratio) for each nucleus
* **Multi-format Output Generation:** Produces text reports, CSV data files, and visual documentation
* **Optimized Parameter Tuning:** Fine-tuned threshold (0.68) balances detection sensitivity with noise rejection
* **Visual Numbering System:** Labels each nucleus with unique identifier for cross-referencing

---

## **Key Methods and Algorithms**

### **1. Image Preprocessing and Thresholding**

* **Adaptive Thresholding:** Uses Otsu's method (`graythresh`) with optimized multiplier (0.68) for nucleus-background separation
* **Noise Removal:** Applies area opening (`bwareaopen`) to eliminate small artifacts below 50 pixels
* **Hole Filling:** Utilizes `imfill` to complete nucleus boundaries and internal structures
* **Intensity Inversion:** Accounts for dark nuclei on light background (or vice versa) through proper threshold polarity

### **2. Watershed Segmentation for Touching Nuclei**

* **Distance Transform:** Computes Euclidean distance map (`bwdist`) from background to identify nucleus centers
* **Extended Minima:** Uses `imextendedmin` to identify regional minima without over-segmentation
* **Minima Imposition:** Applies `imimposemin` to modify distance transform for controlled watershed boundaries
* **Watershed Algorithm:** Separates touching nuclei while preserving natural boundaries

### **3. Feature Extraction and Analysis**

* **Region Properties Calculation:** Employs `regionprops` to compute:
  - **Area:** Pixel count of each nucleus
  - **Perimeter:** Boundary length using chain code approximation
  - **Major/Minor Axes:** Lengths of fitted ellipse for axis ratio calculation
* **Centroid Detection:** Locates nucleus centers for labeling and positional analysis
* **Axis Ratio Computation:** Calculates ellipticity as `MajorAxisLength / MinorAxisLength`

### **4. Data Management and Visualization**

* **Multi-format Export:**
  - Text file (`nucleus_analysis_results.txt`) with formatted human-readable report
  - CSV file (`nucleus_measurements.csv`) with tabular data for statistical analysis
  - PNG image (`nucleus_segmentation_results.png`) with visual documentation
* **Label Visualization:** Applies color mapping (`label2rgb`) with shuffled colormap for clear nucleus distinction
* **Interactive Numbering:** Places black numeric labels on colored nuclei for easy identification

---

## **Skills Demonstrated**

* **Biomedical Image Analysis:** Processing and interpretation of microscopy images for biological research
* **Computer Vision Algorithms:** Implementation of segmentation, morphological operations, and feature extraction
* **MATLAB Image Processing Toolbox:** Proficiency with specialized functions for medical image analysis
* **Parameter Optimization:** Systematic tuning of threshold values for optimal performance
* **Data Management:** Structured export of results in multiple formats for interdisciplinary collaboration
* **Visual Communication:** Creation of clear, informative visualizations for scientific documentation
* **Problem Solving:** Overcoming challenges of variable reflection and touching objects in biological images

---

## **File Overview**

| File | Description |
|------|-------------|
| **nucleus_segmentation_analysis.m** | Main MATLAB script implementing the complete pipeline |
| **normal40_var_refl.png** | Input microscopy image (black background with gray nuclei) |
| **nucleus_analysis_results.txt** | Formatted text report with nucleus count and feature table |
| **nucleus_measurements.csv** | Tabular data for all nuclei with area, perimeter, and axis ratio |
| **nucleus_segmentation_results.png** | Visualization showing original image and segmented nuclei with numbering |

---

## **Implementation Details**

### **Critical Parameters**
- **Threshold Multiplier:** 0.68 (optimized for `normal40_var_refl.png`)
- **Minimum Nucleus Area:** 100 pixels (post-processing filter)
- **Minimum Object Area:** 50 pixels (initial noise removal)
- **Extended Minima H:** 1 (controls watershed sensitivity)

### **Processing Pipeline**
1. **Image Loading:** Reads and converts to grayscale if necessary
2. **Binarization:** Applies optimized threshold to separate nuclei
3. **Morphological Cleaning:** Removes noise and fills holes
4. **Watershed Segmentation:** Separates touching nuclei
5. **Feature Extraction:** Calculates area, perimeter, and axis ratio
6. **Output Generation:** Saves results in multiple formats

### **Algorithm Performance**
- **Segmentation Accuracy:** High detection rate with minimal over-segmentation
- **Computational Efficiency:** Processes standard microscopy images in seconds
- **Robustness:** Handles variable image conditions through adaptive thresholding
- **Limitation:** May miss extremely low-contrast nuclei (acknowledged in documentation)

---

## **Results Example**

**Typical Output:**
```
=== EXERCISE RESULTS ===

A) NUCLEI SEGMENTATION AND COUNTING:
    Total nuclei segmented: 47 nuclei

B) FEATURE CALCULATIONS FOR EACH NUCLEUS:
Nucleus  Area    Perimeter   Axis Ratio
1       285.1    65.3        1.243
2       312.5    70.2        1.156
3       298.7    68.9        1.321
...     ...      ...         ...
```

**Visual Output:**
- Left panel: Original microscopy image
- Right panel: Color-coded segmented nuclei with black numeric labels

---

## **How to Use**

1. **Prepare Image:** Ensure microscopy image is in working directory
2. **Run Script:** Execute `nucleus_segmentation_analysis.m` in MATLAB
3. **Review Results:** Check generated files in working directory
4. **Adjust Parameters:** Modify threshold multiplier if segmentation needs optimization
5. **Analyze Data:** Import CSV file into statistical software for further analysis

---

## **Educational Value**

This project demonstrates practical application of:
- **Image segmentation** techniques for biological samples
- **Feature extraction** for quantitative morphology analysis
- **MATLAB programming** for scientific image processing
- **Documentation practices** for reproducible research
- **Parameter optimization** for real-world image analysis challenges
