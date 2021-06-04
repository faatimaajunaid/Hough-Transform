# Hough-Transform
Line detection using Hough Transform

Designed as an efficient method to find lines from marked edge points, consisting of three primary steps based on using the normal representation of a line, ρ = r cos(θ)+ c sin(θ):
1. Define the desired increments on ρ and θ, Δρ and Δθ , and quantize the space accordingly.
2. For every point of interest (typically points found by edge detectors that exceed some threshold value), plug the values for r and c into the line equation:
ρ = rcos(θ)+ csin(θ)
Then, for each value of θ in the quantized space, solve for ρ.
3. For each ρθ pair from Step 2, record the r and c pair in the corresponding block in the quantized space. This constitutes a hit for that particular block.
After performing the Hough transform, post-processing must be done to extract the line information.
