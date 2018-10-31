<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="template/libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="template/cabecera.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<header class="main-header"> <%@ include
			file="template/barraSuperior.jsp"%> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <%@ include
			file="template/barraLateral.jsp"%> <!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">


			<!-- Main content -->
			<section class="content">

			<div class="row">
				<div class="col-xs-12">
					<h3>Análisis Reprogramaciones</h3>
					<div id="botonGenerarReporte" style="display: none"></div>
				</div>

			</div>
			<br>
			<br>
			<div class="row">
				<div class="col-md-6">
					<!-- DONUT CHART -->
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">Planes con actividades reprogramadas</h3>

							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<canvas id="pieChartPlanes" style="height: 221px; width: 443px;"
								width="553" height="276"></canvas>
						</div>
						<!-- /.box-body -->
					</div>
				</div>
				<div class="col-md-6">
					<!-- DONUT CHART -->
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">10 Actividades más reprogramadas</h3>

							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<canvas id="pieChartActividades"
								style="height: 221px; width: 443px;" width="553" height="276"></canvas>
						</div>
						<!-- /.box-body -->
					</div>
				</div>
			</div>

			</section>

		</div>

		<!-- /.content-wrapper -->

		<footer align="center" class="main-footer"
			style="background-color:#ecf0f5;"> <%@ include
			file="template/pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="template/scripts.jsp"%>

</body>

<script src="js/resumenReprogramacion.js">
	
</script>

</html>