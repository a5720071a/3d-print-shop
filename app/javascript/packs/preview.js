const THREE = require('three')
const STLLoader = require('three-stl-loader')(THREE)

/*
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight, 0.1, 1000 );

var renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth/2, window.innerHeight/2 );
document.body.appendChild( renderer.domElement );

var geometry = new THREE.BoxGeometry( 1, 1, 1 );
var material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
var cube = new THREE.Mesh( geometry, material );
scene.add( cube );

camera.position.z = 5;

var animate = function () {
	requestAnimationFrame( animate );	

	cube.rotation.x += 0.01;
	cube.rotation.y += 0.01;

	renderer.render(scene, camera);
};

animate();
*/

document.addEventListener("turbolinks:load", function() {
  var model_url = document.getElementById("model_url").innerHTML;

  //if ( ! Detector.webgl ) Detector.addGetWebGLMessage();

  var container, stats;

  var camera, cameraTarget, scene, renderer;

  init();
  animate();

  function init() {

	  container = document.createElement( 'div' );
	  document.body.appendChild( container );

	  camera = new THREE.PerspectiveCamera( 35, window.innerWidth / window.innerHeight, 1, 15 );
	  camera.position.set( 3, 0.15, 3 );

	  cameraTarget = new THREE.Vector3( 0, -0.25, 0 );

	  scene = new THREE.Scene();
	  scene.background = new THREE.Color( 0x72645b );
	  scene.fog = new THREE.Fog( 0x72645b, 2, 15 );


	  // Ground

	  var plane = new THREE.Mesh(
		  new THREE.PlaneBufferGeometry( 40, 40 ),
		  new THREE.MeshPhongMaterial( { color: 0x999999, specular: 0x101010 } )
	  );
	  plane.rotation.x = -Math.PI/2;
	  plane.position.y = -0.5;
	  scene.add( plane );

	  plane.receiveShadow = true;


	  // ASCII file

	  //var loader = new THREE.STLLoader();
	  var loader = new STLLoader();
	  var material = new THREE.MeshPhongMaterial( { color: 0xAAAAAA, specular: 0x111111, shininess: 200 } );

	  // Colored binary STL
	  loader.load( model_url, function ( geometry ) {

		  var meshMaterial = material;
		  if (geometry.hasColors) {
			  meshMaterial = new THREE.MeshPhongMaterial({ opacity: geometry.alpha, vertexColors: THREE.VertexColors });
		  }

		  var mesh = new THREE.Mesh( geometry, meshMaterial );

		  mesh.position.set( 0, -0.5, 0 );
		  mesh.rotation.set( 0, 0, 0 );
		  mesh.scale.set( 0.01, 0.01, 0.01 );

		  mesh.castShadow = true;
		  mesh.receiveShadow = true;

		  scene.add( mesh );

	  } );

	  // Lights

	  scene.add( new THREE.HemisphereLight( 0x443333, 0x111122 ) );

	  addShadowedLight( 1, 1, 1, 0xffffff, 1.35 );
	  addShadowedLight( 0.5, 1, -1, 0xffaa00, 1 );
	  // renderer

	  renderer = new THREE.WebGLRenderer( { antialias: true } );
	  renderer.setPixelRatio( window.devicePixelRatio );
	  renderer.setSize( window.innerWidth * 0.5, window.innerHeight * 0.5 );

	  renderer.gammaInput = true;
	  renderer.gammaOutput = true;

	  renderer.shadowMap.enabled = true;
	  renderer.shadowMap.renderReverseSided = false;

	  container.appendChild( renderer.domElement );

	  // stats

	  //stats = new Stats();
	  //container.appendChild( stats.dom );

	  //

	  window.addEventListener( 'resize', onWindowResize, false );

  }

  function addShadowedLight( x, y, z, color, intensity ) {

	  var directionalLight = new THREE.DirectionalLight( color, intensity );
	  directionalLight.position.set( x, y, z );
	  scene.add( directionalLight );

	  directionalLight.castShadow = true;

	  var d = 1;
	  directionalLight.shadow.camera.left = -d;
	  directionalLight.shadow.camera.right = d;
	  directionalLight.shadow.camera.top = d;
	  directionalLight.shadow.camera.bottom = -d;

	  directionalLight.shadow.camera.near = 1;
	  directionalLight.shadow.camera.far = 4;

	  directionalLight.shadow.mapSize.width = 1024;
	  directionalLight.shadow.mapSize.height = 1024;

	  directionalLight.shadow.bias = -0.005;

  }

  function onWindowResize() {

	  camera.aspect = window.innerWidth / window.innerHeight;
	  camera.updateProjectionMatrix();

	  renderer.setSize( window.innerWidth, window.innerHeight );

  }

  function animate() {

	  requestAnimationFrame( animate );

	  render();
	  //stats.update();

  }

  function render() {

	  var timer = Date.now() * 0.0005;

	  camera.position.x = Math.cos( timer ) * 3;
	  camera.position.z = Math.sin( timer ) * 3;

	  camera.lookAt( cameraTarget );

	  renderer.render( scene, camera );

  }
})
