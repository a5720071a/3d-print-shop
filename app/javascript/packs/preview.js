const THREE = require('three');
const STLLoader = require('three-stl-loader')(THREE);
const OrbitControls = require('three-orbit-controls')(THREE);

$(document).on("turbolinks:load", function() {
  var model_url_container = $("#model-url");
  if (model_url_container.length) {

    //if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

    var model_url = model_url_container.val();
    var container;
    var mesh, scene, camera, cameraTarget, renderer, control;
    var model_loaded = false;
    var loading_manager = null;

    var geo_width, geo_depth, geo_height, geo_volume;
    var ratio_width, ratio_depth, ratio_height, ratio_volume;
    var default_width, default_depth, default_height;

    function init() {

      loading_manager = new THREE.LoadingManager();
      loading_manager.onLoad = function(){
        model_loaded = true;
        $("#loading-model").css({"display": "none"});
        $("#screenshot").val(renderer.domElement.toDataURL());
        console.log("original volume : " + geo_volumes + " mm3");
        console.log("original width : " + geo_width + " mm");
        console.log("original depth : " + geo_depth + " mm");
        console.log("original height : " + geo_height + " mm");
        console.log("original bounding box volume : " + (geo_width * geo_depth * geo_height) + " mm3");
        $.ajax({
          url: "/thumbnailer",
          method: "POST",
          dataType: "script",
          data: { screenshot: $('#screenshot').val(), model_url: $("#model-url").val()},
          error: function(xhr, status, error) {
            console.log('error');
          },
          success: function(data, status, xhr) {
            console.log('success');
          }
        });
        $('input').removeAttr('disabled');
        $('select').removeAttr('disabled');
      }
      // Put domElement container into page
      var preview_panel = $('#preview-panel');
      container = document.createElement('div');
      container.setAttribute('id', 'model-preview');
      container.setAttribute('class', 'model-preview');
      preview_panel.append(container);

      // create camera
      camera = new THREE.PerspectiveCamera( 65, 1, 0.001, 25 );
      camera.position.set( 0, 0, 0 );
      cameraTarget = new THREE.Vector3( 0, 0, 0 );

      // create scene
      scene = new THREE.Scene();  
      scene.background = new THREE.Color( 0xc9c9c9 );

      // create light source
      scene.add( new THREE.HemisphereLight( 0x555555, 0x111111 ) );
      addDirectionalLight( 0, 1, 0, 0xffffff, 0.2 );
      addDirectionalLight( 0.5, 1, 0, 0xffffff, 0.2 );
      addDirectionalLight( 1, 1, 0, 0xffffff, 0.2 );
      addDirectionalLight( 0, 1, 0.5, 0xffffff, 0.2 );
      addDirectionalLight( 0, 1, 1, 0xffffff, 0.2 );
      addDirectionalLight( 0, 1, -0.5, 0xffffff, 0.2 );
      addDirectionalLight( 0, 1, -1, 0xffffff, 0.2 );
      addDirectionalLight( -0.5, 1, 0, 0xffffff, 0.2 );
      addDirectionalLight( -1, 1, 0, 0xffffff, 0.2 );

      // create renderer
      renderer = new THREE.WebGLRenderer( { preserveDrawingBuffer: true, antialias: true } );
      renderer.setPixelRatio( window.devicePixelRatio );
      renderer.setSize( 150 , 150 , false );
      renderer.gammaInput = true;
      renderer.gammaOutput = true;
      renderer.shadowMap.enabled = true;
      renderer.shadowMap.renderReverseSided = false;

      // create mesh
      var loader = new STLLoader(loading_manager);
      loader.load( model_url, function ( geometry ) {
        getModelScale(geometry);
        var meshMaterial = new THREE.MeshPhongMaterial( { color: 0xAAAAAA, specular: 0x111111, shininess: 200 } );
        mesh = new THREE.Mesh( geometry, meshMaterial );
        mesh.position.set( 0, -0.5, 0 );
        mesh.rotation.set( 3 * Math.PI / 2 , 0, 0 );
        mesh.scale.set( 0.015, 0.015, 0.015 );
        var box = new THREE.Box3().setFromObject( mesh );
        var middle_y = -( box.getSize()["y"] / 2 );
        var box_max = Math.max( box.getSize()["x"], box.getSize()["y"], box.getSize()["z"] ) * 1.5;
        mesh.position.set( 0, middle_y, 0 );
        camera.position.set( 0, 0, box_max); 
        scene.add( mesh );
        renderer.render( scene, camera );
        var new_geometry = new THREE.Geometry().fromBufferGeometry(geometry);
        calculateVolume(new_geometry);
        function volumeOfT(p1, p2, p3){
          var v321 = p3.x*p2.y*p1.z;
          var v231 = p2.x*p3.y*p1.z;
          var v312 = p3.x*p1.y*p2.z;
          var v132 = p1.x*p3.y*p2.z;
          var v213 = p2.x*p1.y*p3.z;
          var v123 = p1.x*p2.y*p3.z;
          return (-v321 + v231 + v312 - v132 - v213 + v123)/6.0;
        }
        function calculateVolume(object){
          geo_volumes = 0.0;
          for(var i = 0; i < object.faces.length; i++){
              var Pi = object.faces[i].a;
              var Qi = object.faces[i].b;
              var Ri = object.faces[i].c;

              var P = new THREE.Vector3(object.vertices[Pi].x, object.vertices[Pi].y, object.vertices[Pi].z);
              var Q = new THREE.Vector3(object.vertices[Qi].x, object.vertices[Qi].y, object.vertices[Qi].z);
              var R = new THREE.Vector3(object.vertices[Ri].x, object.vertices[Ri].y, object.vertices[Ri].z);
              geo_volumes += volumeOfT(P, Q, R);
          }
          geo_volumes = Math.abs(geo_volumes);
          ratio_volumes = (geo_width * geo_depth * geo_height) / geo_volumes;
        }
      }, function(e) {
        var percentage = Math.round((e.loaded / e.total * 100));
        $("#percent").text(percentage);
      });

      //put domElement into container
      container.appendChild( renderer.domElement );

      // create orbit controls
      controls = new OrbitControls( camera, renderer.domElement );
      controls.enablePan = false;
      
      // create user controls
      $("#model-color").on( 'change', function(e){
        mesh.material.color.setHex( $(this).children(":selected").attr("id").split('_').pop() );
      });
      $(".render-quality").on( 'change', function(e){
        renderer.setSize( this.value, this.value, false );
      });
      $('#create-item').submit(function() {
        $("#finished-item").val(renderer.domElement.toDataURL());
        return true; // return false to cancel form action
      });
      $('#calculate-price').on( 'click', function(e){
        $.ajax({
          url: "/calculate_price",
          method: "POST",
          dataType: "script",
          data: { model_id : $("#model-id").val()},
          error: function(xhr, status, error) {
            console.log('error');
          },
          success: function(data, status, xhr) {
            console.log('success');
          }
        });
      });
    }

    function addDirectionalLight( x, y, z, color, intensity ) {
      var directionalLight = new THREE.DirectionalLight( color, intensity );
      directionalLight.position.set( x, y, z );
      scene.add( directionalLight );
    }

    function getModelScale(geometry) {

      // Calculate and set minimum value of each side
      geometry.computeBoundingBox();
      var boundingBox = geometry.boundingBox.clone();
      geo_width = Math.abs(boundingBox.min.x) + boundingBox.max.x;
      geo_depth = Math.abs(boundingBox.min.y) + boundingBox.max.y;
      geo_height = Math.abs(boundingBox.min.z) + boundingBox.max.z;
      var max_dimension = Math.max(geo_width,geo_depth,geo_height);
      var min_dimension = Math.min(geo_width,geo_depth,geo_height);
      /*
      ratio_width = (geo_width / min_dimension).toFixed(2);
      ratio_depth = (geo_depth / min_dimension).toFixed(2);
      ratio_height = (geo_height / min_dimension).toFixed(2);
      */
      // max print size is 140 mm
      var scale_slider_value = 1;
      var min_scale = (10 / min_dimension).toFixed(3);
      if(min_scale > 1) {
        scale_slider_value = min_scale;
      }
      var max_scale = (140 / max_dimension).toFixed(3);
      if(max_scale < 1) {
        scale_slider_value = max_scale;
      }
      $(".print-scaling").attr({"min" : min_scale, "max" : max_scale, "value" : scale_slider_value});
      $("#print-width").val((geo_width * scale_slider_value).toFixed(1));
      $("#print-depth").val((geo_depth * scale_slider_value).toFixed(1));
      $("#print-height").val((geo_height * scale_slider_value).toFixed(1));
      // Calculate scaled value
      /*
      function recalculateValue(value, ratio) {
        var currentValue = value;
        if(currentValue < (5 * ratio)) {
          currentValue = 5 * ratio;
        }
        var new_width = (Math.ceil(currentValue / ratio * ratio_width)).toFixed(1);
        var new_depth = (Math.ceil(currentValue / ratio * ratio_depth)).toFixed(1);
        var new_height = (Math.ceil(currentValue / ratio * ratio_height)).toFixed(1);
        var new_price = 50 + 0.1 * (new_width * new_depth * new_height)/(default_width * default_depth * default_height);
        var new_scale = (new_height / geo_height).toFixed(3);
        $(".print-scaling").val(new_scale);
        $("#print-width").val(new_width);
        $("#print-depth").val(new_depth);
        $("#print-height").val(new_height);
        $("#price").text(Math.round(new_price*1)/1);
      }
      $("#print-width").on( 'change', function(e){
        recalculateValue(this.value, ratio_width);
      });
      $("#print-depth").on( 'change', function(e){
        recalculateValue(this.value, ratio_depth);
      });
      $("#print-height").on( 'change', function(e){
        recalculateValue(this.value, ratio_height);
      });
      */
      $(".print-scaling").on( 'input', function(e){
        var new_width = (this.value * geo_width).toFixed(1);
        var new_depth = (this.value * geo_depth).toFixed(1);
        var new_height =(this.value * geo_height).toFixed(1);
        var new_price = 50 + 0.1 * (new_width * new_depth * new_height);
        $("#print-width").val(new_width);
        $("#print-depth").val(new_depth);
        $("#print-height").val(new_height);
        $(".print-scaling").val(this.value);
        $("#price").text(Math.round(new_price*1)/1);
      });
    }
    
    function animate() {
        requestAnimationFrame( animate );
        render();
        //stats.update();
    }

    function render() {
      camera.lookAt( cameraTarget );
	    if(model_loaded){
        renderer.render( scene, camera );
	    }
    }

    init();
    animate();

  }
});
