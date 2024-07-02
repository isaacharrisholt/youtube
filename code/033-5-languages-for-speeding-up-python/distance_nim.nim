import nimpy
import math

proc calculateDistance(coords: seq[tuple[x, y: float]]): float {.exportpy.} =
    var totalDistance: float = 0.0
    for i in 0..<len(coords)-1:
        let dx = coords[i+1].x - coords[i].x
        let dy = coords[i+1].y - coords[i].y
        totalDistance += sqrt(dx*dx + dy*dy)
    return totalDistance
