function calculate_distance(coords)
    total_distance = 0.0
    for i in 1:length(coords)-1
        x1, y1 = coords[i]
        x2, y2 = coords[i+1]
        total_distance += sqrt((x2 - x1)^2 + (y2 - y1)^2)
    end
    return total_distance
end

