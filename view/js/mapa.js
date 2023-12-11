var map = L.map('map').setView([-34.603722, -58.381592], 13);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
    maxZoom: 18
}).addTo(map);

var marker;

function onMapClick(e) {
    if (marker) {
        map.removeLayer(marker);
    }

    marker = L.marker(e.latlng).addTo(map);

    document.getElementById('direccion').value = e.latlng.lat + ', ' + e.latlng.lng;
}

map.on('click', onMapClick);