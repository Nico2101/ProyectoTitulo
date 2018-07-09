
<%@ include file="/views/libreria.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
<head>
<style>
#error {
	color: #FF0000;
	font-weight: bold;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/js/toastr.js"></script>
<title>Fundo Santa Emilia</title>

<meta name="description" content="User login page" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="assets/login/assets/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="assets/login/assets/font-awesome/4.5.0/css/font-awesome.min.css" />

<!-- text fonts -->
<link rel="stylesheet"
	href="assets/login/assets/css/fonts.googleapis.com.css" />

<!-- ace styles -->
<link rel="stylesheet" href="assets/login/assets/css/ace.min.css" />

<!--[if lte IE 9]>
                <link rel="stylesheet" href="assets/css/ace-part2.min.css" />
        <![endif]-->
<link rel="stylesheet" href="assets/login/assets/css/ace-rtl.min.css" />

<!--[if lte IE 9]>
          <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
        <![endif]-->

<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

<!--[if lte IE 8]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->
</head>

<body class="login-layout light-login">
	<div class="main-container">
		<div class="main-content">
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<br> <br> <br> <br> <br>
					<div class="center">
						<h1 class="header blue lighter bigger">Sistema para el
							control de siembras</h1>
						<h1 class="header blue lighter bigger">
							<i class="glyphicon glyphicon-grain"></i> Fundo Santa Emilia
						</h1>
					</div>
					<br>
					<div class="login-container">
						<div class="center">
							<div class="position-relative">
								<div id="login-box"
									class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">Ingrese sus datos</h4>

											<div class="space-6"></div>


											<c:if test="${not empty errorUsuario}">
												<script>
													toastr
															.error("Datos de sesión incorrectos");
												</script>
											</c:if>

											<c:if test="${not empty sesionExpirada}">
												<script>
													toastr
															.warning("Su sesión ha expirado");
												</script>
											</c:if>


											<c:if test="${not empty accesoNoAutorizado}">
												<script>
													toastr
															.warning("No tiene acceso a la url indicada");
												</script>
											</c:if>

											<form:form action="inicio" method="post"
												modelAttribute="empleado">
												<fieldset>
													<label class="block clearfix"> <span
														class="block input-icon input-icon-right"> <form:input
																name="rut" type="text" class="form-control" path="rut"
																placeholder="Rut" /> <form:errors path="rut" id="error" />
															<i class="ace-icon fa fa-user"></i>
													</span>
													</label> <label class="block clearfix"> <span
														class="block input-icon input-icon-right"> <form:input
																name="clave" type="password" class="form-control"
																placeholder="Contraseña" path="clave" /> <form:errors
																path="clave" id="error" /> <i
															class="ace-icon fa fa-lock"></i>
													</span>
													</label>


													<div class="space-4"></div>
												</fieldset>



												<div class="clearfix">

													<button type="Submit"
														class="width-35 pull-right btn btn-sm btn-primary">
														<i class="ace-icon fa fa-key"></i> <span
															class="bigger-110">Login</span>
													</button>

												</div>


												<div class="space-4"></div>

											</form:form>



											<div class="space-6"></div>


										</div>
										<!-- /.widget-main -->


									</div>
									<!-- /.widget-body -->
								</div>



							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="assets/js/jquery-2.1.4.min.js"></script>
	<script src="assets/rut.js"></script>

	<!-- <![endif]-->

	<!--[if IE]>
                                <script src="assets/js/jquery-1.11.3.min.js"></script>
                                <![endif]-->
	<script type="text/javascript">
		if ('ontouchstart' in document.documentElement)
			document
					.write("<script src='assets/js/jquery.mobile.custom.min.js'>"
							+ "<" + "/script>");
	</script>

	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		jQuery(function($) {
			$(document).on('click', '.toolbar a[data-target]', function(e) {
				e.preventDefault();
				var target = $(this).data('target');
				$('.widget-box.visible').removeClass('visible');//hide others
				$(target).addClass('visible');//show target
			});
		});
	</script>

	<script type="text/javascript">
		$("input#rut").rut({
			formatOn : 'keyup',
			minimumLength : 8, // validar largo mínimo; default: 2 
			validateOn : 'change' // si no se quiere validar, pasar null 
		});
	</script>
</body>


</html>
