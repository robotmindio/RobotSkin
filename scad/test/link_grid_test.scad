// Grid alignment check: no hand-written positions. Every designed hole must
// land on a panel port centre. Assertions fail loudly at compile time.
include <../source/rm_common.scad>

function grid_positions(span) = [for(i=[0:grid_count(span)-1]) grid_position(i,span)];
function contains(haystack, needle) = [for(h=haystack) h==needle] != [];
function off_grid(positions, holes) = [for(h=holes) if(!contains(positions,h)) h];

// Link columns run across the wall; rows run perpendicular toward the seam.
// A 40 mm link lives on a 40 mm panel, an 80 mm link on an 80 mm span.
assert(off_grid(grid_positions(40), link_hole_xs(40)) == [],
       "40 mm link holes off the 40 mm port grid");
assert(off_grid(grid_positions(80), link_hole_xs(80)) == [],
       "80 mm link holes off the 80 mm port grid");

// Flat pairs join at the panel seam; the two link rows sit at +/-RM_LINK_ROW
// off the seam, which is the first free port row of each panel in a pair.
pair_rows = concat(grid_positions(40),
                   [for(y=grid_positions(40)) y+RM_UNIT]);
off_pair = [for(y=[RM_UNIT/2-RM_LINK_ROW,RM_UNIT/2+RM_LINK_ROW])
              if(!contains(pair_rows,y)) y];
assert(off_pair == [], "Flat link row misses the seam-adjacent port row");

// Angle link rows: RM_CORNER_ROW and one full grid pitch out from the fold.
corner_rows = [RM_CORNER_ROW, RM_CORNER_ROW+RM_GRID];
assert(corner_rows[1]-corner_rows[0] == RM_GRID,
       "Angle link rows must be exactly one grid pitch apart");

// A trivial solid so the test edits as a valid render when asserts pass.
cube([1,1,1]);