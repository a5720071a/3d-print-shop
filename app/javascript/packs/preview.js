const THREE = require('three')
const STLLoader = require('three-stl-loader')(THREE)
const OrbitControls = require('three-orbit-controls')(THREE)

$(document).on("turbolinks:load", function() {
  var model_url_container = $("#model_url");
  if(model_url_container.length) {

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
      renderer.setSize( 250 , 250 , false );
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
        mesh.material.color.setHex( this.value );
      });
      $("#quality_ll").on( 'change', function(e){
        renderer.setSize( 150 , 150 , false );
        console.log("very low")
      });
      $("#quality_l").on( 'change', function(e){
        renderer.setSize( 200 , 200 , false );
        console.log("low")
      });
      $("#quality_m").on( 'change', function(e){
        renderer.setSize( 250 , 250 , false );
        console.log("medium")
      });
      $("#quality_h").on( 'change', function(e){
        renderer.setSize( 375 , 375 , false );
        console.log("high")
      });
      $("#quality_hh").on( 'change', function(e){
        renderer.setSize( 500 , 500 , false );
        console.log("very high")
      });

    }

    function addDirectionalLight( x, y, z, color, intensity ) {
	    var directionalLight = new THREE.DirectionalLight( color, intensity );
	    directionalLight.position.set( x, y, z );
	    scene.add( directionalLight );
    }

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
