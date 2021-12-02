#!/bin/bash
echo "removing the previous files..."
find ./|grep -i -E "(*\.csv)|(*\.json)" | grep -i -E "_full"
find ./|grep -i -E "(*\.csv)|(*\.json)" | grep -i -E "_full" | xargs rm

echo "generating files"
matlab.exe -r "cd ./, run('SC_A_csv_script.m'), clear;
					  run('SC_A_json_script.m'), clear;
					  run('SC_AV_csv_script.m'), clear;
					  run('SC_AV_json_script.m'), clear;
					  run('SC_V_csv_script.m'), clear;
					  run('SC_V_json_script.m'), clear;
					  run('TTC_A_csv_script.m'), clear;
					  run('TTC_A_json_script.m'), clear;
					  run('TTC_AV_csv_script.m'), clear;
					  run('TTC_AV_json_script.m'), clear;
					  run('TTC_V_csv_script.m'), clear;
					  run('TTC_V_json_script.m'), clear;
					  , quit"