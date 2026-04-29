# msh smoke test — verifies set -ex tracing, # comment skip,
# blank line skip, and exit-code propagation. Must run under msh.
echo first

# this is a comment, should be skipped silently

echo second
echo third
