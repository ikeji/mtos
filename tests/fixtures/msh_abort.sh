# msh abort-on-error test — second command fails (cat on missing file
# returns exit=1), third command must NOT run because set -e aborts.
echo before
cat /this_file_does_not_exist
echo never_printed
