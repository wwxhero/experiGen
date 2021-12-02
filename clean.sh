echo "removing the previous files..."
find ./|grep -i -E "(*\.csv)|(*\.json)" | grep -i -E "_full"
find ./|grep -i -E "(*\.csv)|(*\.json)" | grep -i -E "_full" | xargs rm