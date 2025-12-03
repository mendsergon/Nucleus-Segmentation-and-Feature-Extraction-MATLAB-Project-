% Nucleus Segmentation and Feature Extraction
clear; clc;

% Read image
img = imread('normal40_var_refl.png');
if size(img, 3) == 3
    img = rgb2gray(img);
end

% A) Segment nuclei with optimal threshold
level = graythresh(img);
binary_img = imbinarize(img, level * 0.68); 
binary_img = bwareaopen(binary_img, 50);
binary_img = imfill(binary_img, 'holes');

% Watershed to separate touching nuclei without over-segmentation
D = bwdist(~binary_img);
D = -D;
mask = imextendedmin(D, 1);
D2 = imimposemin(D, mask);
watershed_labels = watershed(D2);
binary_img(watershed_labels == 0) = 0;

% Final cleanup
binary_img = bwareaopen(binary_img, 100);
labeled_img = bwlabel(binary_img);

% B) Count nuclei and calculate features
stats = regionprops(labeled_img, 'Area', 'Perimeter', 'MajorAxisLength', 'MinorAxisLength', 'Centroid');
num_nuclei = length(stats);

% Save results to text file
fid = fopen('nucleus_analysis_results.txt', 'w');

fprintf(fid, '=== EXERCISE RESULTS ===\n\n');

% A) Answer: Segment and count nuclei
fprintf(fid, 'A) NUCLEI SEGMENTATION AND COUNTING:\n');
fprintf(fid, '    Total nuclei segmented: %d nuclei\n\n', num_nuclei);

% B) Answer: Calculate features for each nucleus
fprintf(fid, 'B) FEATURE CALCULATIONS FOR EACH NUCLEUS:\n');
fprintf(fid, 'Nucleus\tArea\t\tPerimeter\tAxis Ratio\n');
fprintf(fid, '-------\t-----\t\t----------\t----------\n');

% Create table for CSV export
results_table = table((1:num_nuclei)', zeros(num_nuclei,1), zeros(num_nuclei,1), zeros(num_nuclei,1), ...
    'VariableNames', {'NucleusID', 'Area', 'Perimeter', 'AxisRatio'});

for i = 1:num_nuclei
    % α) Area
    area = stats(i).Area;
    
    % β) Perimeter length  
    perimeter = stats(i).Perimeter;
    
    % γ) Major/Minor axis ratio
    major_axis = stats(i).MajorAxisLength;
    minor_axis = stats(i).MinorAxisLength;
    axis_ratio = major_axis / minor_axis;
    
    % Write to text file
    fprintf(fid, '%d\t%.1f\t\t%.1f\t\t%.3f\n', i, area, perimeter, axis_ratio);
    
    % Store in table for CSV
    results_table.Area(i) = area;
    results_table.Perimeter(i) = perimeter;
    results_table.AxisRatio(i) = axis_ratio;
end

fclose(fid);

% Save results to CSV file
writetable(results_table, 'nucleus_measurements.csv');

% Display results in command window too
fprintf('=== EXERCISE RESULTS ===\n\n');
fprintf('A) NUCLEI SEGMENTATION AND COUNTING:\n');
fprintf('    Total nuclei segmented: %d nuclei\n\n', num_nuclei);
fprintf('B) FEATURE CALCULATIONS FOR EACH NUCLEUS:\n');
fprintf('Nucleus\tArea\t\tPerimeter\tAxis Ratio\n');
fprintf('-------\t-----\t\t----------\t----------\n');

for i = 1:num_nuclei
    fprintf('%d\t%.1f\t\t%.1f\t\t%.3f\n', i, results_table.Area(i), results_table.Perimeter(i), results_table.AxisRatio(i));
end

fprintf('\nResults saved to:\n');
fprintf(' - nucleus_analysis_results.txt (formatted report)\n');
fprintf(' - nucleus_measurements.csv (table data)\n');

% Visualization with numbering
figure;
subplot(1,2,1);
imshow(img);
title('Original Image');

subplot(1,2,2);
imshow(label2rgb(labeled_img, 'jet', 'w', 'shuffle'));
title(['Segmented Nuclei: ' num2str(num_nuclei) ' nuclei']);
hold on;

% Add numbers to nuclei
for i = 1:num_nuclei
    centroid = stats(i).Centroid;
    text(centroid(1), centroid(2), num2str(i), ...
         'Color', 'black', 'FontSize', 8, 'FontWeight', 'bold', ...
         'HorizontalAlignment', 'center');
end
hold off;

% Save the visualization
saveas(gcf, 'nucleus_segmentation_results.png');
fprintf(' - nucleus_segmentation_results.png (visualization)\n');