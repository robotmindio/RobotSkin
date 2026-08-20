include <rm_common.scad>
// Default 60 mm visible tag insert. Change TAG_SIZE to suit printed tag.
TAG_SIZE=60;
tag_insert([TAG_SIZE,TAG_SIZE], border=3, t=1.0);
