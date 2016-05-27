<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/13
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
    <style>
        body {
            margin: 0;
            font:normal 75% Arial, Helvetica, sans-serif;
            background-color: #eee;
        }
        .form-signin-heading{
            padding-top: 50px;
            margin-left: 15%;
            margin-right: 30%;
            position: absolute;
            text-align: center;
            width: 50%;
        }
        .form-horizontal{
            max-width: 550px;
            /*margin: auto;*/
            margin-left: 20%;
            margin-right: 30%;
            margin-top: 150px;
        }
        .formButton{
            width: 30%;
            margin: auto;
            margin-left: 10%;
        }
        .checkbox{
            padding-left: 30%;
        }
        canvas {
            display: block;
            vertical-align: bottom;
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: #2aabd2;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: 50% 50%;
        }
    </style>
</head>
<body>

<%--<div id="particles-js">--%>
<%--</div>--%>

<%--<div id="containerCube"></div>--%>

<script src="js/three.js"></script>

<script src="js/Detector.js"></script>



<%--导航条,这里的导航条和主页其他导航条做区分--%>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbarCollapse1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp"><i class="fa fa-leaf" aria-hidden="true"></i>学生展示平台</a>
            </div>

            <div class="collapse navbar-collapse" id="navbarCollapse1">
                <ul class="nav navbar-nav navbar-right">
                    <a type='button' class='btn btn-primary navbar-btn' href='index.jsp'>返回</a>
                </ul>
            </div>
        </div>
    </div>
</nav>



<div class="container" style="color: white">

    <h1 class="form-signin-heading">欢迎您的到来</h1>
    <form class="form-horizontal" method="post" action="" onsubmit="return check();">
        <div class="form-group">
            <label for="userName" class="col-sm-3 control-label">用户名</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="userName" name="userName" placeholder="用户名" required>
            </div>
        </div>
        <div class="form-group">
            <label for="password" class="col-sm-3 control-label">密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码" required>
            </div>
        </div>
        <div class="form-group">
            <label for="password2" class="col-sm-3 control-label">重复密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="password2" placeholder="重复密码" required>
            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-sm-3 control-label">真实姓名</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="name" name="name" placeholder="真实姓名" required>
            </div>
        </div>

        <div class="form-group">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="isManager" value="manager"> 我要注册为管理员
                </label>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-12">
                <button class="btn btn-lg btn-success formButton" type="submit">注册</button>
                <a class="btn btn-lg btn-default formButton" href="index.jsp">取消</a>
            </div>
        </div>
    </form>
</div>

<%--<script src="js/particles.js"></script>--%>
<%--<script src="js/particlesSetting.js"></script>--%>

<script>
    function check() {
        var password1 = $('#password').val();
        var password2 = $('#password2').val();
        if(password1 != password2){
            swal("输入密码不一致", "请重新输入", "warning");
            return false;
        }else{
            return true;
        }
    }
</script>

<%--彩色魔方--%>
<script>
    if ( ! Detector.webgl ) Detector.addGetWebGLMessage();
    var container;
    var camera, scene, renderer;
    var mesh;
    init();
    animate();
    function init() {
        container = document.getElementById( 'containerCube' );
        //
        camera = new THREE.PerspectiveCamera( 27, window.innerWidth / window.innerHeight, 1, 3500 );
        camera.position.z = 2750;
        scene = new THREE.Scene();
        scene.fog = new THREE.Fog( 0x050505, 2000, 3500 );
        //
        scene.add( new THREE.AmbientLight( 0x444444 ) );
        var light1 = new THREE.DirectionalLight( 0xffffff, 0.5 );
        light1.position.set( 1, 1, 1 );
        scene.add( light1 );
        var light2 = new THREE.DirectionalLight( 0xffffff, 1.5 );
        light2.position.set( 0, -1, 0 );
        scene.add( light2 );
        //
        var triangles = 500000;
        var geometry = new THREE.BufferGeometry();
        var indices = new Uint32Array( triangles * 3 );
        for ( var i = 0; i < indices.length; i ++ ) {
            indices[ i ] = i;
        }
        var positions = new Float32Array( triangles * 3 * 3 );
        var normals = new Int16Array( triangles * 3 * 3 );
        var colors = new Uint8Array( triangles * 3 * 3 );
        var color = new THREE.Color();
        var n = 800, n2 = n/2;	// triangles spread in the cube
        var d = 12, d2 = d/2;	// individual triangle size
        var pA = new THREE.Vector3();
        var pB = new THREE.Vector3();
        var pC = new THREE.Vector3();
        var cb = new THREE.Vector3();
        var ab = new THREE.Vector3();
        for ( var i = 0; i < positions.length; i += 9 ) {
            // positions
            var x = Math.random() * n - n2;
            var y = Math.random() * n - n2;
            var z = Math.random() * n - n2;
            var ax = x + Math.random() * d - d2;
            var ay = y + Math.random() * d - d2;
            var az = z + Math.random() * d - d2;
            var bx = x + Math.random() * d - d2;
            var by = y + Math.random() * d - d2;
            var bz = z + Math.random() * d - d2;
            var cx = x + Math.random() * d - d2;
            var cy = y + Math.random() * d - d2;
            var cz = z + Math.random() * d - d2;
            positions[ i ]     = ax;
            positions[ i + 1 ] = ay;
            positions[ i + 2 ] = az;
            positions[ i + 3 ] = bx;
            positions[ i + 4 ] = by;
            positions[ i + 5 ] = bz;
            positions[ i + 6 ] = cx;
            positions[ i + 7 ] = cy;
            positions[ i + 8 ] = cz;
            // flat face normals
            pA.set( ax, ay, az );
            pB.set( bx, by, bz );
            pC.set( cx, cy, cz );
            cb.subVectors( pC, pB );
            ab.subVectors( pA, pB );
            cb.cross( ab );
            cb.normalize();
            var nx = cb.x;
            var ny = cb.y;
            var nz = cb.z;
            normals[ i ]     = nx * 32767;
            normals[ i + 1 ] = ny * 32767;
            normals[ i + 2 ] = nz * 32767;
            normals[ i + 3 ] = nx * 32767;
            normals[ i + 4 ] = ny * 32767;
            normals[ i + 5 ] = nz * 32767;
            normals[ i + 6 ] = nx * 32767;
            normals[ i + 7 ] = ny * 32767;
            normals[ i + 8 ] = nz * 32767;
            // colors
            var vx = ( x / n ) + 0.5;
            var vy = ( y / n ) + 0.5;
            var vz = ( z / n ) + 0.5;
            color.setRGB( vx, vy, vz );
            colors[ i ]     = color.r * 255;
            colors[ i + 1 ] = color.g * 255;
            colors[ i + 2 ] = color.b * 255;
            colors[ i + 3 ] = color.r * 255;
            colors[ i + 4 ] = color.g * 255;
            colors[ i + 5 ] = color.b * 255;
            colors[ i + 6 ] = color.r * 255;
            colors[ i + 7 ] = color.g * 255;
            colors[ i + 8 ] = color.b * 255;
        }
        geometry.setIndex( new THREE.BufferAttribute( indices, 1 ) );
        geometry.addAttribute( 'position', new THREE.BufferAttribute( positions, 3 ) );
        geometry.addAttribute( 'normal', new THREE.BufferAttribute( normals, 3, true ) );
        geometry.addAttribute( 'color', new THREE.BufferAttribute( colors, 3, true ) );
        geometry.computeBoundingSphere();
        var material = new THREE.MeshPhongMaterial( {
            color: 0xaaaaaa, specular: 0xffffff, shininess: 250,
            side: THREE.DoubleSide, vertexColors: THREE.VertexColors
        } );
        mesh = new THREE.Mesh( geometry, material );
        scene.add( mesh );
        //
        renderer = new THREE.WebGLRenderer( { antialias: false } );
        renderer.setClearColor( scene.fog.color );
        renderer.setPixelRatio( window.devicePixelRatio );
        renderer.setSize( window.innerWidth, window.innerHeight );
        renderer.gammaInput = true;
        renderer.gammaOutput = true;
        container.appendChild( renderer.domElement );
        //
        // stats = new Stats();
        // container.appendChild( stats.dom );
        //
        window.addEventListener( 'resize', onWindowResize, false );
    }
    function onWindowResize() {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize( window.innerWidth, window.innerHeight );
    }
    //
    function animate() {
        requestAnimationFrame( animate );
        render();
        // stats.update();
    }
    function render() {
        var time = Date.now() * 0.001;
        mesh.rotation.x = time * 0.25;
        mesh.rotation.y = time * 0.5;
        renderer.render( scene, camera );
    }
</script>

</body>
</html>