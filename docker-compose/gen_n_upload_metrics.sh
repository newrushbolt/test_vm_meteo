
PLACES='2200 Vodopad 1500 960 Vostok_900 Piramida'
VM_ADDR='http://localhost:8428'
VM_LOGIN=kp_resort_meteo
VM_PASSWORD=kp_resort_meteo

for PLACE in $PLACES; do
	WIND_SPEED="$(( RANDOM % 30 )).$(( RANDOM % 10 ))"
	WIND_DIRECTION="$(( RANDOM % 361 )).$(( RANDOM % 10 ))"
	curl -s -u "${VM_LOGIN}:$VM_PASSWORD" \
	  -d "${WIND_SPEED},${WIND_DIRECTION}" \
	  "http://localhost:8428/api/v1/import/csv?format=1:metric:kp_meteo_ws_mean,2:metric:kp_meteo_wd_mean&extra_label=location=${PLACE}"
done
