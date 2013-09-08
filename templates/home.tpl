<!DOCTYPE html>
<html>
<head>
<meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="apple-mobile-web-app-title" content="GeoPacman">
  <link rel="stylesheet" href="http://code.google.com/apis/maps/documentation/javascript/examples/default.css" />
  <link rel="stylesheet" href="style.css" />

<script src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script src="js/jquery.js"></script>
<script>
    var map;
    var viewCount = true;
    var markerArray = [];
    var markers = [];
    var markerData = [];
    var allMarkers = [];
    var currentLocation;
    function init() 
    {

        <?php
        while($latlong = mysqli_fetch_assoc($coords))
        {
        ?>
            markerData.push({
                'lat' : [lat], 
                'lon' : [lon],
                'desc' : "Stecknadel",
                'id' : [id]});
        <?php
        }
        ?>
        map = new google.maps.Map(document.getElementById("map_canvas"), {
            zoom: 15,
            center: new google.maps.LatLng(52.3145,13.2445),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        for (var i = 0; i < markerData.length; i++) {
            var mark = new google.maps.Marker({
                position: new google.maps.LatLng(markerData[i].lat, markerData[i].lon), 
                map: map,
                title: markerData[i].desc,
                icon: "http://www.geopacman.org/pic/pin_red.png"
            });
            allMarkers[i] = mark;
            markers.push(mark);
            addInfoWindow(mark, markerData[i], i);
        }
    }

    function checkMarker() {
      for (var i = 0; i < markerData.length; i++) {
        checkMarkerPost(i);
      };
    }

    function checkMarkerPost (i) {
       $.post("checkmarker.php", {i:markerData[i].id}).done(function(data) {
          if(data == "0") {
            markers[i].setMap(null);
          }
        });
    }

    function addInfoWindow (marker, data, i) {
      var info = "<a href='#' onclick=\"checkPoint("+data.id+","+i+");return false;\">100 Punkte einsammeln</a>";


      var infowindow = new google.maps.InfoWindow({content: info});
      google.maps.event.addListener(marker, "click", function() {
        infowindow.open(map, this)
      }); 
    } 
 
    function checkMyGeo(data, i)  {
      var lon = currentLocation['lon'];
      var lat = currentLocation['lat'];
      if(lat+0.001 > data.lat && lat-0.001 < data.lat && lon+0.1 && lon-0.1) {
        alert("hallo");
      }
      return "<a href='#' onclick=\"checkPoint("+data.id+","+i+");return false;\">onclick</a>";

    } 

    function center(lat, lon) {
        if(markerArray.length > 0) {
            markerArray[0].setMap(null);
            markerArray = [];
        }
        var markerTest = new google.maps.Marker({
            position: new google.maps.LatLng(lat, lon), 
            map: map,
            title: "Standort",
            icon: "http://www.geopacman.org/pic/location.png"
        });  
        markerArray.push(markerTest);
    } 
    
    function checkPoint(id, i) {
      markers[i].setMap(null);
      $.post("checkpoint.php", { id: id } );
      console.log(id);
    }

    function geodata() {
        var latitude, longitude;
          if ("geolocation" in navigator) {
            navigator.geolocation.getCurrentPosition(
              function(position) {
                latitude = position.coords.latitude;
                longitude = position.coords.longitude;
                if (viewCount) {
                  map.setCenter(new google.maps.LatLng(latitude, longitude));
                  viewCount = false;
                };
                currentLocation = {lat: latitude, lon: longitude};
                center(latitude, longitude);
              },
              function(error) {
                messageConsole(error.message);
              }, {
                enableHighAccuracy: true,
                timeout: 10000
              }
            );
          } else {
            /* geolocation IS NOT available */
          }
    }
  window.onload = function() {
    geodata();
    init();
  };
  window.setInterval(function() {
      geodata();
  }, 7000);
window.setInterval(function() {
      checkMarker();
  }, 15000);


  function messageConsole(mess) {
    $('#message').html('<center>'+mess+'</center>');
    $('#message').fadeIn('slow');
    window.setTimeout(function() {
      $('#message').fadeOut('slow');
    }, 9000);
  }
</script>
</head>
<body>
     <div id="full_screen">
     
          <div id="menue_top">
              <img id="logo" src="icon.png">
               <img id="logo" src="Geo-Pac.png">
            
         <form id="login_form">
             <input class="login" name="username" type="text" placeholder="Nutzername" size="15">
             <input class="login" name="password" type="password" placeholder="Passwort" size="15">
             <input type="submit" value=" Einloggen ">
         </form>
     </div>
     
     <!-- <div id="message"></div> -->
      <div id="map_canvas"></div>
                  
                  
      
              
              
              
      </div>
       
        
  </div>  
     
     
     
     
     
     
    
</body>
</html>