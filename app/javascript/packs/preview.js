const THREE = require('three')
const STLLoader = require('three-stl-loader')(THREE)
const OrbitControls = require('three-orbit-controls')(THREE)

$(document).on("turbolinks:load", function() {
  var model_url_container = $("#model-url");
  if (model_url_container.length) {

    //if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

    var model_url = model_url_container.html();
    var container;
    var mesh, scene, camera, cameraTarget, renderer, control;

    function init() {

      // Put domElement container into page
      var preview_panel = $('#preview-panel');
	    container = document.createElement('div');
      container.setAttribute('id', 'model-preview');
      container.setAttribute('class', 'model-preview');
      preview_panel.append(container);

      // create camera
      camera = new THREE.PerspectiveCamera( 65, 1, 0.1, 25 );
      camera.position.set( 0, 0.5, 3 );
	    cameraTarget = new THREE.Vector3( 0, 0.5, 0 );

      // create scene
	    scene = new THREE.Scene();  
	    scene.background = new THREE.Color( 0xc9c9c9 );

      // create mesh
	    var loader = new STLLoader();
	    loader.load( model_url, function ( geometry ) {
        getModelScale(geometry)
		    var meshMaterial = new THREE.MeshPhongMaterial( { color: 0xAAAAAA, specular: 0x111111, shininess: 200 } );
		    mesh = new THREE.Mesh( geometry, meshMaterial );
		    mesh.position.set( 0, -0.5, 0 );
		    mesh.rotation.set( 3 * Math.PI / 2 , 0, 0 );
        mesh.scale.set( 0.015, 0.015, 0.015 );
		    scene.add( mesh );
	    } );

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
	    renderer = new THREE.WebGLRenderer( { antialias: true } );
	    renderer.setPixelRatio( window.devicePixelRatio );
      renderer.setSize( 150 , 150 , false );
	    renderer.gammaInput = true;
	    renderer.gammaOutput = true;
	    renderer.shadowMap.enabled = true;
	    renderer.shadowMap.renderReverseSided = false;

      //put domElement into container
	    container.appendChild( renderer.domElement );

	    // stats
	    //stats = new Stats();
	    //container.appendChild( stats.dom );

	    // create orbit controls
      controls = new OrbitControls( camera, renderer.domElement );
      controls.enablePan = false;
      
      // create user controls
	    $("#model-color").on( 'change', function(e){
        mesh.material.color.setHex( $(this).children(":selected").attr("id").split('_').pop() );
      });
      $("#quality-ll").on( 'change', function(e){
        renderer.setSize( 150 , 150 , false );
      });
      $("#quality-l").on( 'change', function(e){
        renderer.setSize( 200 , 200 , false );
      });
      $("#quality-m").on( 'change', function(e){
        renderer.setSize( 250 , 250 , false );
      });
      $("#quality-h").on( 'change', function(e){
        renderer.setSize( 375 , 375 , false );
      });
      $("#quality-hh").on( 'change', function(e){
        renderer.setSize( 500 , 500 , false );
      });

    }

    function addDirectionalLight( x, y, z, color, intensity ) {
	    var directionalLight = new THREE.DirectionalLight( color, intensity );
	    directionalLight.position.set( x, y, z );
	    scene.add( directionalLight );
    }

    function getModelScale(geometry) {

      // Calculate and set minimum value of each side
      geometry.computeBoundingBox()
      var boundingBox = geometry.boundingBox.clone();
      var geo_width = Math.abs(boundingBox.min.x) + boundingBox.max.x;
      var geo_depth = Math.abs(boundingBox.min.y) + boundingBox.max.y;
      var geo_height = Math.abs(boundingBox.min.z) + boundingBox.max.z;
      var min_dimension = Math.min(geo_width,geo_depth,geo_height);
      var ratio_width = (geo_width / min_dimension).toFixed(2);
      var ratio_depth = (geo_depth / min_dimension).toFixed(2);
      var ratio_height = (geo_height / min_dimension).toFixed(2);
      $('#model-scale').text("มาตราส่วน สูง "+ratio_height+" : กว้าง "+ratio_width+" : ลึก "+ratio_depth)
      var min_width = (Math.ceil(ratio_width * 10) / 2).toFixed(1)
      var min_depth = (Math.ceil(ratio_depth * 10) / 2).toFixed(1)
      var min_height = (Math.ceil(ratio_height * 10) / 2).toFixed(1)
      $("#print-width").attr({"min" : min_width, "value" : min_width});
      $("#print-depth").attr({"min" : min_depth, "value" : min_depth});
      $("#print-height").attr({"min" : min_height, "value" : min_height});

      // Calculate scaled value
      function recalculateValue(value, ratio) {
        var currentValue = value
        if(currentValue < 5 * ratio) {
          currentValue = 5 * ratio;
        }
        var new_width = (Math.ceil(currentValue / ratio * ratio_width * 2) / 2).toFixed(1);
        var new_depth = (Math.ceil(currentValue / ratio * ratio_depth * 2) / 2).toFixed(1);
        var new_height = (Math.ceil(currentValue / ratio * ratio_height * 2) / 2).toFixed(1);
        $("#print-width").val(new_width);
        $("#print-depth").val(new_depth);
        $("#print-height").val(new_height);
      }
	    $("#print-width").on( 'change', function(e){
        recalculateValue(this.value, ratio_width)
      });
	    $("#print-depth").on( 'change', function(e){
        recalculateValue(this.value, ratio_depth)
      });
	    $("#print-height").on( 'change', function(e){
        recalculateValue(this.value, ratio_height)
      });
    }

    function takeScreenshot() {
      var w = window.open('', '');
      w.document.title = "Screenshot";
      var img = new Image();
      renderer.render(scene, camera);
      img.src = renderer.domElement.toDataURL();
      w.document.body.appendChild(img);
    }
    $("#screenshot").on( 'click', function(e){
        takeScreenshot()
    });
    
    function animate() {
	    requestAnimationFrame( animate );
	    render();
	    //stats.update();
    }

    function render() {
	    camera.lookAt( cameraTarget );
	    renderer.render( scene, camera );
    }

    init();
    animate();

  }
})
