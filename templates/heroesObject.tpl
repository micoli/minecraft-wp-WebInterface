<script src="/wp/wp-content/plugins/minecraft-wp-WebInterface/skin2/backend/resources/jquery-1.5.1.min.js"></script>
<script src="/wp/wp-content/plugins/minecraft-wp-WebInterface/skin2/backend/resources/jquery-cookie.min.js"></script>
<script type="text/javascript" src="/wp/wp-content/plugins/minecraft-wp-WebInterface/skin2/backend/resources/3d/Three.js"></script>
<script type="text/javascript" src="/wp/wp-content/plugins/minecraft-wp-WebInterface/skin2/backend/resources/3d/RequestAnimationFrame.js"></script>
{literal}
<span id="divRenderer" style="height:200px;width:200px;border:red solid 1px;float:right;"></span>
<script type="text/javascript">
function minecraftPlayer() {
		
  this.container
  this.info;
  this.camera;
  this.scene
  this.renderer;
  this.xvar= 0;
  this.targetRotationX = 0;
  this.targetRotationXOnMouseDown = 0;
  this.targetRotationY = 0;
  this.targetRotationYOnMouseDown = 0;
  this.mouseX = 0;
  this.mouseXOnMouseDown = 0;
  this.mouseY = 0;
  this.mouseYOnMouseDown = 0;
  this.container = document.getElementById( 'divRenderer' );
  this.windowHalfX = window.innerWidth / 2;
  this.windowHalfY = window.innerHeight / 2;
  
  this.run = function(){
    this.init();
    this.animate();
  }
  
  this.init= function() {
    this.nameStr = '{/literal}{$data.name}{literal}';
    this.userImagePath = '/wp/wp-content/plugins/minecraft-wp-WebInterface/skin2/images/skins/'+this.nameStr;
    this.camera = new THREE.Camera(20, this.container.innerWidth / this.container.innerHeight, 1, 1000 );
    this.camera.target.position.x = 0;
    this.camera.target.position.y = -11;
    this.camera.target.position.z = 0;
    this.scene = new THREE.Scene();

    //Hat
    this.hat_materials = [];
    this.hat_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/hat_right.png')})]);
    this.hat_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/hat_left.png')})]);
    this.hat_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/hat_top.png')})]);
    this.hat_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/hat_bottom.png')})]);
    this.hat_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/hat_back.png')})]);
    this.hat_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/hat_front.png')})]);

    this.hat = new THREE.Mesh( new THREE.CubeGeometry(9, 9, 9, 0, 0, 0, this.hat_materials), new THREE.MeshFaceMaterial());
    this.hat.position.x = 0;
    this.hat.position.y = 0;
    this.hat.position.z = 0;
	this.hat.overdraw = true;
    this.scene.addObject(this.hat);

    //Body
    this.body_materials = [];
    this.body_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/body_right.png')})]);
    this.body_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/body_left.png')})]);
    this.body_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/body_top.png')})]);
    this.body_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/body_bottom.png')})]);
    this.body_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/body_back.png')})]);
    this.body_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/body_front.png')})]);

    this.body = new THREE.Mesh( new THREE.CubeGeometry(8, 12, 4, 0, 0, 0, this.body_materials), new THREE.MeshFaceMaterial());
    this.body.position.x = 0;
    this.body.position.y = -10;
    this.body.position.z = 0;
	this.body.overdraw = true;
    this.scene.addObject(this.body);

    //Arm_Left
    this.arm_left_materials = [];
    this.arm_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_left_inner.png')})]);
    this.arm_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_left_outer.png')})]);
    this.arm_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_left_top.png')})]);
    this.arm_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_left_bottom.png')})]);
    this.arm_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_left_back.png')})]);
    this.arm_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_left_front.png')})]);

    this.arm_left = new THREE.Mesh( new THREE.CubeGeometry(4, 12, 4, 0, 0, 0, this.arm_left_materials), new THREE.MeshFaceMaterial());
    this.arm_left.position.x = 6;
    this.arm_left.position.y = -10;
    this.arm_left.position.z = 0;
	this.arm_left.overdraw = true;
    this.scene.addObject(this.arm_left);

    //Arm_Right
    this.arm_right_materials = [];
    this.arm_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_right_outer.png')})]);
    this.arm_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_right_inner.png')})]);
    this.arm_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_right_top.png')})]);
    this.arm_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_right_bottom.png')})]);
    this.arm_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_right_back.png')})]);
    this.arm_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/arm_right_front.png')})]);

    this.arm_right = new THREE.Mesh( new THREE.CubeGeometry(4, 12, 4, 0, 0, 0, this.arm_right_materials), new THREE.MeshFaceMaterial());
    this.arm_right.position.x = -6;
    this.arm_right.position.y = -10;
    this.arm_right.position.z = 0;
	this.arm_right.overdraw = true;
    this.scene.addObject(this.arm_right);

    //Leg_Left
    this.leg_left_materials = [];
    this.leg_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_left_inner.png')})]);
    this.leg_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_left_outer.png')})]);
    this.leg_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_left_top.png')})]);
    this.leg_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_left_bottom.png')})]);
    this.leg_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_left_back.png')})]);
    this.leg_left_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_left_front.png')})]);

    this.leg_left = new THREE.Mesh( new THREE.CubeGeometry(4, 12, 4, 0, 0, 0, this.leg_left_materials), new THREE.MeshFaceMaterial());
    this.leg_left.position.x = 2;
    this.leg_left.position.y = -22;
    this.leg_left.position.z = 0;
	this.leg_left.overdraw = true;
    this.scene.addObject(this.leg_left);

    //Leg_Right
    this.leg_right_materials = [];
    this.leg_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_right_inner.png')})]);
    this.leg_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_right_outer.png')})]);
    this.leg_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_right_top.png')})]);
    this.leg_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_right_bottom.png')})]);
    this.leg_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_right_back.png')})]);
    this.leg_right_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/leg_right_front.png')})]);

    this.leg_right = new THREE.Mesh( new THREE.CubeGeometry(4, 12, 4, 0, 0, 0, this.leg_right_materials), new THREE.MeshFaceMaterial());
    this.leg_right.position.x = -2;
    this.leg_right.position.y = -22;
    this.leg_right.position.z = 0;
	this.leg_right.overdraw = true;
    this.scene.addObject(this.leg_right);

    //Head
    this.head_materials = [];
    this.head_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/head_right.png')})]);
    this.head_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/head_left.png')})]);
    this.head_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/head_top.png')})]);
    this.head_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/head_bottom.png')})]);
    this.head_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/head_back.png')})]);
    this.head_materials.push([new THREE.MeshBasicMaterial({map: THREE.ImageUtils.loadTexture(this.userImagePath+'/head_front.png')})]);

    this.head = new THREE.Mesh( new THREE.CubeGeometry(8, 8, 8, 0, 0, 0, this.head_materials), new THREE.MeshFaceMaterial());
    this.head.position.x = 0;
    this.head.position.y = 0;
    this.head.position.z = 0;
	this.head.overdraw = true;
    this.scene.addObject(this.head);
	
    //renderer = <?php if(isset($_GET['webgl'])) echo 'new THREE.WebGLRenderer();'; else echo 'new THREE.CanvasRenderer();'; ?>
    this.renderer = new THREE.CanvasRenderer();
    this.renderer.setSize( 200, 200 );
    this.container.appendChild( this.renderer.domElement );
    document.addEventListener( 'mousedown', this.onDocumentMouseDown, false );
    document.addEventListener( 'touchstart', this.onDocumentTouchStart, false );
    document.addEventListener( 'touchmove', this.onDocumentTouchMove, false );
  }

  this.onDocumentMouseDown=function( event ) {
    event.preventDefault();
    document.addEventListener( 'mousemove', this.onDocumentMouseMove, false );
    document.addEventListener( 'mouseup', this.onDocumentMouseUp, false );
    document.addEventListener( 'mouseout', this.onDocumentMouseOut, false );
    this.mouseXOnMouseDown = event.clientX - this.windowHalfX;
    this.targetRotationXOnMouseDown = this.targetRotationX;
    this.mouseYOnMouseDown = event.clientY - this.windowHalfY;
    this.targetRotationYOnMouseDown = this.targetRotationY;
  }

  this.onDocumentMouseMove=function( event ) {
    this.mouseX = event.clientX - this.windowHalfX;
    this.targetRotationX = this.targetRotationXOnMouseDown + ( this.mouseX - this.mouseXOnMouseDown ) * 0.02;
    this.mouseY = event.clientY - this.windowHalfY;
    this.targetRotationY = this.targetRotationYOnMouseDown + ( this.mouseY - this.mouseYOnMouseDown ) * 0.02;
  }

  this.onDocumentMouseUp=function( event ) {
    document.removeEventListener( 'mousemove', this.onDocumentMouseMove, false );
    document.removeEventListener( 'mouseup', this.onDocumentMouseUp, false );
    document.removeEventListener( 'mouseout', this.onDocumentMouseOut, false );
  }

  this.onDocumentMouseOut=function( event ) {
    document.removeEventListener( 'mousemove', this.onDocumentMouseMove, false );
    document.removeEventListener( 'mouseup', this.onDocumentMouseUp, false );
    document.removeEventListener( 'mouseout', this.onDocumentMouseOut, false );
  }

  this.onDocumentTouchStart=function( event ) {
    if ( event.touches.length == 1 ) {
      event.preventDefault();
      this.mouseXOnMouseDown = event.touches[ 0 ].pageX - this.windowHalfX;
      this.mouseYOnMouseDown = event.touches[ 0 ].pageY - this.windowHalfY;
      this.targetRotationXOnMouseDown = this.targetRotationX;
      this.targetRotationYOnMouseDown = this.targetRotationY;
    }
  }

  this.onDocumentTouchMove=function( event ) {
    if ( event.touches.length == 1 ) {
      event.preventDefault();
      this.mouseX = event.touches[ 0 ].pageX - windowHalfX;
      this.targetRotationX = this.targetRotationXOnMouseDown + ( this.mouseX - this.mouseXOnMouseDown ) * 0.05;
      this.targetRotationY = this.targetRotationYOnMouseDown + ( this.mouseY - this.mouseYOnMouseDown ) * 0.05;
    }
  }

  this.animate=function() {
    requestAnimationFrame( this.animate );
    this.render();
  }

  this.render=function() {
    this.camera.position.x = 0 - 100*Math.sin(this.targetRotationX);
    this.camera.position.y = 0 - 50*Math.sin(this.targetRotationY);
    this.camera.position.z = 0 - 100*Math.cos(this.targetRotationX);

    this.xvar+= Math.PI/180

    //Leg Swing
    this.leg_left.rotation.x = Math.cos(this.xvar);
    this.leg_left.position.z = 0 - 6*Math.sin(this.leg_left.rotation.x);
    this.leg_left.position.y = -16 - 6*Math.abs(Math.cos(this.leg_left.rotation.x));
    this.leg_right.rotation.x = Math.cos(this.xvar + (Math.PI));
    this.leg_right.position.z = 0 - 6*Math.sin(this.leg_right.rotation.x);
    this.leg_right.position.y = -16 - 6*Math.abs(Math.cos(this.leg_right.rotation.x));

    //Arm Swing
    this.arm_left.rotation.x = Math.cos(this.xvar + (Math.PI));
    this.arm_left.position.z = 0 - 6*Math.sin(this.arm_left.rotation.x);
    this.arm_left.position.y = -4 - 6*Math.abs(Math.cos(this.arm_left.rotation.x));
    this.arm_right.rotation.x = Math.cos(this.xvar);
    this.arm_right.position.z = 0 - 6*Math.sin(this.arm_right.rotation.x);
    this.arm_right.position.y = -4 - 6*Math.abs(Math.cos(this.arm_right.rotation.x));

    this.renderer.render( this.scene, this.camera );
  }
}
var t = new minecraftPlayer();
t.run();
  //Background
  jQuery(document).ready(
   function($) {  
    // Background Selection
    if($.cookie('background') !== null) {
     //jQuery("body").css("background-image", "url('images/"+$.cookie('background')+"')");
    }
   }
  );
  </script>
{/literal}
